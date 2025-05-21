# DeSante, Christopher, 2013, "Replication data for: Working Twice as Hard to Get Half as Far: Race, Work Ethic, and America’s Deserving Poor", https://doi.org/10.7910/DVN/AZTWDW

library(tidyverse)
library(haven)
dta <- read_dta("scripts/hypothesis_testing/desante_experimental_data.dta")

dta2 <-
  dta %>%
  mutate(respondent_id = 1:nrow(dta),
         min_income = as.numeric(paste0(str_extract(as_factor(v246), "\\$(\\d*),\\d*", 1), "000")),
         max_income = as.numeric(paste0(str_extract(as_factor(v246), "\\$\\d*,\\d* - \\$(\\d*),\\d*", 1), "000"))) %>%
  rowwise() %>%
  mutate(income = case_when(
    is.na(min_income) ~ NA,
    is.na(max_income) ~ min_income,
    .default = round(runif(1, min_income, max_income), 0)
  )) %>%
  ungroup %>%
  mutate(income_1000s = income/1000) %>%
  pivot_longer(cols = c(app1, app2), names_to = "app", values_to = "allocation") %>%
  mutate(race = case_when(treatment %in% c(4:9) & app == "app1" ~ "white",
                          treatment %in% c(10:12) & app == "app1" ~ "black",
                          treatment %in% c(4:6) & app == "app2" ~ "white",
                          treatment %in% c(7:12) & app == "app2" ~ "black"),
         work_ethic = case_when(treatment %in% c(2,5,8,11) & app == "app1" ~ "excellent",
                                treatment %in% c(2,5,8,11) & app == "app2" ~ "poor",
                                treatment %in% c(3,6,9,12) & app == "app1" ~ "poor",
                                treatment %in% c(3,6,9,12) & app == "app2" ~ "excellent"),
         pid = case_when(V212d %in% c(1:3) ~ "Democrat",
                         V212d == 4 ~ "Independent",
                         V212d %in% c(5:7) ~ "Republican"),
         age = if_else(!v207 %in% 9998:9999, 2010-v207, NA),
         gender = case_match(v208,
                             1 ~ "Male",
                             2 ~ "Female")) %>%
  rename(bal_bud = app3) %>%
  select(respondent_id, treatment, race, work_ethic, allocation, bal_bud, pid, age, gender, income_1000s)

purrr::walk(c("hypothesis_testing", "regression"), \(x) {
  write_csv(dta2, paste0("scripts/", x, "/desante2013_modified.csv"))
})