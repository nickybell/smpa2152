library(tidyverse)

read_csv(here::here("labs/political_polling_lab/raw/31115721.csv")) |>
  mutate(
    income = case_when(
      income2 == "100 thousand or more" ~ income2,
      TRUE ~ income
    ),
    across(
      c(q9, income),
      ~ case_when(
        str_detect(.x, "VOL") ~ NA_character_,
        TRUE ~ .x
      )
    ),
    q10net = case_when(
      str_detect(q10net, "Yes") ~ "Yes",
      str_detect(q10net, "KD") ~ NA,
      str_detect(q10net, "No") ~ "No",
      TRUE ~ NA
    ),
    partlean = case_when(
      str_detect(partlean, "Democrat") ~ "Democrat",
      str_detect(partlean, "Republican") ~ "Republican",
      str_detect(partlean, "independent") ~ "Independent",
      TRUE ~ NA
    ),
    age = as.numeric(q910),
    educnew = case_when(
      str_detect(educnew, "DK") ~ NA_character_,
      TRUE ~ str_to_title(educnew)
    ),
    q9 = case_when(
      str_detect(q9, "Democrats") ~ "Democrats",
      str_detect(q9, "Republicans") ~ "Republicans",
      TRUE ~ NA_character_
    )
  ) |>
  rename(
    id = respo,
    shutdown_blame = q9,
    shutdown_inconv = q10net,
    region = censusr,
    gender = q924net,
    pid = partlean,
    educ = educnew
  ) |>
  select(
    id,
    shutdown_blame,
    shutdown_inconv,
    region,
    gender,
    age,
    educ,
    pid,
    income,
    weight
  ) |>
  write_csv(here::here("labs/political_polling_lab/31115721.csv"))
