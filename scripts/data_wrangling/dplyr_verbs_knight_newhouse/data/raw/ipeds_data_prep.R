#### This script prepares the IPEDS data to be joined to the Knight-Newhouse data
here::i_am()
read_csv(here::here("scripts/data_wrangling/data/raw/ipeds.csv")) |>
  rename(
    id = unitid,
    institution_name = `institution name`,
    hbcu = `HD2022.Historically Black College or University`,
    undergraduates = `DRVEF122022.Full-time undergraduate 12-month unduplicated headcount`,
    tuition = `DRVIC2022.Tuition and fees, 2022-23`) |>
  select(id, institution_name, year, hbcu, undergraduates, tuition) |>
  write_csv(here::here("scripts/data_wrangling/data/ipeds.csv"))

            