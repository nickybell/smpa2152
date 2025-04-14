# File Name: 	  	  political_polling.R
# File Purpose:  	  Political Polling
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)

# Load the tidyverse and set option
library(tidyverse)


# Exit Polls --------------------------------------------------------------

# Today, we will learn how to use weights to help ensure that our survey samples are representative of the population. To demonstrate, we will use data from the 2020 National Election Pool (ABC News, CBS, CNN, NBC) exit poll that you may have seen watching telecasts of the election results. Exit polls are a good example of using weights because it is very difficult to generate a truly random sample of U.S. voters.
# - Exit polls are taken at select precincts across the United States. Are these precincts representative of the state/country as a whole?
# - Exit polls are traditionally conducted by approaching every nth voter leaving the polling place. Are these participants representative of voters as a whole?
# - In 2020, in-person exit polls were combined with telephone interviews due to the ubiquity of early voting and vote-by-mail. Could different survey methods yield different types of selection bias?

# Download the 2020 National Election Pool exit poll results from Roper iPoll and load the data in R: https://doi.org/10.25940/ROPER-31119913
poll <- read_csv("31119913_National2020.csv")


# Survey Weights ----------------------------------------------------------

# Let's begin by doing a little exploratory data analysis on the survey weights used in this poll. What does the distribution of weights look like?


# Presidential vote is not a weighting variable (it is an outcome), but are Trump voters more heavily weighted than Biden voters?


# Using just the tidyverse, we can generate both the unweighted and weighted presidential vote. To make this easier, let's introduce a new function: count().



# The reason to use count() when working with political polls is that it allows you to easily add weights. You can do this with group_by() and summarize(), but it is much more difficult.



# What is we want proportions instead of counts?



# One of the challenges of count() is that it does not leave your data frame "grouped", so be careful when calculating proportions. Imagine we are doing a cross-tab, meaning that we are comparing the cross of two groups: Sex x Presidential Vote.



# We need to add a group_by() to get the proportions calculated in the right way. (We are keeping all the rows, so we use mutate() instead of summarize() here. One of the few times we do so.)



# Plotting Poll Results ---------------------------------------------------



# In 2020, many Democrats cast their ballots by mail due to the COVID-19 pandemic, while Republicans typically cast their ballots in person. This resulted in a wide partisan gap between election day ballots (which were counted immediately) and mail ballots. Can we visualize this divide?



# When we present survey results, we always want to show the margin of error. Let's calculate the margin of error for these results and add it to our graph.



# A rule of thumb about the error bars: if they do NOT intersect, then the two numbers are statistically significantly different. If they DO intersect, then they *might* or *might not* be significantly different.