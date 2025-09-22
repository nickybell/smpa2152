# File Name: 	  	  data_wrangling_teachingkey.R
# File Purpose:  	  Pre-lab video lecture on data wrangling in R with {dplyr}
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Last Modified:    2025-09-10

# Before we get started, let's load the packages and data we will be using today. Remember, if you are using Postit Cloud, you will need to install the packages every time you start a new project. However, whether you are using Posit Cloud or Positron, you will need to load the packages every time you start a new R session.
library(tidyverse)

# Specifically, we will be using the {dplyr} package, which is part of the tidyverse. {dplyr} is used for data wrangling, which is the process of transforming raw data into a format that is easier to work with and analyze.

# However, today I am also going to show you how to load data from a CSV file using the read_csv() function from the {readr} package, which is also part of the tidyverse. The read_csv() function is used to read in data from a CSV file and create a data frame in R.
elec <- read_csv("data/precincts-with-results.csv")

# This is the path to your file. It starts at your working directory, which you can check using the getwd() function.
getwd()

# We will be working with 2024 Presidential Election results from each precinct in the country, available for download from the New York Times (https://github.com/nytimes/presidential-precinct-map-2024).
glimpse(elec)

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
5 == 6
(20 / 4) != 5
c("red", "white", "blue") == "red"
# != means NOT equal
5 == 10 / 2
(20 / 4) != 4
c()
# < is less than
# > is greater than
# <= is less than or equal to
# >= is greater than or equal to
# %in% allows you to match an == to multiple values
"red" %in% c("red", "white", "blue")
"green" %in% c("red", "white", "blue")

# You can combine these logical statements with & (AND) and | (OR)
"red" %in% c("red", "white", "blue") | "green" %in% c("red", "white", "blue")

"red" %in% c("red", "white", "blue") & "green" %in% c("red", "white", "blue")

# So let's say we wanted to keep only the rows from Pennsylvania:
elec_pa <- filter(elec, state == "PA")

# One of the advantages of coding in the tidyverse is that every "dplyr verb" has the same basic formula:

# `function(dataframe, operation)`

# You can also use multiple logical statements combined with `&` and `|` in a `filter()` function:
elec_pa_very_close <- filter(
  elec_pa,
  votes_dem / votes_total < .5 & votes_rep / votes_total < .5
)

### `mutate()`

# `mutate()` is the workhorse function of `dplyr`. We use `mutate()` when we want to add or change a column in our data frame. Remember, only changes that are assigned to an object with `<-` are saved!

# Let's start by calculating the Democratic and Republican two-party vote share for each precinct (notice how we can do multiple operations separated by a comma):
elec_shares <- mutate(
  elec,
  two_party_vote = votes_dem + votes_rep,
  dem_two_party_share = votes_dem / two_party_vote,
  rep_two_party_share = 1 - dem_two_party_share
)
glimpse(elec_shares)

# We can create a histogram of Democratic vote share using our new variables:
ggplot(data = elec_shares) +
  geom_histogram(aes(x = dem_two_party_share))


### `arrange()`

# `arrange()` puts rows in order -- alphabetical or numeric. For example, what were the closest Harris victories in the country? For this, we'll need to calculate the Democratic *two-party* vote share.
harris_won <- filter(elec_shares, dem_two_party_share > .5)
harris_won_ordered <- arrange(harris_won, dem_two_party_share)
slice_head(harris_won_ordered, n = 10)

# Notice that we used three functions to get to this table: `mutate()`, `filter()`, and `arrange()`. We executed each function separately, which is a bit clumsy. There is a way to combine all of these functions into one execution ("paragraph") using pipes (`|>`).
elec |>
  mutate(
    two_party_vote = votes_dem + votes_rep,
    dem_two_party_share = votes_dem / two_party_vote,
    rep_two_party_share = 1 - dem_two_party_share
  ) |>
  filter(dem_two_party_share > .5) |>
  arrange(dem_two_party_share) |>
  slice_head(n = 10)

# The `|>` operator says, "Take the data frame that is on the left hand side of the pipe, and use it as the first argument (the data, usually) in the right hand side of the pipe." So here, I am:

# 1. Passing `elec` as the data frame to `mutate()`.
# 2. Taking the data frame with my new column `dem_two_party` and passing it to `filter()`.
# 3. Keeping only the rows where `dem_two_party_share` is greater than 0, and passing these rows to `arrange()`.
# 4. Sorting the data by `dem_two_party_share`, and passing the result to `slice_head()`.

# **Notice that I do not put the name of the data frame as the first argument in the `dplyr` verb functions.** The pipe operator is taking care of that for me!

# Note: You might also see the pipe operator written as `%>%`. The `%>%` pipe was developed by the `tidyverse` team and specifically is part of a package called `magrittr`, and you will see it used a lot. However, in a recent release of base R, the developers added the "native pipe" (`|>`) that we will use in this course.

#  By default, `arrange()` sorts in ascending (smallest to largest) order. To sort in descending order, add in the `desc()` function. For example, in which precincts did Harris receive the largest number of raw votes?
elec |>
  arrange(desc(votes_dem)) |>
  slice_head(n = 10)

# We can also arrange using more than group.
elec |>
  arrange(votes_rep, desc(votes_dem)) |>
  slice_head(n = 10)

### `select()`

# `select()` is for choosing which columns of your data frame to keep.
select(elec, GEOID, votes_total)

# Generally speaking, we do not need to remove columns from our data frame in order to do analyses. However, `select()` can be useful if you want to create a smaller data frame to view or export.
elec |>
  arrange(desc(votes_rep)) |>
  select(state, GEOID, votes_rep) |>
  slice_head(n = 10)

### `group_by()` and `summarize()`

# We can use `summarize()` all by itself to get summary statistics about the entire data frame. For example, if I want to know the average raw vote in a precinct for each candidate in the data set, I could do:
summarize(
  elec,
  avg_harris = mean(votes_dem, na.rm = T),
  avg_trump = mean(votes_rep, na.rm = T)
)

# But often, we want to know these statistics for particular *groups*. For example, what if I want to know the results by state? `group_by()` tells R that it should calculate the summary statistics (or do any other operation) by group. This means that `summarize()` will produce one row per group, rather than one row for the entire data frame.
elec |>
  group_by(state) |>
  summarize(
    total_votes_harris = sum(votes_dem, na.rm = T),
    total_votes_trump = sum(votes_rep, na.rm = T),
    harris_two_party_pct = total_votes_harris /
      (total_votes_harris + total_votes_trump)
  )

# This is a case where piping into a `ggplot` is particularly useful. Our `group_by()` and `summarize()` will generate a new data frame -- we can just pass it in as the data to `ggplot()` using the pipe:
elec |>
  group_by(state) |>
  summarize(
    total_votes_harris = sum(votes_dem, na.rm = T),
    total_votes_trump = sum(votes_rep, na.rm = T),
    harris_two_party_pct = total_votes_harris /
      (total_votes_harris + total_votes_trump)
  ) |>
  ggplot() +
  geom_col(aes(
    x = reorder(state, desc(harris_two_party_pct)), # You must arrange *within* a ggplot using reorder()!
    y = harris_two_party_pct
  )) +
  labs(
    y = "Harris Vote Share (%)",
    x = "State",
    title = "2024 Presidential Election Results",
    caption = "Source: New York Times"
  ) +
  theme_classic()
