# To modify the county pres data from MIT election lab
library(dplyr)
library(readr)
read_csv("scripts/maps/countypres_2000-2024.csv") |>
  group_by(
    year,
    state,
    state_po,
    county_name,
    county_fips,
    office,
    candidate,
    party
  ) |>
  summarize(
    candidatevotes = sum(candidatevotes),
    totalvotes = mean(totalvotes)
  ) |>
  write_csv("scripts/maps/countypres.csv")


petitions <- read_csv(here::here("scripts/maps/petitions.csv")) |>
  select(
    county_fips,
    state_fips,
    TAW.Suffix,
    TAW,
    Company.Name,
    Second.Name,
    Address,
    City,
    State,
    Zip,
    Petition.Date,
    Est..No..Workers,
    Combo.2.Digit.NAICS
  ) |>
  filter(
    year(dmy(Petition.Date)) >= 2009 &
      !is.na(state_fips) &
      !is.na(county_fips) &
      !is.na(Combo.2.Digit.NAICS)
  )
cbp <- read_csv(here::here("scripts/maps/cbp09co.txt")) |>
  filter(str_detect(naics, "^(\\d{2}|-{2})-{4}$") & fipscty != "999") |>
  mutate(
    naics_new = as.integer(str_replace_all(naics, "-", "")),
    emp = case_when(
      empflag == "A" ~ 10,
      empflag == "B" ~ 60,
      empflag == "C" ~ 175,
      empflag == "E" ~ 375,
      empflag == "F" ~ 750,
      empflag == "G" ~ 1750,
      empflag == "H" ~ 3750,
      empflag == "I" ~ 7500,
      empflag == "J" ~ 17500,
      empflag == "K" ~ 37500,
      empflag == "L" ~ 75000,
      empflag == "M" ~ 100000,
      .default = emp
    )
  ) |>
  select(fipstate, fipscty, naics_new, emp)

dta <- full_join(
  petitions,
  filter(cbp, is.na(naics_new)),
  by = join_by(
    state_fips == fipstate,
    county_fips == fipscty
  )
) |>
  select(-naics_new) |>
  rename(total_emp = emp) |>
  left_join(
    filter(cbp, naics_new != ""),
    by = join_by(
      state_fips == fipstate,
      county_fips == fipscty,
      Combo.2.Digit.NAICS == naics_new
    )
  ) |>
  rename(manufacturing_emp = emp) |>
  filter(Combo.2.Digit.NAICS == 31 | is.na(Combo.2.Digit.NAICS)) |>
  replace_na(list("Est..No..Workers" = 0, "manufacturing_emp" = 1)) |>
  group_by(state_fips, county_fips, total_emp, manufacturing_emp, .drop = F) |>
  summarize(
    elig_workers = sum(Est..No..Workers, na.rm = T),
    prop_manuf_loss = min(elig_workers / manufacturing_emp, 1),
    prop_total_loss = min(elig_workers / total_emp, 1)
  ) |>
  ungroup()

dta |>
  select(-elig_workers) |>
  write_csv(here::here("scripts/maps/trade_job_losses.csv"))
