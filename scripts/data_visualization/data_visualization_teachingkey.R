# File Name: 	  	  data_visualization_teachingkey.R
# File Purpose:  	  Pre-lab video lecture on data visuzalization in R with {ggplot2}
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Last Modified:    2025-09-02

# This is a .R file, which contains R code that we can send to the Console below - that is where R actually runs the code. As a reminder, the keyboard shortcut to send code to the Console is Cmd + Enter (or Ctrl + Enter on Windows).

# What is all this green stuff? These are comments, and they are preceded by the # symbol. R ignores everything on a line that comes after a # symbol. Comments are very important for explaining what your code does, and they are also useful for making notes to yourself about what you want to do later. You should get into the habit of writing comments in your code.

# Now let's start coding! We're going to be making graphs in R using the {ggplot2} package.

# There are many ways to make graphs in R, but the most popular way is with the {ggplot2} package. {ggplot2} is part of the "tidyverse," a collection of packages that work well together and share similar syntax. We'll be introduced to more tidyverse packages later in the course.

# The tidyverse can be installed all at once with the command below. You only need to do this once per R installation. If you are using Posit Cloud, you will need to do this every time you start a new project.

install.packages("tidyverse")

# There are a couple of other packages that we will be using today, so we will install them separately. You only need to install a package once per R installation. If you are using Posit Cloud, you will need to install them every time you start a new project.

install.packages("palmerpenguins")
install.packages("remotes") # This is just to install the "nbmisc" package from GitHub
remotes::install_github("nickybell/nbmisc")

# Now we can load the packages. We do this using the library() function. You need to do this every time you start a new R session, including in Positron. Therefore, it is a good idea to put all of your library() calls at the top of your script.
library(tidyverse)
library(palmerpenguins)

# Normally we will load data from an external file such as a CSV, but for this lesson we will use the "penguins" data frame that comes included with the {palmerpenguins} package. This data frame contains measurements for three species of penguins (Adelie, Chinstrap, and Gentoo) that were collected from three islands in the Palmer Archipelago, Antarctica.
data(penguins)

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

# The combination of variable types and number of variables will determine which graph you should create. I've made a reference guide that you can go back to when you've forgotten which type of graph to use. Remember how we instaled the "nbmisc" package earlier? This reference is part of that package.
library(nbmisc)
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

#=====================================
# Bivariate graphs
#=====================================

#=====================================
# 2 discrete variables
#=====================================

# What species of penguins live on each island?
# It is useful to think of this like a table where you have a count for each combination of categories. Don't worry about how this code works for now, just run it to see the table.
count(penguins, island, species, .drop = FALSE)

# Bar graph

ggplot(data = penguins) +
  geom_bar(aes(x = island, fill = species), position = "dodge")

# Notice how geom_bar() does all of the counting for us - we just provide the data and the names of the variables. What if we want to be specific about which values to show? Then, we need to use geom_col(), which takes a *table of values* rather than the raw data itself.
species_by_island <- count(penguins, island, species, .drop = FALSE)

# The <- is called the assignment operator. It assigns the value on the right to the name on the left. This is how we create new objects in R.

# Once we've created an object that contains this new data frame, we can use it in our graph.
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

# There are also other packages the contain additional themes you can use on your graphs. Download the package {ggthemes} and load it. Use the following code to see all of the available themes in {ggthemes}. Choose one and apply it to our graph.
install.packages("ggthemes")
library(ggthemes)
help(package = "ggthemes")

p +
  theme_tufte()

# Let's also add some labels to this graph. We can do this with the labs() function. Every element inside of an aes() mapping can get a label, as well as the title, axis labels, and caption.
p +
  theme_classic(base_size = 12) +
  labs(
    title = "Species of Penguins on Each Island",
    x = "Island",
    y = "Count",
    fill = "Species",
    caption = "Source: {palmerpenguins} package."
  )

#=====================================
# 1 discrete variable, 1 continuous variable
#=====================================

# How does flipper length differ by penguins' sex?

# Box and whisker plot

ggplot(data = penguins) +
  geom_boxplot(aes(x = sex, y = flipper_length_mm)) +
  labs(
    x = "Sex",
    y = "Bill Length (mm)",
    title = "Penguin Flipper Length by Sex",
    caption = "Source: {palmerpenguins} package"
  ) +
  theme_wsj(base_size = 6)

# So far, we've only changed the design of the graph; we haven't changed anything that relates to the data. But on this graph, the scale of the y-axis might be distorting differences to make them appear larger than they actually are. We can modify the way that the *data* is displayed using the scale functions.

# The general format is scale_aesthetic_vartype, e.g., scale_y_continuous

ggplot(data = penguins) +
  geom_boxplot(aes(x = sex, y = flipper_length_mm)) +
  labs(
    x = "Sex",
    y = "Bill Length (mm)",
    title = "Penguin Flipper Length by Sex",
    caption = "Source: {palmerpenguins} package"
  ) +
  theme_wsj() +
  scale_y_continuous(limits = c(0, 250)) +
  scale_x_discrete(labels = c("Female", "Male", "Unknown"))

#=====================================
# 2 continuous variables
#=====================================

# Scatterplot

# Are flipper length and body mass related?

ggplot(data = penguins) +
  geom_point(aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_smooth(
    aes(x = flipper_length_mm, y = body_mass_g),
    method = "lm",
    se = F,
    linetype = "dashed",
    linewidth = 2
  ) +
  theme_classic() +
  labs(
    x = "Flipper Length (mm)",
    y = "Body Mass (g)",
    title = "Heavier Penguins Have Bigger Flippers",
    caption = "Source: {palmerpenguins} package"
  ) +
  theme(plot.title = element_text(hjust = .5))

# Why is it acceptable to leave the axis values where they are rather than set them to 0? Because we are interested in the general direction of the relationship (positive or negative) between these variables rather than the values themselves. We would need statistics to measure the *strength* of the relationship.

# Line graph

# This usually occurs when the y-axis is ordered, like time. For example, let's create a data frame that shows the mean bill length for each year of the study. You'll learn how to understand this code in the next module of the course.
number_penguins <- count(penguins, year)

ggplot(data = number_penguins, mapping = aes(x = year, y = n)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = c(2007:2009)) +
  scale_y_continuous(limits = c(0, NA)) +
  labs(
    x = "Year",
    y = "Number of Penguins",
    title = "Number of Penguins Each Year",
    caption = "Source: {palmerpenguins} package"
  ) +
  theme_few() +
  theme(plot.title = element_text(hjust = .5))

# Let's review what we've learned so far:
# 1. The grammar of graphics: data, aesthetics, geometric objects
# 2. Types of variables: discrete vs continuous
# 3. Number of variables: univariate, bivariate, multivariate
# 4. Types of graphs: bar graph, histogram, boxplot, scatterplot, line graph
# 5. Customizing graphs: themes, labels, scales
# 6. Saving graphs: use the Export button in the Plots pane
# You can always refer back to the types_of_graphs() function from the {nbmisc} package if you forget which type of graph to use.
