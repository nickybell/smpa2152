# File Name: 	  	  joins_and_tidy_data.R
# File Purpose:  	  Joins and Tidy Data
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2024-10-07

# Today, we are going to learn how to combine the columns from two data frames using joins. We will also learn how to use information from one data frame to filter rows in another data frame (so-called "filtering joins").

# We will also talk about tidy data. Tidy data is a way of structuring data sets that makes data easier to work with (especially with ggplot2). We will learn two functions: pivot_wider() and pivot_longer() that will help you generate tidy data.

#############
### Joins ###
#############

# But first, we need to load the Knight-Newhouse data on college athetics that we were working with last class.
options(tibble.width = Inf)
library(tidyverse)
kn <- read_csv("data/knight_newhouse.csv")

# Let's recall what data is available in this data frame:
glimpse(kn)

# Notice that each row has a unique identifier called "ipeds_id". This refers to the Integrated Postsecondary Education Data System, from the Department of Education, that collects data on every instutition of higher education in the United States ever year.

# In your "data/" directory, I've provided some fields from the IPEDS data as "ipeds.csv". Let's read that data into R.


# Notice that the IPEDS data has a column called "id". This is what is known as the "key" - the field that links two data frames together. We can take the data from one data frame and use the key to find the data from a second data frame that should be added (column-wise).

# Imagine if we did this by hand:


# But there's nothing to prevent us from making mistakes when we are just binding columns together:


# The key helps ensure that we only match row(s) in one data frame to the appropriate row(s) in the other data frame. Merging joins allow us to use the key in this way. There are four types of merging joins.

# inner_join(x, y): keep only the rows that match in both x and y
# full_join(x, y): keep all the rows in both x and y
# left_join(x, y): keep all the rows in x and the matching rows in y
# right_join(x, y): keep all the rows in y and the matching rows in x

# We can also think of these as a Venn diagram: https://d33wubrfki0l68.cloudfront.net/aeab386461820b029b7e7606ccff1286f623bae1/ef0d4/diagrams/join-venn.png

####################
### inner_join() ###
####################

library(tidylog)
# To turn off tidylog, run detach("package:tidylog", unload = TRUE)


####################
### full_join() ###
####################



####################
### left_join() ###
####################


####################
### right_join() ###
####################



# Which merging join we want to use depends on what our unit of analysis is. Typically, we will want to do an inner_join() or a left_join() where the x data frame contains the units we are interested in exploring. For example,
# At which schools does each student pay the largest student fee supporting athletics? The relevant variables are student_fees and students.



# We can also use joins known as "filtering joins" to filter one data frame using the matches in another data frame. These are less common but do occasionally come up.

# semi_join(x, y) - includes rows in x that match in y
# anti_join(x, y) - excludes rows in x that match in y



##################
### Tidy Data ####
##################

# What is "tidy data"?

# 1. Each variable must have its own column (but wait, isn't a variable a column?)

# 2. Each observation must have its own row (but wait, isn't an observation a row?)

# 3. Each value must have it's own cell (rarely an issue)

# I've found it easier to think about tidy data in terms of `ggplot2`, which loves tidy data. So if you can imagine what a `ggplot()` function requires from the data, and you can reshape your data into the appropriate form, then you probably have tidy data!

# This is easiest to show through examples.

######################
### pivot_longer() ###
######################

# Is our merged data "tidy data"?
merged <- left_join(kn, ipeds, by = join_by(ipeds_id == id, year))



### Another example

# Let's work with data on political and civil rights around the world from Freedom House (https://freedomhouse.org/explore-the-map?type=fiw&year=2022).

# *1 represents the greatest degree of freedom and 7 the smallest degree of freedom.*

fh <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/6efe01516a73c59e613bb15eec80b7a200d561e7/data/2022/2022-02-22/freedom.csv")

# Let's make a graph showing how political and civil freedoms have changed in a country over time.



#####################
### pivot_wider() ###
#####################

# Here's what Hadley Wickham, Chief Scientist at Posit (RStudio), says about pivot_wider(): 

# "It’s relatively rare to need pivot_wider() to make tidy data, but it’s often useful for creating summary tables for presentation, or data in a format needed by other tools."

# So the example we'll be using is a bit artificial. We will be working with data on the Billboard Hot 100 charts.

hot100 <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/master/data/2021/2021-09-14/billboard.csv")

# Let's create a table that shows the top three songs on the Billboard 100 chart. We could have a table with three columns (Week, Position, Song), but it might look better to have a table with four columns (Week, Song1, Song2, Song3).
