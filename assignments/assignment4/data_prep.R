#### This script prepares the data for assignment 4.
# Inflation data: https://fred.stlouisfed.org/series/CPIAUCSL
# Presidential approval data: https://projects.fivethirtyeight.com/biden-approval-rating/

library(tidyverse)
here::i_am("assignments/assignment4/data_prep.R")
read_csv(here::here("assignments/assignment4/CPIAUCSL_PC1.csv")) |>
  mutate(YEAR = year(observation_date),
         MONTH = month(observation_date)) |>
  select(-observation_date) |>
  pivot_wider(names_from = MONTH, values_from = CPIAUCSL_PC1) |>
  write_csv(here::here("assignments/assignment4/inflation.csv"))

read_csv(here::here("assignments/assignment4/approval_topline.csv")) |>
  mutate(year = year(end_date),
         month = month(end_date),
         day = day(end_date)) |>
  filter(subgroup == "All polls") |>
  select(year, month, day, everything(), -end_date, -polltype, -subgroup, -timestamp, -subpopulation) |>
  write_csv(here::here("assignments/assignment4/presidential_approval.csv"))
