# To modify the county pres data from MIT election lab
library(tidyverse)

read_csv(here::here("labs/maps/raw/countypres_2000-2024.csv")) |>
  filter(
    party %in%
      c("DEMOCRAT", "REPUBLICAN") &
      !is.na(county_fips) &
      state_po != "KS"
  ) |>
  select(
    year,
    state,
    state_po,
    county_name,
    county_fips,
    candidate,
    party,
    candidatevotes
  ) |>
  mutate(
    party = str_to_lower(party),
    county_fips = case_when(
      state_po == "CA" & county_name == "SUTTER" ~ 6101,
      state_po == "CA" & county_name == "TEHAMA" ~ 6103,
      state_po == "CA" & county_name == "TRINITY" ~ 6105,
      state_po == "CA" & county_name == "TULARE" ~ 6107,
      state_po == "CA" & county_name == "TUOLUMNE" ~ 6109,
      state_po == "CA" & county_name == "VENTURA" ~ 6111,
      state_po == "CA" & county_name == "YOLO" ~ 6113,
      state_po == "CA" & county_name == "YUBA" ~ 6115,
      TRUE ~ county_fips
    )
  ) |>
  pivot_wider(
    names_from = party,
    values_from = c(candidate, candidatevotes),
    names_glue = "{party}_{.value}",
    values_fn = list(candidate = unique, candidatevotes = sum)
  ) |>
  write_csv(here::here("labs/maps/countypres.csv"))
