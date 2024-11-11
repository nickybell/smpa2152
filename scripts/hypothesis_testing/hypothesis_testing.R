# File Name: 	  	  hypothesis_testing.R
# File Purpose:  	  Hypothesis Testing
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2024-11-11

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




# Hypothesis Tests --------------------------------------------------------

# One-sided, one-sample t-test

# H0: Applicants are allocated less than or equal to $550 per week on average
# HA: Applicants are allocated greater than $550 per week on average



# Two-sided, one-sample t-test

# H0: Applicants are allocated $550 per week on average
# HA: Applicants are not allocated $550 per week on average



# One-sided, two-sample t-test

# H0: Black applicants are allocated more than or the same as white applicants on average
# HA: Black applicants are allocated less than white applicants on average



# Two-sided, two-sample t-test

# H0: Excellent applicants are allocated the same as poor applicants on average
# HA: Excellent applicants are not allocated the same as poor applicants on average




# Try it yourself! --------------------------------------------------------

# Are excellent black applicants allocated less than excellent white applicants? How about among poor applicants? Write the H0s and HAs.

# Excellent applicants



# Poor applicants



# There is a third option for respondents to allocate some of the $1500 to "balancing the budget" (variable bal_bud). Do Republicans and Democrats allocate different amounts to balancing the budget? Write the H0 and HA.




# Polls -------------------------------------------------------------------

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



# Try it yourself! --------------------------------------------------------

# Do a different proportion of residents in Wards 7 and 8 want to leave DC than residents of other wards? The relevant variable is `wardnew`. Please note that missing values are denoted with 98 and 99 rather than NA.


