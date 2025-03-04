# File Name: 	  	  joins_and_tidy_data_teachingkey.R
# File Purpose:  	  Joins and Tidy Data
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2025-03-02

# Today, we are going to learn how to combine the columns from two data frames using joins.

# We will also talk about tidy data. Tidy data is a way of structuring data sets that makes data easier to work with (especially with ggplot2). We will learn two functions, pivot_wider() and pivot_longer(), that will help you generate tidy data.

library(tidyverse)

#############
### Joins ###
#############

# But first, we need some data to work with! You've previously been introduced to the Voteview database (https://voteview.com/) that estimates the ideology of members of Congress based on their voting behavior - known as a DW-NOMINATE score. The Voteview team has an R package called "Rvoteview" that will allow us to download the data on House members from the current (119th) Congress.
# To download this package, you will also need to install the "remotes" package from CRAN.
install.packages("remotes")
library(remotes)
install_github("voteview/Rvoteview")
library(Rvoteview)

members <- member_search(congress = 119, chamber = "House")

# As you'll recall, each member is scored on two dimensions: economic ideology and an "other" category that represents different issue areas over time. Our goal today is to see if we can get a sense of what this second dimension might represent in the 119th Congress. To do this, we will see if there is a relationship between the characteristics of a member's district and their DW-NOMINATE score.

# I've already provided you with data on each Congressional district in your "data/" folder. This data is provided by the Redistricting Data Hub (https://redistrictingdatahub.org/). Let's load the data.

cd <- read_csv("data/congressional_district_data.csv")

# There are a few variables in this data that we might want to look at. For example, we might hypothesize that the second dimension relates to immigration politics. This data includes the number of residents in a Congressional district who self-identify as Hispanic, as well as the percent of the district who are foreign born.

# Let's prepare this data frame
immigration <- cd |>
  select(state_abbrev, DISTRICT, TOTPOP20, Hispanic, FOREIGN_BORN_pct)

# In order to combine the members data with the district data, we need to use a "join". There are four types of joins:

# inner_join(x, y): keep only the rows that match in both x and y
# full_join(x, y): keep all the rows in both x and y
# left_join(x, y): keep all the rows in x and the matching rows in y
# right_join(x, y): keep all the rows in y and the matching rows in x

# We can also think of these as a Venn diagram: https://d33wubrfki0l68.cloudfront.net/aeab386461820b029b7e7606ccff1286f623bae1/ef0d4/diagrams/join-venn.png

# In order to make a join, we need to identify the "key" - the field that links two data frames together. The key helps ensure that we only match row(s) in one data frame to the appropriate row(s) in the other data frame.

####################
### inner_join() ###
####################

install.packages("tidylog")
library(tidylog)
# To turn off tidylog, run detach("package:tidylog", unload = TRUE)



# What happened to 7 of our rows? These are cases where the keys did not match.

####################
### full_join() ###
####################



####################
### left_join() ###
####################



####################
### right_join() ###
####################



# Which merging join we want to use depends on what our unit of analysis is. Typically, we will want to do an inner_join() or a left_join() where the x data frame contains the units we are interested in exploring. For example, in this analysis, we only care about districts where we have a member's DW-NOMINATE score, so we should do a left join with the members data as the x data frame.



# Now we can do our analysis - how related are these variables with a member's second dimension DW-NOMINATE score?

# We have two continuous variables, so a scatterplot with best fit line would be appropriate here.




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

# Is our merged data "tidy data"? It depends on how we're using it, but another way to think about it is: can we make a ggplot comparing the percentage of the vote received by Joe Biden against the two dimensions of DW-NOMINATE on the same graph?



# No, because we need a single variable to put in our aes() function. This is where we can use the pivot_longer() function, which takes multiple columns and turns them into rows (so we are making our data frame longer).



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

hot100 <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2021/2021-09-14/billboard.csv")

# Let's create a table that shows the top three songs on the Billboard 100 chart. We could have a table with three columns (Week, Position, Song), but it might look better to have a table with four columns (Week, Song1, Song2, Song3).


