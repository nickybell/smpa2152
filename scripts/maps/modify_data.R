# To modify the county pres data from MIT election lab
read_csv("scripts/maps/countypres_2000-2020.csv") |>
  group_by(year, state, state_po, county_name, county_fips, office, candidate, party) |>
  summarize(candidatevotes = sum(candidatevotes),
            totalvotes = mean(totalvotes)) |>
  write_csv("scripts/maps/countypres.csv")
