library(dplyr)
library(readr)

read_csv(here::here(
  "scripts/political_polling/raw/anes_timeseries_2024_csv_20250808.csv"
)) |>
  rename(
    id = V240001,
    party_id = V241227x,
    race = V241501x,
    age = V241458x,
    educ = V241465x,
    gender = V241551,
    income = V241566x,
    pres_vote = V241075x,
    economy = V241143x,
    immigration = V241152x,
    crime = V241155x,
    attention_to_politics = V241004,
    weights = V240106a
  ) |>
  mutate(
    party_id = case_match(
      party_id,
      1 ~ "Strong Democrat",
      2 ~ "Not very strong Democrat",
      3 ~ "Independent-Democrat",
      4 ~ "Independent",
      5 ~ "Independent-Republican",
      6 ~ "Not very strong Republican",
      7 ~ "Strong Republican",
      .default = NA_character_
    ),
    race = case_match(
      race,
      1 ~ "White, non-Hispanic",
      2 ~ "Black, non-Hispanic",
      3 ~ "Hispanic",
      4 ~ "Asian or Native Hawaiian/other Pacific Islander, non-Hispanic",
      5 ~ "Native American/Alaska Native or other race, non-Hispanic",
      6 ~ "Multiple races, non-Hispanic",
      .default = NA_character_
    ),
    educ = case_match(
      educ,
      1 ~ "Less than high school credential",
      2 ~ "High school credential",
      3 ~ "Some post-high school, no bachelor’s degree",
      4 ~ "Bachelor’s degree",
      5 ~ "Graduate degree",
      .default = NA_character_
    ),
    age = ifelse(age == -2, NA_integer_, age),
    gender = case_match(
      gender,
      1 ~ "Man",
      2 ~ "Woman",
      3 ~ "Nonbinary",
      4 ~ "Something else",
      .default = NA_character_
    ),
    income = case_match(
      income,
      1 ~ 2500,
      2 ~ 7500,
      3 ~ 11250,
      4 ~ 13750,
      5 ~ 16250,
      6 ~ 18750,
      7 ~ 21250,
      8 ~ 23750,
      9 ~ 26250,
      10 ~ 28750,
      11 ~ 32500,
      12 ~ 37500,
      13 ~ 42500,
      14 ~ 47500,
      15 ~ 52500,
      16 ~ 57500,
      17 ~ 62500,
      18 ~ 67500,
      19 ~ 72500,
      20 ~ 77500,
      21 ~ 85000,
      22 ~ 95000,
      23 ~ 105000,
      24 ~ 117500,
      25 ~ 137500,
      26 ~ 162500,
      27 ~ 212500,
      28 ~ 250000,
      .default = NA_real_
    ),
    pres_vote = case_match(
      pres_vote,
      10 ~ "Kamala Harris",
      11 ~ "Donald Trump",
      12 ~ "Other",
      20 ~ "Kamala Harris",
      21 ~ "Donald Trump",
      22 ~ "Other",
      .default = NA_character_
    ),
    economy = case_match(
      economy,
      1 ~ "Approve strongly",
      2 ~ "Approve not strongly",
      3 ~ "Disapprove not strongly",
      4 ~ "Disapprove strongly",
      .default = NA_character_
    ),
    immigration = case_match(
      immigration,
      1 ~ "Approve strongly",
      2 ~ "Approve not strongly",
      3 ~ "Disapprove not strongly",
      4 ~ "Disapprove strongly",
      .default = NA_character_
    ),
    crime = case_match(
      crime,
      1 ~ "Approve strongly",
      2 ~ "Approve not strongly",
      3 ~ "Disapprove not strongly",
      4 ~ "Disapprove strongly",
      .default = NA_character_
    ),
    attention_to_politics = case_match(
      attention_to_politics,
      1 ~ "Always",
      2 ~ "Most of the time",
      3 ~ "About half the time",
      4 ~ "Some of the time",
      5 ~ "Never",
      .default = NA_character_
    )
  ) |>
  select(matches("^[^V].*$")) |>
  filter(!is.na(weights)) |>
  write_csv(here::here("scripts/political_polling/anes_2024.csv"))
