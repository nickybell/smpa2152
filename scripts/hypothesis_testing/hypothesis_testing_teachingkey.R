# File Name: 	  	  hypothesis_testing.R
# File Purpose:  	  Hypothesis Testing
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)

# Today, we will be working with the replication dataset for De Sante's (2013) experiment examining how people choose to allocate social benefits according to ideas about "deservingness"

# Citation: DeSante, Christopher, 2013, "Replication data for: Working Twice as Hard to Get Half as Far: Race, Work Ethic, and America’s Deserving Poor", https://doi.org/10.7910/DVN/AZTWDW.

# Load packages
library(tidyverse)
library(infer) # for the function t_test()

# Set options
options(tibble.width = Inf)

# Load the data
desante <- read_csv("desante2013_modified.csv")

# Exploratory Data Analysis -----------------------------------------------

desante |>
  filter(!is.na(race)) |>
	group_by(race) |>
  summarize(allocation = mean(allocation, na.rm = T)) |>
	ggplot() +
	geom_col(aes(x = race, y = allocation))

desante |>
  filter(!is.na(work_ethic)) |>
  group_by(work_ethic) |>
  summarize(allocation = mean(allocation, na.rm = T)) |>
  ggplot() +
  geom_col(aes(x = work_ethic, y = allocation))

desante |>
  filter(!is.na(race) & !is.na(work_ethic)) |>
  group_by(race, work_ethic) |>
  summarize(allocation = mean(allocation, na.rm = T)) |>
  ggplot() +
  geom_col(aes(x = work_ethic, y = allocation, fill = race), position = "dodge")


# Hypothesis Tests --------------------------------------------------------

# One-sided, one-sample t-test

# H0: Applicants are not allocated greater than (are allocated less than or equal to) $550 per week on average
# HA: Applicants are allocated greater than $550 per week on average

desante |>
	t_test(response = allocation,
				 mu = 550,
				 alternative = "greater")

# Two-sided, one-sample t-test

# H0: Applicants are not allocated greater than or less than (are allocated equal to) $550 per week on average
# HA: Applicants are not allocated $550 per week on average

desante |>
	t_test(response = allocation,
				 mu = 550,
				 alternative = "two-sided")

# One-sided, two-sample t-test

# H0: Black applicants are not allocated less than (are allocated more than or the same as) white applicants on average
# HA: Black applicants are allocated less than white applicants on average

desante |>
	t_test(allocation ~ race,
				 order = c("black", "white"), # black-white
				 alternative = "less")

# Note that you *must* specify the order for subtraction when using one-sided t-tests (you do not have to do this for two-sided t-tests, since the direction of subtraction does not matter, but you should hide the warning message from your Quarto documents.)

# Two-sided, two-sample t-test

# H0: Excellent applicants are not allocated more than or less than (are allocated the same as) poor applicants on average
# HA: Excellent applicants are allocated more than or less than (different than) poor applicants on average

desante |>
	t_test(allocation ~ work_ethic,
				 alternative = "two-sided")

# Try it yourself! --------------------------------------------------------

# Are excellent black applicants allocated less than excellent white applicants? How about among poor applicants? Write the H0s and HAs.

# Excellent applicants

# H0: Excellent black applicants are not allocated less than (are allocated more than or equal to) excellent white applicants.
# HA: Excellent black applicants are allocated less than excellent white applicants.

desante |>
  filter(work_ethic == "excellent") |>
  t_test(allocation ~ race,
         order = c("black", "white"),
         alternative = "less")

# Poor applicants

# H0: Poor black applicants are not allocated less than (are allocated more than or equal to) poor white applicants.
# HA: Poor black applicants are allocated less than poor white applicants.

desante |>
  filter(work_ethic == "poor") |>
  t_test(allocation ~ race,
         order = c("black", "white"),
         alternative = "less")

# There is a third option for respondents to allocate some of the $1500 to "balancing the budget" (variable bal_bud). Do Republicans and Democrats allocate different amounts to balancing the budget? Write the H0 and HA.

# H0: Republicans and Democrats do not allocate different amounts (allocate the same amount) to balancing the budget.
# HA: Republicans and Democrats allocate different amounts to balancing the budget.

desante |>
	filter(pid %in% c("Republican", "Democrat")) |>
	t_test(bal_bud ~ pid,
				 alternative = "two-sided")

# What about poll questions? For polls, we generally want to weight the responses using the weighting variable before calculating estimates like the mean or difference in means.

# Unfortunately, there is no simply way to generate a weighted t-test. However, we will learn how to apply weights using a different type of function (the lm() function, for linear model) in a couple of weeks.

# In the meantime, you can use unweighted t-tests for polling data. The most important thing to remember about working with polling data is that hypothesis tests are a test of means (averages) - is the mean of the variable greater than some other value or mean? Different than some other value or mean? So if we want to test a proportion (percentage), we want our variable to be in the form of 1s and 0s. (The mean of a vector of 1s and 0s is the proportion of rows that have a value of 1.)

# To see this in action, let's use data from a poll of Washington, D.C. residents conducted by Abt Associates on behalf of The Washington Post (https://doi.org/10.25940/ROPER-31119329). Let's begin by loading the data:
poll <- read_csv("31119329.csv")

# Let's start by exploring the question, "If you could, would you want to move out of District of Columbia, or not?" The relevant variable is `leavedcfull`. What are the UNweighted topline results of this poll question?

poll |>
  filter(!is.na(leavedcfull) & !str_detect(leavedcfull, "DK")) |>
  count(leavedcfull) |>
  mutate(prop = n/sum(n),
         resp = sum(n),
         moe = 1.96 * sqrt((prop * (1 - prop))/resp)) |>
  ggplot() +
  geom_col(aes(x = leavedcfull, y = prop, fill = leavedcfull)) +
  geom_errorbar(aes(x = leavedcfull, ymin = prop - moe, max = prop + moe, group = leavedcfull), position = position_dodge(.9), width = .2) +
  theme_classic() +
  theme(legend.position = "none")

# Do less than 1 in 5 D.C. residents want to leave DC? To answer this, we must convert our three category dependent variable into a binary (0/1 variable).

poll |> 
  filter(!is.na(leavedcfull) & !str_detect(leavedcfull, "DK")) |>
  mutate(leavedcnew = ifelse(leavedcfull == "Would not move", 0, 1)) |>
  t_test(response = leavedcnew,
         mu = .2,
         alternative = "less")


# Try it yourself! --------------------------------------------------------

# Do a different proportion of residents in Wards 7 and 8 want to leave DC than residents of other wards? The relevant variable is `wardnew`. Please note that missing values are denoted with 98 and 99 rather than NA.

poll |> 
  filter(!is.na(leavedcfull) & !str_detect(leavedcfull, "DK") & !wardnew %in% c(98,99)) |>
  mutate(leavedcnew = ifelse(leavedcfull == "Would not move", 0, 1),
         wardnew = ifelse(wardnew %in% c(7,8), 1, 0)) |>
  t_test(leavedcnew ~ wardnew,
         alternative = "two-sided")
