# File Name: 	  	  regression_inclass.R
# File Purpose:  	  Regression (in class)
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2024-12-02

# Load packages
library(tidyverse)
library(infer) # for the function t_test()

# Set options
options(tibble.width = Inf)

# Today we will be working with data from a poll of Washington, DC residents conducted by Abt Associates on behalf of The Washington Post (https://doi.org/10.25940/ROPER-31119329). You might recall this data from our lecture on hypothesis testing or from Emily Guskin's guest lecture. Let's begin by loading the data:

dc <- read_csv("31119329.csv")

# Let's start by exploring the question, "If you could, would you want to move out of District of Columbia, or not?" The relevant variable is `leavedcfull`. Please note that missing values are denoted with 98 and 99 rather than NA.

# Recall that the most important thing to remember about working with polling data is that hypothesis tests and regression are  tests of means (averages). So if we want to test a proportion (percentage), we want our variable to be in the form of 1s and 0s.

count(dc, leavedcfull)

dc2 <- dc |> 
  filter(!is.na(leavedcfull) & !str_detect(leavedcfull, "DK")) |>
  mutate(leavedcnew = ifelse(leavedcfull == "Would not move", 0, 1))

# Do a different proportion of residents in Wards 7 and 8 want to leave DC than residents of other wards? The relevant variable is `wardnew`. Please note that missing values are denoted with 98 and 99 rather than NA.

dc2 |> 
  filter(!wardnew %in% c(98,99)) |>
  mutate(wardnew = ifelse(wardnew %in% c(7,8), 1, 0)) |>
  t_test(leavedcnew ~ wardnew,
         alternative = "two-sided",
         order = c(1,0))

# Recall that there are a couple of challenges with this analysis:
# 1. We can only compare two groups at one time. There is no controlling for confounders. For example, could income explain both where someone lives in DC and whether they would like to leave DC?
# 2. We cannot weight a t-test if we are using survey data.

# Instead, we can use a type of regression called a linear probability model. It is called this because we are estimating the average percentage change in the dependent variable from a one-unit change in the independent variable. (It is possible to do a regression that has a categorical dependent variable, but these are way beyond the scope of this class.)

dc3 <- dc2 |> 
  filter(!wardnew %in% c(98,99)) |>
  mutate(wardnew = ifelse(wardnew %in% c(7,8), 1, 0))

reg <- lm(leavedcnew ~ wardnew, data = dc3)
summary(reg)

# Notice how the coefficient in the regression is the same as the estimated difference in means in the t-test. This is because a simple linear regression is just a best fit line between two variables; the slope is the mean change (difference) between them!

# Now let's adopt our survey weights

reg2 <- lm(leavedcnew ~ wardnew, weight = weight, data = dc3)
summary(reg2)

# Now we can control for confounders.

dc4 <- dc3 |>
  filter(racenet != "DK/No opinion")

reg3 <- lm(leavedcnew ~ wardnew + income4 + agebreak + educnew, weight = weight, data = dc4)
summary(reg3)

# Now let's explain one attitude with another attitude. This is a common type of analysis in journalism, for example, "How do feelings about the economy affect support for the incumbent President?" But these questions are very hard to determine causality. A regression can help you understand correlations, but it is not a substitute for a experiment when the dependent variable does not precede the independent variable. (On the other hand, it is very unlikely that someone wanted to leave DC and then moved to Wards 7 or 8.)

# Are fans of the Washington Football Team's new name (the Commanders) more likely to support public funding for a new football stadium?

count(dc, commandersname)

fball <- dc |>
  filter(!str_detect(fundfootballstadium, "VOL") & !str_detect(commandersname, "VOL") & racenet != "DK/No opinion") |>
  mutate(fundstadiumnew = ifelse(fundfootballstadium == "Favor", 1, 0))

reg_fball <- lm(fundstadiumnew ~ commandersname, weight = weight, data = fball)
summary(reg_fball)

# What if we want to change our comparison group? The first level of a factor variable is the "reference level" that is excluded.
fball2 <- fball |>
  mutate(commandersname = factor(commandersname, levels = c("Hate it", "Dislike it", "Like it", "Love it")))

reg_fball2 <- lm(fundstadiumnew ~ commandersname, weight = weight, data = fball2)
summary(reg_fball2)

# Now let's control for potential confounders.
reg_fball3 <- lm(fundstadiumnew ~ commandersname + income4 + agebreak + educnew, weight = weight, data = fball2)
summary(reg_fball3)


# Try it yourself! --------------------------------------------------------

# What explains whether DC residents believe that a greater police presence patrolling neighborhoods would reduce violent crime (q21anet)? Consider how they rate the job that DC police are doing, whether they feel safe in their neighborhood, and whether someone in their household has been a victim of violent crime in the past five years. Hint: you'll may to look at the study documentation to find the right variables. https://ropercenter.cornell.edu/ipoll/study/31119329

safe <- dc |>
  filter(q21anet != "DK/No opinion" & q20net != "DK/No opinion" & !str_detect(hoodsafe, "VOL") & !str_detect(ratepolice, "VOL")) |>
  mutate(policesafe = ifelse(q21anet == "Would reduce crime NET", 1 ,0),
         ratepolice = factor(ratepolice, levels = c("Poor", "Not so good", "Good", "Excellent")),
         hoodsafe = factor(hoodsafe, levels = c("Not safe at all", "No too safe", "Somewhat safe", "Very safe")))

reg_safe <- lm(policesafe ~ ratepolice + hoodsafe + q20net, weight = weight, data = safe)
summary(reg_safe)

# How to report 