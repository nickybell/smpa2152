#### This script prepares 2020 election results for the final exam based on  historical presidential election results compiled by the MIT Election Data + Science Lab

library(tidyverse)
here::i_am("assignments/data1010_final/data/raw/prep_2020_results.R")
dta <- read_csv(here::here("assignments/data1010_final/data/raw/1976-2020-president.csv"))

# Each state's 2020 vote share
dta |>
  filter(year == 2020 & party_detailed %in% c("DEMOCRAT", "REPUBLICAN")) |>
  group_by(state, candidate) |>
  summarize(voteshare = candidatevotes/totalvotes) |>
  mutate(two_party_vote = voteshare/sum(voteshare)) |>
  ungroup() |>
  mutate(candidate_name = str_to_title(str_extract(candidate, "(.*),.*", 1))) |>
  select(-voteshare, -candidate) |>
  write_csv(here::here("assignments/data1010_final/data/2020-president.csv"))
