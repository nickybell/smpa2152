### This script prepares the historical presidential polls date for assignment 5.
library(tidyverse)
here::i_am("assignments/assignment5/prep_polls.R")
polls <- read_csv(here::here("assignments/assignment5/raw/president_polls_historical.csv"))

polls |>
  filter(year(mdy(end_date)) == 2020 & stage == "general") |>
  select(question_id, pollster, numeric_grade, methodology, state, start_date, end_date, sample_size, population, internal, partisan, office_type, answer, pct) |>
  write_csv(here::here("assignments/assignment5/presidential_polls_2020.csv"))
