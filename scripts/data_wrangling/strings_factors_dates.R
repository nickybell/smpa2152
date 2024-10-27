# File Name: 	  	  strings_factors_dates.R
# File Purpose:  	  Strings, Factors, and Dates
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2024-10-14

# Strings, factors, and dates are some of the more complicated types of data to work with in R. Whereas numbers have set mathematical properties, strings (characters) can take nearly any form and adopt any order. Dates do have set properties, but nevertheless must be treated specially due to things like dividing by 60, 24, 52, 12, etc. and leap years.

# We could spend an entire class learning how to handle each of these types of variables individually. In fact, there is a separate tidyverse package for each of these types of variables:
# {stringr} - for working with strings
# {forcats} - for working with factors
# {lubridate} - for working with dates (and times)

# We are not going to go into much depth about any of these types of data, but you should be aware that the capabilities of these packages is quite extensive. You can learn more by going to their cheat sheets (via the Help > Cheat Sheets toolbar in RStudio).

# To illustate how to use these packages when working with strings, factors, and dates, we will use data from Voteview (https://www.voteview.com/), an academic research project that uses Congressional roll call votes to estimate the ideology (called a DW-NOMINATE score) for every member of Congress. We will be using Voteview's collected data on Congressional roll call votes in the 118th (current) Congress.

# Load packages
library(tidyverse)

# Load data
rc <- read_csv("house_roll_call_votes.csv")

###############
### Strings ###
###############

# You have already learned a little bit about how to work with strings in R. The {stringr} package focuses on how to efficiently manipulate strings (since we cannot, for example, just "add" to a string like we can a numeric variable). We are going to focus on three uses of {stringr}:
# 1. Detecting strings - get a vector of TRUE/FALSE values for whether a vector of strings contains some set of characters
# 2. Combining strings - what to do when values are spread across columns
# 3. Splitting strings - what to do when multiple values are stored in one column (not tidy data!)


# Detecting strings -------------------------------------------------------

# There are three useful functions for detecting values in strings:

# str_detect(string, pattern) - pattern is found anywhere in the string
# str_starts(string, pattern) - pattern is found at the start of the string
# str_ends(string, pattern) - pattern is found at the end of the string

# Let's find all the appropriations bills considered by this Congress:


# Now, let's find all of the bills that originated in the Senate.



# Combining strings -------------------------------------------------------

# There are built-in functions in R for combining strings called paste() and paste0()


# However, these functions will not ignore missing values:


# This is where str_c() may be useful:


# Let's create a table giving information about all of the Appropriations bills passed by each chamber.


# Splitting Strings -------------------------------------------------------

# How many of each type of resolution (HR, HRES, HCONRES, HJRES) were passed by the House?



###############
### Factors ###
###############

# Factors are just string variables that are treated as categorical, meaning:
# - they can only take a set group of values
# - they are (functionally) ordered

# We will learn three things to do with factors:
# 1. How to create factors
# 2. How to reorder factor levels
# 3. How to change the names or number of levels

# Factors have "levels" that represent the acceptable values for that variable.
pres <- c(rep("Clinton", 2), rep("Bush", 2), rep("Obama", 2), "Trump", "Biden")

foo <- factor(pres, levels = c("Clinton", "Bush", "Obama", "Trump", "Biden"))

# You can also provide "labels" that replace the levels.
foo <- factor(pres, levels = c("Clinton", "Bush", "Obama", "Trump", "Biden"), labels = c("William J. Clinton", "George W. Bush", "Barack H. Obama", "Donald J. Trump", "Joseph R. Biden"))

# However, factor() has no protection for misspecified levels, e.g.,
bar <- factor(pres, levels = c("Clnton", "Bush", "Obama", "Trump", "Bidn"))


# The {forcats} package has a similar function called fct() that does provide this protection.


# This can be useful for reordering and renaming categorical variables in ggplot:


#############
### Dates ###
#############

# Sometimes, we're able to use raw numbers to represent dates (for example, months or years) without an issue. However, R has a built in type of variable called a <date> (or <dttm> for date-time) that makes it easier to use dates. Today, we will learn:

# 1. How to make dates from character strings
# 2. How to use dates as a scale on a ggplot

# There are a bunch of functions in the {lubridate} package to make dates from combinations of year, month, and day, like ymd(), mdy(), and my().
# It is important to specify the type of date format because some dates are ambiguous, like 10-11-12. Is this October 11, 2012, or November 10, 2012, or November 12, 2010?
# If you use functions like "as.Date()", R will try to make a guess, but will not always be successful.



# So, what if we want to show the average number of bills voted on by the House in each month of the 118th Congress?
# ?strftime



# If we want to skip the str_c() step, we can use make_date():



# You can also extract elements of dates using functions like month(), day(), year(), and even wday().


# What is the most common day for votes in the House?

