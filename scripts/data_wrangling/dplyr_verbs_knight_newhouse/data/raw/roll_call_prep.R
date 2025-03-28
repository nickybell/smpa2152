# This script prepares the 118th House roll call data from Voteview for lecture.
library(tidyverse)
here::i_am("scripts/data_wrangling/data/raw/roll_call_prep.R")
rc <- read_csv(here::here("scripts/data_wrangling/data/raw/H118_rollcalls.csv"))

rc |>
  mutate(bill_number = str_replace(bill_number, "([:alpha:]*)(\\d*)", "\\1 \\2"),
         chamber = str_to_upper(chamber)) |>
  separate_wider_delim(date, "-", names = c("year", "month", "day")) |>
  select(-dtl_desc, nominate_log_likelihood, -rollnumber, -clerk_rollnumber) |>
  write_csv(here::here("scripts/data_wrangling/house_roll_call_votes.csv"))
