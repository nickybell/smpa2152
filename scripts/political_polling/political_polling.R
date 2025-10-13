# fmt: skip file
# File Name: 	  	  political_polling_unfilled.R
# File Purpose:  	  Pre-lab video lecture on analyzing political polls
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Last Modified:    2025-10-12

# Before we get started, let's load the packages and data we will be using today. Remember, if you are using Posit Cloud, you will need to install the packages every time you start a new project. However, whether you are using Posit Cloud or Positron, you will need to load the packages every time you start a new R session.
library(tidyverse)

# Today, we are going to use what we've previously learned about data visualization with {ggplot2} and data wrangling with {dplyr} to analyze political polls. Specifically, we will:
# 1) Use dplyr verbs to calculate the results of poll questions for the whole survey (known as toplines) or for subgroups (known as crosstabs) while applying survey weights.
# 2) Use ggplot2 to visualize the results of these polls, showing the margin of error alongside our poll results.

# To do this, we are going to use data from the 2024 American National Election Study. The ANES is a large, nationally representative survey that collects data on voting behavior, political attitudes, and demographic characteristics of the U.S. population. This is the data from the pre-election questionnaires only.

# This data dictionary describes the variables in the cleaned dataset.

# |Variable Name|Description|
# |:---|:---|
# |`id`|A unique identifier for each respondent in the 2024 ANES Time Series study.|
# |`party_id`|Respondent's 7-point party identification.|
# |`race`|Respondent's self-identified race and ethnicity.|
# |`age`|Respondent's age in years on Election Day.|
# |`educ`|Respondent's highest level of education.|
# |`gender`|Respondent's self-identified gender.|
# |`income`|Respondent's total household income over the past 12 months, converted to the numeric midpoint of the original category.|
# |`pres_vote`|A summary of the respondent's presidential vote choice or intent to vote from the pre-election survey.|
# |`economy`|Respondent's approval or disapproval of how the president is handling the economy.|
# |`immigration`|Respondent's approval or disapproval of the president's handling of immigration.|
# |`crime`|Respondent's approval or disapproval of the president's handling of crime.|
# |`attention_to_politics`|How often the respondent pays attention to government and politics.|
# |`weights`|Survey weights to make the data nationally representative.|

# You can load the data I've provided to you.
anes <- read_csv("anes_2024.csv")

# Survey Weights ----------------------------------------------------------

# Let's begin by doing a little exploratory data analysis on the survey weights used in this poll. What does the distribution of weights look like?



# Topline Results ----------------------------------------------------------

# Using just the tidyverse, we can generate both the unweighted and weighted presidential vote. To make this easier, let's introduce a new function: count().


# What if we want proportions instead of counts?


# This is known as a "topline" result, because it includes everyone in the sample.

# Of course, we know that every time we have a sample, we also have uncertainty about whether our estimate is the same as the true population mean (the true percentage of voters who intended to vote for Harris). This is because for any given sample, we sometimes get an estimate that is in the tails of the sampling distribution, and is much too high or much too low. We account for this uncertainty using the margin of error.

# You do not need to memorize the margin of error formula for this class, but you will need this code from time to time. My recommendation is to have it in an easy-to-find location so that you can copy and paste it when you need it. This code generates the margin of error for each response option.



# Based on this code, we learn that if we redid this survey 100 times, in 95 of those surveys, the estimated vote for Donald Trump would be between 41.0 - 45.4%, and the estimated vote for Kamala Harris would be between 48.0 - 52.4%.

# Because these confidence intervals do not overlap, we can say that Harris is statistically significantly ahead of Trump in this poll. How can we show this visually to our readers who might not be familiar with confidence intervals?

# In ggplot2, there is a geom_*() layer that puts error bars on our estimates. It is called geom_errorbar(), and it works similarly to all of our other geom_*() layers. We just need to tell it where to put the bottom and top of the error bars.



# Crosstab Results --------------------------------------------------------

# A "crosstab" is when we compare the results of a poll question across subgroups. For example, what if we want to know how presidential vote varies by age?
# Note: a crosstab only works if both variables are categorical (i.e., not continuous). So if we have a continuous variable like age or income, we need to convert it into categories first.

anes_age <-
  anes |>
  mutate(
    agecat = case_when(
      age < 30 ~ "18-29",
      age >= 30 & age < 45 ~ "30-44",
      age >= 45 & age < 60 ~ "45-59",
      age >= 60 ~ "60+",
      TRUE ~ NA
    )
  )


# One of the challenges of count() is that it does not leave your data frame "grouped", so we need to add another group_by() function before calculating our proportions and margins of error.



# Look at how much larger our margins of error are when we are calculating crosstabs! This is because our sample size is much smaller when we are looking at subgroups of the population. For this reason, we have to be even more cautious when interpreting crosstab results.



# These results are very interesting! According to this poll, the only group that Harris is winning with statistical certainty is the age 60+ group. All other age groups have overlapping confidence intervals, meaning that we cannot say with certainty that one candidate is ahead of the other. This is contrary to the conventional wisdom that younger voters are more likely to vote for Democrats, and older voters are more likely to vote for Republicans.

# You can use this same code to analyze other variables in the dataset. For example, how does presidential vote vary by race? By education? We can also look at other questions in the survey that are not weighting and/or demographic variables, such as how closely someone pays attention to politics.



# The order here is a bit odd. We can fix this by reordering the *factor levels* of attention_to_politics. We can do this using the factor() function inside mutate(), but please be careful: the levels argument has to include all of the values in the variable, and spelled/capitalized exactly the same way!

anes_attention <- anes |>
  mutate(
    attention_to_politics = factor(
      attention_to_politics,
      levels = c(
        "Always",
        "Most of the time",
        "About half the time",
        "Some of the time",
        "Never"
      )
    )
  )



# We might be tempted to say that people who never pay attention to politics are more likely to vote for Trump. However, look at the margins of error here! The confidence intervals for both candidates overlap, even though the estimate for Trump is so large. Think about how few people in this group probably answered the survey, so our uncertainty is large.

# The point of this exercise is that it is really easy to dive into the crosstabs to find surprising results and build a narrative - but often we are so uncertain about these results that we cannot be sure our results are just chance. It is a fallacy that happens often in media analyses of polling results, so be on the lookout for small samples sizes and large uncertainty before drawing any conclusions of your own from polls.
