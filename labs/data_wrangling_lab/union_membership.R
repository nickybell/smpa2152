# as of 09/22/25
library(dplyr)
library(readr)
haven::read_dta("https://www.unionstats.com/state/dta/state_1983_2024.dta") |>
  filter(sector == "Total") |>
  select(state_cens, state, state2, empl, member, year) |>
  write_csv(here::here("labs", "data_wrangling_lab", "union_membership.csv"))
