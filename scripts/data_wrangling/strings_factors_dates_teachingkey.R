# File Name: 	  	  strings_factors_dates_teachingkey.R
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
str_detect(rc$vote_desc, "Appropriation")
rc |>
  filter(str_detect(vote_desc, "Appropriation")) |>
  distinct(bill_number, vote_desc)

rc |>
  filter(str_detect(vote_desc, "Appropriation") & str_detect(bill_number, "HRES", negate = TRUE)) |>
  distinct(bill_number, vote_desc)

# Take a student suggestion for another issue area.

# Now, let's find all of the bills that originated in the Senate.
rc |>
  filter(str_starts(bill_number, "S") & str_starts(bill_number, "SJRES", negate = TRUE)) |>
  distinct(bill_number, vote_desc)


# Combining strings -------------------------------------------------------

# There are built-in functions in R for combining strings called paste() and paste0()

paste("apple", "banana", "orange", sep = ", ")
paste0("apple, ", "banana, ", "orange")

# However, these functions will not ignore missing values:
paste0("apple, ", "banana, ", NA, "orange")

# This is where str_c() may be useful:
str_c("apple, ", "banana, ", NA, "orange")

# Let's create a table giving information about all of the Appropriations bills passed by each chamber.

rc |>
  filter(str_detect(vote_desc, "Appropriation") & vote_question == "On Passage") |>
  mutate(chamber = str_to_title(chamber),
         info = str_c("The", chamber, vote_result, bill_number, "-", vote_desc, sep = " "))

# Splitting Strings -------------------------------------------------------

# How many of each type of resolution (HR, HRES, HCONRES, HJRES) were passed by the House?

rc |>
  filter(chamber == "HOUSE" & vote_result %in% c("Agreed to", "Passed")) |>
  separate_wider_delim(bill_number, " ", names = c("bill_type", "bill_number")) |>
  group_by(bill_type) |>
  summarize(n = n())

rc |>
  filter(chamber == "HOUSE" & vote_result %in% c("Agreed to", "Passed")) |>
  separate_wider_delim(bill_number, " ", names = c("bill_type", "bill_number")) |>
  group_by(bill_type) |>
  summarize(n = n()) |>
  ggplot() +
  geom_col(aes(x = bill_type, y = n))


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
levels(foo)

# You can also provide "labels" that replace the levels.
foo <- factor(pres, levels = c("Clinton", "Bush", "Obama", "Trump", "Biden"), labels = c("William J. Clinton", "George W. Bush", "Barack H. Obama", "Donald J. Trump", "Joseph R. Biden"))
levels(foo)

# However, factor() has no protection for misspecified levels, e.g.,
bar <- factor(pres, levels = c("Clnton", "Bush", "Obama", "Trump", "Bidn"))
bar

# The {forcats} package has a similar function called fct() that does provide this protection.
bar <- fct(pres, levels = c("Clnton", "Bush", "Obama", "Trump", "Bidn"))

# This can be useful for reordering and renaming categorical variables in ggplot:
rc |>
  filter(chamber == "HOUSE" & vote_result %in% c("Agreed to", "Passed")) |>
  separate_wider_delim(bill_number, " ", names = c("bill_type", "bill_number")) |>
  mutate(bill_type_f = factor(bill_type, c("HR", "S", "HJRES", "SJRES", "HCONRES", "HRES")),
         bill_type_f = fct_infreq(bill_type_f),
         bill_type_f = fct_rev(bill_type_f),
         bill_type_f = fct_recode(bill_type_f,
                                  "Senate Joint Resolution" = "SJRES",
                                  "House Concurrent Resolution" = "HCONRES",
                                  "House Joint Resolution" = "HJRES",
                                  "Senate Bill" = "S",
                                  "House Resolution" = "HRES",
                                  "House Bill" = "HR"),
         bill_type_f = fct_lump_n(bill_type_f, 3)) |>
  group_by(bill_type_f) |>
  summarize(n = n()) |>
  ggplot() +
  geom_col(aes(x = bill_type_f, y = n)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

#############
### Dates ###
#############

