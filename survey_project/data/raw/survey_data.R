library(readxl)
library(dplyr)
library(googlesheets4)
library(survey)
library(tidyr)

pop_gender_major <- read_sheet(
  "https://docs.google.com/spreadsheets/d/1-F85EyPfdRKV_B9xyJS_gGRMbjGWSVNJwdzQGPRAVUE/edit?usp=sharing",
  range = "Sheet1!B:D"
) |>
  rename(major = Code, `1` = Men, `3` = Women) |>
  pivot_longer(c(`1`, `3`), names_to = "gender", values_to = "Freq") |>
  mutate(gender = as.numeric(gender))

dta <- read_xlsx(
  here::here("survey_project/data/raw/survey_results.xlsx"),
  .name_repair = janitor::make_clean_names
) |>
  mutate(
    h_w_off_campus = as.numeric(hw_off_campus),
    major = ifelse(!(major %in% pop_gender_major$major), 68, major)
  ) |>
  relocate(h_w_off_campus, .after = h_w_on_campus) |>
  select(-hw_off_campus) |>
  filter(
    if_any(everything(), \(x) !is.na(x)) &
      if_all(c(year, gender, major), \(x) !is.na(x)) &
      gender %in% c(1, 3) &
      year %in% 1:5
  )

unweighted_design <- svydesign(
  ids = ~1,
  data = dta
)

# Keep sample size constant - weight to relative proportions
sample_size <- nrow(dta)

pop_year <- data.frame(
  year = 1:5,
  Freq = c(.25, .2, .2, .2, .15) / sample_size
)

pop_gender <- data.frame(
  gender = c(1, 3),
  Freq = c(3990, 6858) / (3990 + 6858) * sample_size
)

# Scale pop_gender_major to sample size
pop_gender_major_scaled <- pop_gender_major |>
  mutate(Freq = Freq / sum(Freq) * sample_size)

year_gender_weights <- unweighted_design |>
  postStratify(
    strata = ~year,
    population = pop_year,
    partial = TRUE
  ) |>
  postStratify(
    strata = ~gender,
    population = pop_gender,
    partial = TRUE
  )

year_gender_x_major_weights <- unweighted_design |>
  postStratify(
    strata = ~year,
    population = pop_year,
    partial = TRUE
  ) |>
  postStratify(
    strata = ~ gender + major,
    population = pop_gender_major_scaled, # Use the scaled version!
    partial = TRUE
  )

dta$year_gender_weight <- weights(year_gender_weights)
dta$year_gender_x_major_weight <- weights(year_gender_x_major_weights)

readr::write_csv(dta, here::here("survey_project/data/survey_data.csv"))
