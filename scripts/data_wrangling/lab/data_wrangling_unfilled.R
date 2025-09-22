# fmt: skip file
# File Name: 	  	  data_wrangling_unfilled.R
# File Purpose:  	  Pre-lab video lecture on data wrangling in R with {dplyr}
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Last Modified:    2025-09-10

# Before we get started, let's load the packages and data we will be using today. Remember, if you are using Postit Cloud, you will need to install the packages every time you start a new project. However, whether you are using Posit Cloud or Positron, you will need to load the packages every time you start a new R session.
library(tidyverse)

# Specifically, we will be using the {dplyr} package, which is part of the tidyverse. {dplyr} is used for data wrangling, which is the process of transforming raw data into a format that is easier to work with and analyze.

# However, today I am also going to show you how to load data from a CSV file using the read_csv() function from the {readr} package, which is also part of the tidyverse. The read_csv() function is used to read in data from a CSV file and create a data frame in R.


# This is the path to your file. It starts at your working directory, which you can check using the getwd() function.


# We will be working with 2024 Presidential Election results from each precinct in the country,available for download from the New York Times (https://github.com/nytimes/presidential-precinct-map-2024).


# The {dplyr} package uses "verbs" to manipulate data frames, and there are six that you really need to know:

# * `filter()`, for choosing rows.
# * `mutate()`, for adding or changing data.
# * `arrange()`, for sorting data.
# * `select()`, for choosing columns.
# * `summarize()` and it's best friend `group_by()`, for generating summary statistics.

### `filter()`

# `filter()` uses logical statements to indicate what rows we would like to keep in the data frame. Think of a coffee filter; it acts a sieve to only allow what we want (the coffee) to drip through.

# ==, !=, <, >, <=, >=, %in%
# These always return a value of TRUE or FALSE
# Note that equals is "==", not "="
# == means equals

# != means NOT equal

# < is less than
# > is greater than
# <= is less than or equal to
# >= is greater than or equal to
# %in% allows you to match an == to multiple values

# You can combine these logical statements with & (AND) and | (OR)

# So let's say we wanted to keep only the rows from Pennsylvania:


# One of the advantages of coding in the tidyverse is that every "dplyr verb" has the same basic formula:

# `function(dataframe, operation)`

# You can also use multiple logical statements combined with `&` and `|` in a `filter()` function:


### `mutate()`

# `mutate()` is the workhorse function of `dplyr`. We use `mutate()` when we want to add or change a column in our data frame. Remember, only changes that are assigned to an object with `<-` are saved!

# Let's start by calculating the Democratic and Republican two-party vote share for each precinct (notice how we can do multiple operations separated by a comma):


# We can create a histogram of Democratic vote share using our new variables:


### `arrange()`

# `arrange()` puts rows in order -- alphabetical or numeric. For example, what were the closest Harris victories in the country? For this, we'll need to calculate the Democratic *two-party* vote share.


# Notice that we used three functions to get to this table: `mutate()`, `filter()`, and `arrange()`. We executed each function separately, which is a bit clumsy. There is a way to combine all of these functions into one execution ("paragraph") using pipes (`|>`).


# The `|>` operator says, "Take the data frame that is on the left hand side of the pipe, and use it as the first argument (the data, usually) in the right hand side of the pipe." So here, I am:

# 1. Passing `elec` as the data frame to `mutate()`.
# 2. Taking the data frame with my new column `dem_two_party` and passing it to `filter()`.
# 3. Keeping only the rows where `dem_two_party` is greater than 0, and passing these rows to `arrange()`.
# 4. Sorting the data by `dem_two_party`, and passing the result to `slice_head()`.

# **Notice that I do not put the name of the data frame as the first argument in the `dplyr` verb functions.** The pipe operator is taking care of that for me!

# Note: You might also see the pipe operator written as `%>%`. The `%>%` pipe was developed by the `tidyverse` team and specifically is part of a package called `magrittr`, and you will see it used a lot. However, in a recent release of base R, the developers added the "native pipe" (`|>`) that we will use in this course.

#  By default, `arrange()` sorts in ascending (smallest to largest) order. To sort in descending order, add in the `desc()` function. For example, in which precincts did Harris receive the largest number of raw votes?


# We can also arrange using more than group.


### `select()`

# `select()` is for choosing which columns of your data frame to keep.


# Generally speaking, we do not need to remove columns from our data frame in order to do analyses. However, `select()` can be useful if you want to create a smaller data frame to view or export.


### `group_by()` and `summarize()`

# We can use `summarize()` all by itself to get summary statistics about the entire data frame. For example, if I want to know the average vote share for each candidate in the data set, I could do:


# But often, we want to know these statistics for particular *groups*. For example, what if I want to know the results by state? `group_by()` tells R that it should calculate the summary statistics (or do any other operation) by group. This means that `summarize()` will produce one row per group, rather than one row for the entire data frame.


# This is a case where piping into a `ggplot` is particularly useful. Our `group_by()` and `summarize()` will generate a new data frame -- we can just pass it in as the data to `ggplot()` using the pipe:
