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

ggplot(data = penguins) +
  geom_bar(mapping = aes(x = species))

#=====================================
# Continuous variable: histogram
#=====================================

ggplot(data = penguins) +
  geom_histogram(mapping = aes(x = flipper_length_mm), binwidth = 10)

# Try it yourself! --------------------------------------------------------

# The data consists of three study years. How many penguins are studied in each year?

ggplot(data = penguins) +
  geom_bar(mapping = aes(x = year))

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

ggplot(data = penguins) +
  geom_bar(aes(x = island, fill = species), position = "dodge")

# Notice how geom_bar() does all of the counting for us - we just provide the data and the names of the variables. What if we want to be specific about which values to show? Then, we need to use geom_col(), which takes a *table of values* rather than the raw data itself.

species_by_island <- count(penguins, island, species, .drop = FALSE)

ggplot(data = species_by_island) +
  geom_col(aes(x = island, y = n, fill = species), position = "dodge")

# Let's add our first customization. There are some built in "themes" in {ggplot2} that can quickly turn a graph into something much more attractive.
p <- ggplot(data = penguins) +
  geom_bar(aes(x = island, fill = species), position = "dodge")

p +
  theme_bw()

p +
  theme_minimal()

p +
  theme_classic()

# Let's also add some labels to this graph. We can do this with the labs() function. Every element inside of an aes() mapping can get a label, as well as the title, axis labels, and caption.
p +
  theme_classic(base_size = 12) +
  labs(title = "Species of Penguins on Each Island",
       x = "Island",
       y = "Count",
       fill = "Species",
       caption = "Source: {palmerpenguins} package.")

# Normally, the order that we put our layers in doesn't matter, except for this one case. If we want to modify a built-in theme, we have to do so *after* we ask for that theme. Otherwise, the built-in theme will override our changes.

p +
  theme_classic(base_size = 12) +
  labs(title = "Species of Penguins on Each Island",
       x = "Island",
       y = "Count",
       fill = "Species",
       caption = "Source: {palmerpenguins} package.") +
  theme(plot.title = element_text(hjust = .5))

p +
  theme(plot.title = element_text(hjust = .5)) +
  theme_classic(base_size = 12) +
  labs(title = "Species of Penguins on Each Island",
       x = "Island",
       y = "Count",
       fill = "Species",
       caption = "Source: {palmerpenguins} package.")

# Try it yourself! --------------------------------------------------------

# Download the package {ggthemes} and load it. Use the following code to see all of the available themes in {ggthemes}. Choose one and apply it to our graph.
install.packages("ggthemes")
library(ggthemes)
help(package = "ggthemes")
p +
  theme_tufte()

#=====================================
# 1 discrete variable, 1 continuous variable
#=====================================

# How does flipper length differ by penguins' sex?

# Box and whisker plot

ggplot(data = penguins[!is.na(penguins$sex),]) +
  geom_boxplot(aes(x = sex, y = flipper_length_mm)) +
  labs(x = "Sex",
       y = "Bill Length (mm)",
       title = "Penguin Flipper Length by Sex",
       caption = "Source: {palmerpenguins} package") +
  theme_wsj() +
  theme(plot.title = element_text(hjust = .5))

# Violin plot

ggplot(data = penguins[!is.na(penguins$sex),]) +
  geom_violin(aes(x = sex, y = flipper_length_mm), fill = "steelblue") +
  labs(x = "Sex",
       y = "Bill Length (mm)",
       title = "Penguin Flipper Length by Sex",
       caption = "Source: {palmerpenguins} package") +
  theme_wsj() +
  theme(plot.title = element_text(hjust = .5))

# So far, we've only changed the design of the graph; we haven't changed anything that relates to the data. But on this graph, the scale of the y-axis might be distorting differences to make them appear larger than they actually are. We can modify the way that the *data* is displayed using the scale functions.

# The general format is scale_aesthetic_vartype, e.g., scale_y_continuous

ggplot(data = penguins[!is.na(penguins$sex),]) +
  geom_boxplot(aes(x = sex, y = flipper_length_mm)) +
  labs(x = "Sex",
       y = "Bill Length (mm)",
       title = "Penguin Flipper Length by Sex",
       caption = "Source: {palmerpenguins} package") +
  theme_wsj() +
  theme(plot.title = element_text(hjust = .5)) +
  scale_y_continuous(limits = c(0,250), breaks = seq(0, 250, 25)) +
  scale_x_discrete(labels = c("Female", "Male"))

# Try it yourself! -----------------------------------------------------

# Make a violin plot of body mass by penguin species.

ggplot(data = penguins) +
  geom_violin(aes(x = species, y = body_mass_g, fill = species)) +
  scale_y_continuous(limits = c(0,NA)) +
  labs(x = "Species",
       y = "Body Mass (g)",
       title = "Penguin Body Mass by Species",
       caption = "Source: {palmerpenguins} package") +
  theme_fivethirtyeight() +
  theme(plot.title = element_text(hjust = .5))

#=====================================
# 2 continuous variables
#=====================================

# Scatterplot

# Are flipper length and body mass related?

ggplot(data = penguins) +
  geom_point(aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_smooth(aes(x = flipper_length_mm, y = body_mass_g), method = "lm", se = F, linetype = "dashed", linewidth = 2) +
  theme_classic() +
  labs(x = "Flipper Length (mm)",
       y = "Body Mass (g)",
       title = "Heavier Penguins Have Bigger Flippers",
       caption = "Source: {palmerpenguins} package") +
  theme(plot.title = element_text(hjust = .5))

# Why is it acceptable to leave the axis values where they are rather than set them to 0? Because we are interested in the general direction of the relationship (positive or negative) between these variables rather than the values themselves. We would need statistics to measure the *strength* of the relationship.


# Try it yourself! --------------------------------------------------------

# Are bill length and bill depth related?

ggplot(data = penguins) +
  geom_point(aes(x = bill_length_mm, y = bill_depth_mm), color = "gold") +
  geom_smooth(aes(x = bill_length_mm, y = bill_depth_mm), method = "lm", se = F, linetype = "dotted", linewidth = 2, color = "forestgreen") +
  theme_classic() +
  labs(x = "Bill Length (mm)",
       y = "Bill Depth (mm)",
       title = "Negative Correlation Between Bill Length and Depth",
       caption = "Source: {palmerpenguins} package") +
  theme(plot.title = element_text(hjust = .5))

# Line graph
# This usually occurs when the y-axis is ordered, like time. For example, let's create a data frame that shows the mean bill length for each year of the study. You'll learn how to understand this code in the next module of the course.
number_penguins <- count(penguins, year)

ggplot(data = number_penguins, mapping = aes(x = year, y = n)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = c(2007:2009)) +
  scale_y_continuous(limits = c(0, NA)) +
  labs(x = "Year",
       y = "Number of Penguins",
       title = "Number of Penguins Each Year",
       caption = "Source: {palmerpenguins} package") +
  theme_few() +
  theme(plot.title = element_text(hjust = .5))

#=====================================
# Multivariate Graphs
#=====================================

# Does the living environment of penguins affect their growth? Compare the bill length of both sexes of penguin on each island.
living_env <- 
  penguins |> 
  group_by(sex, island) |> 
  summarize(mean_bill_length_mm = mean(bill_length_mm, na.rm = T)) |>
  filter(!is.na(sex))

# Add a new aesthetic mapping

ggplot(data = living_env) +
  geom_col(aes(x = sex, y = mean_bill_length_mm, fill = island), position = "dodge") +
  scale_fill_manual(values = c("palegreen4", "steelblue4", "salmon")) +
  scale_x_discrete(labels = c("Female", "Male")) +
  labs(x = "Sex",
       y = "Mean Bill Length (mm)",
       fill = "Island",
       title = "Biscoe Island Has Plump Penguins",
       caption = "Source: {palmerpenguins} package") +
  theme_economist() +
  theme(plot.title = element_text(hjust = .5),
        legend.position = "bottom")

# Is the relationship between flipper length and body mass different by species?
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = F) +
  labs(x = "Flipper Length (mm)",
       y = "Body Mass (g)",
       color = "Species",
       title = "Flipper Length and Body Mass by Species",
       caption = "Source: {palmerpenguins} package") +
  theme_bw() +
  theme(plot.title = element_text(hjust = .5))
  
# Use facets

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point() +
  geom_smooth(method = "lm", se = F) +
  facet_wrap(~ species) +
  labs(x = "Flipper Length (mm)",
       y = "Body Mass (g)",
       color = "Species",
       title = "Flipper Length and Body Mass by Species",
       caption = "Source: {palmerpenguins} package") +
  theme_bw() +
  theme(plot.title = element_text(hjust = .5))

# Try it yourself! --------------------------------------------------------

# Using both an additional aesthetic mapping AND facets, make a graph with 4 variables: How are bill length and bill depth related, for both sexes of penguins, on each island?

ggplot(penguins[!is.na(penguins$sex),], aes(x = bill_length_mm, y = bill_depth_mm, color = sex)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  facet_wrap(~ island) +
  scale_color_manual(values = c("rosybrown", "dodgerblue")) +
  labs(x = "Bill Length (mm)",
       y = "Bill Depth (mm)",
       color = "Sex",
       title = "Bill Length and Depth by Sex and Island",
       caption = "Source: {palmerpenguins} package") +
  theme_classic() +
  theme(plot.title = element_text(hjust = .5))