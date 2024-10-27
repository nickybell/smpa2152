#### This script prepares the data for assignment 4.
# Inflation data: https://fred.stlouisfed.org/series/CPIAUCSL
# Presidential approval data: https://projects.fivethirtyeight.com/biden-approval-rating/

library(tidyverse)
here::i_am("assignments/assignment4/data_prep.R")
read_csv(here::here("assignments/assignment4/CPIAUCSL.csv")) |>
  mutate(YEAR = year(DATE),
         month = month(DATE)) |>
  select(-DATE) |>
  pivot_wider(names_from = month, values_from = CPIAUCSL_PC1) |>
  write_csv(here::here("assignments/assignment4/inflation.csv"))

read_csv(here::here("assignments/assignment4/approval_topline.csv")) |>
  mutate(year = year(end_date),
         month = month(end_date),
         day = day(end_date)) |>
  filter(subgroup == "All polls") |>
  select(year, month, day, everything(), -end_date, -polltype, -subgroup, -timestamp, -subpopulation) |>
  write_csv(here::here("assignments/assignment4/presidential_approval.csv"))
