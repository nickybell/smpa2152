### This script prepares the historical presidential polls date for assignment 5.
library(tidyverse)
here::i_am("assignments/makeup/prep_polls.R")
polls <- read_csv(here::here("assignments/makeup/raw/president_polls_historical.csv"))

polls |>
  filter(year(mdy(end_date)) == 2020 & stage == "general") |>
  select(question_id, pollster, numeric_grade, methodology, state, end_date, sample_size, answer, pct) |>
  mutate(end_date = mdy(end_date),
         month = month(end_date),
         year = year(end_date),
         state = str_to_upper(state)) |>
  pivot_wider(names_from = answer, values_from = pct) |>
  select(question_id, pollster, numeric_grade, methodology, state, month, year, sample_size, Biden, Trump) |>
  write_csv(here::here("assignments/makeup/presidential_polls_2020.csv"))
