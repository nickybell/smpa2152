# File Name: 	  	  data_visualization_teachingkey.R
# File Purpose:  	  Data Visualization
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Last Modified:    2025-01-26

# Today, we are going to use the {ggplot2} package to make graphs. We will need to install {ggplot2}. We will also want to install the {palmerpenguins} package. We will be using the "penguins" data from the {palmerpenguins} package.
install.packages("ggplot2")
install.packages("palmerpenguins")

# Now we can load the packages and the "penguins" data frame.
library(ggplot2)
library(palmerpenguins)
data(penguins)

# We don't need the "penguins_raw" data frame, so we can remove it.
rm(penguins_raw)


# The grammar of graphics -------------------------------------------------

# The "grammar of graphics" was created by Leland Wilkinson to describe the way that we make data visualizations. We can imagine building a graph like constructing a sentence: we are adding nouns, verbs, adjectives, conjunctions, etc. together to form a complete sentence. In {ggplot2}, we are going to build graphs by adding "layers" together.

# A statistical graphic is a MAPPING of DATA variables to AESthetic attributes of GEOMetric objects.

# Why did I capitalize certain words above? Because they are all words that appear in ggplot code. A ggplot always contains these elements, at minimum:
  # ggplot() function: indicates the data frame to use
  # geom_() function: indicates the type of graph to build
  # The geom_() function includes a mapping to an aesthetic:
    # e.g., geom_line(mapping = aes(x = distance, y = time))
  # The lines are connected with a '+' sign

# Over the course of this class, we will learn how to apply more customization layers to our graphs so that they look the way we would like. But we will start with very simple graphs with only the minimum number of layers.

# Okay, let's get started. When you are making a graph, the first thing to think about is the type of data you are working with: discrete or continuous.
# Discrete variables do not exist on the number line; they are categories
# Continuous variables exist on the number line; they are numbers
  # Not all numbers are continuous! E.g., months (1 to 12)
  # These numbers do not have relational meaning; they are merely symbols that replace words

# The second thing to think about is how many variables you are graphing: univariate (one variable), bivariate (two variables), or multivariate (3+ variables)?

# The combination of variable types and number of variables will determine which graph you should create. I've made a reference guide that you can go back to when you've forgotten which type of graph to use. To use it, you need to install my personal package, called {nbmisc}.
install.packages("remotes")
remotes::install_github("nickybell/nbmisc")
library(nbmisc)

# Once you have installed the package in your R session (once!), you can pull up the reference by running this function:
types_of_graphs()

#=====================================
# Univariate graphs
#=====================================

#=====================================
# Discrete variable: bar graph
#=====================================

# When working with univariate graphs, we are often just counting values



#=====================================
# Continuous variable: histogram
#=====================================



# Try it yourself! --------------------------------------------------------

# The data consists of three study years. How many penguins are studied in each year?


#=====================================
# Bivariate graphs
#=====================================

#=====================================
# 2 discrete variables
#=====================================

# What species of penguins live on each island?
# It is useful to think of this like a table where you have a count for each combination of categories. Don't worry about how this code works for now, just run it to see the table.
library(dplyr)
count(penguins, island, species, .drop = FALSE)

# Bar graph


# Notice how geom_bar() does all of the counting for us - we just provide the data and the names of the variables. What if we want to be specific about which values to show? Then, we need to use geom_col(), which takes a *table of values* rather than the raw data itself.

species_by_island <- count(penguins, island, species, .drop = FALSE)


# Let's add our first customization. There are some built in "themes" in {ggplot2} that can quickly turn a graph into something much more attractive.


# Let's also add some labels to this graph. We can do this with the labs() function. Every element inside of an aes() mapping can get a label, as well as the title, axis labels, and caption.


# Normally, the order that we put our layers in doesn't matter, except for this one case. If we want to modify a built-in theme, we have to do so *after* we ask for that theme. Otherwise, the built-in theme will override our changes.



# Try it yourself! --------------------------------------------------------

# Download the package {ggthemes} and load it. Use the following code to see all of the available themes in {ggthemes}. Choose one and apply it to our graph.

help(package = "ggthemes")


#=====================================
# 1 discrete variable, 1 continuous variable
#=====================================

# How does flipper length differ by penguins' sex?

# Box and whisker plot



# Violin plot



# So far, we've only changed the design of the graph; we haven't changed anything that relates to the data. But on this graph, the scale of the y-axis might be distorting differences to make them appear larger than they actually are. We can modify the way that the *data* is displayed using the scale functions.

# The general format is scale_aesthetic_vartype, e.g., scale_y_continuous


# Try it yourself! -----------------------------------------------------

# Make a violin plot of body mass by penguin species.


#=====================================
# 2 continuous variables
#=====================================

# Scatterplot

# Are flipper length and body mass related?


# Why is it acceptable to leave the axis values where they are rather than set them to 0? Because we are interested in the general direction of the relationship (positive or negative) between these variables rather than the values themselves. We would need statistics to measure the *strength* of the relationship.


# Try it yourself! --------------------------------------------------------

# Are bill length and bill depth related?



# Line graph
# This usually occurs when the y-axis is ordered, like time. For example, let's create a data frame that shows the mean bill length for each year of the study. You'll learn how to understand this code in the next module of the course.
number_penguins <- count(penguins, year)



#=====================================
# Multivariate Graphs
#=====================================

# Does the living environment of penguins affect their growth? Compare the bill length of both sexes of penguin on each island.


# Add a new aesthetic mapping



# What is stat = "identity" and why do we need it? That is our way of telling geom_bar not to count the penguins

# Is the relationship between flipper length and body mass different by species?

  

# Use facets



# Try it yourself! --------------------------------------------------------

# Using both an additional aesthetic mapping AND facets, make a graph with 4 variables: How are bill length and bill depth related, for both sexes of penguins, on each island?
