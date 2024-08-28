# Introduction to R and RStudio -------------------------------------------

# Posit Cloud is made up of "projects." You can create your own projects or open one of the professor's projects as a template. If you open one of the professor's projects, be sure to save a permanent copy so that you will be able to return to it later.

# Once you start a Posit Cloud project, it is like leaving a tab open in your browser, or leaving an app open on your phone. When you open it later, you will return to where you last left off.

# What if you need to restart? You can use the "Restart R" from the "Session" menu if you just want a new R session; if that does not work, you can use "Relaunch Project". (This will be relevant information later.)

# If it is not already open, click on "introduction_base_r.R" in the Files pane on the right side of your screen.

# Script pane
  # Scripts save as .R files

  # Always include a header at the top of your script as a helpful hint to your future self
  
  # File Name: 	  	  introduction_base_r.R
  # File Purpose:  	  Introduction and Base R
  # Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
  # Date Created:     2024-08-27

# Console
  # This is where the R code is actually run

# We will talk about the other panes as we encounter them. But let's start using the Script pane and Console right away! Execute the following code:
print("Hello world!")

# There are several ways to execute code in RStudio:
# 1. Write directly into the console (or use the up and down arrows to access your history)
# 2. Highlight the code and hit the "Run" button in the Script pane
# 3. Cmd + Enter on Mac, Ctrl + Enter on PC moves code from the Script pane to the Console

# One important thing to know: anything lines starts with "#" will not be treated as code, but as text! So nothing will happen if you try to run:
# print("R is brat.")
# But if we remove the "#":
print("R is brat.")

# We'll start our R journey by establishing three ideas:
# 1. R collects objects
# 2. Objects are made up of vectors
# 3. Vectors have different types

# So what is a "vector"? A vector is a list of items with a length from 1 to infinity.
# We can make vectors using the R function c() - which stands for "combine"
# We separate items in a vector using a comma
# Let's make a vector with the names of the members of your family
c("Nicky", "Ariel", "Finn")

# There are a few rules regarding vectors:
  # All elements of a vector must be of the same class (type)
  # Some of the types include character, numeric (also called integer or double), logical, factor, datetime, and others
  class(c(1,2,3))
  class(c("School", "of", "Media", "and", "Public", "Affairs"))
    # Notice that words go inside of quotations
  class(c(TRUE, FALSE))
  
  # Look what happens when we try to combine two types of vectors
  c(1, "1")
  class(c(1, "1"))
  c(1, TRUE)
  class(c(1, TRUE))
  c(FALSE, "0")
  class(c(FALSE, "0"))
  
  # There is a special item you can add to a vector of any type (it's like a wildcard): NA
  c("X", "Y", "Z", NA, "A", "B", "C")
  
  # There are a couple of useful tools that can make vectors easier to create.
  c(1:10)
  seq(from = 1, to = 25, by = 5)
    # Why didn't I need c() for this? Because seq() returns (outputs) a vector!
  rep("Gimme", 3)
  

# Try it yourself! --------------------------------------------------------

# Create a vector that repeats the sequence 20, 40, 60, 80, 100 three times. Hint: we will nest our functions, like class(c())
  
  
# What if we want to save our vectors to use them later? We will save them as "objects".

# R collects objects using the "assignment operator": <-
  oscar_nominees <- c("Emma Stone", "Annette Bening", "Lily Gladstone", "Sanda Huller", "Carey Mulligan")
  # Why do we not use = for assignment like in other programming languages?

# Rules for object names
  # Letters, numbers, ".", and "_"
  # May not start with a number
  # Case-sensitive
  Oscar_nominees
  # Use a consistent style and names that will make sense to "future you" and others

# Objects can represent pretty much anything - including other objects! These include complex arrangements of multiple vectors that make it easier to work with data. The one that we will use with most often is called the data frame.
  olympic_cities <- c("Rio de Janeiro", "Pyeongchang", "Tokyo", "Beijing", "Paris")
  years <- seq(from = 2016, to = 2024, by = 2)
  
  # What if we need to change an item in one of our vectors? We can call elements of vectors using [ ]
  years[3] <- 2021
  olympic_cities[c(1,3,5)]
  olympic_cities[-1]
  
  olympics <- data.frame(city = olympic_cities, year = years)
  olympics

# Try it yourself! --------------------------------------------------------
# Create a data frame containing the year, President, and temperature for every presidential inauguration since 1989. Can you use seq() and rep() to reduce your typing?
# Data at: https://www.weather.gov/lwx/events_Inauguration#Present-to-Past

  

# Working with vectors.
  # Subset the elements of a vector using [ ]
  pres[3]
  pres[c(3,5,7)]
  pres[1:10]

  # Put "-" before the number or c() to exclude those elements
  pres[-3]
  pres[-c(3,5,7)]

  # To store a subset of an object, use the <- operator
  pres_since_2000 <- pres[1:6]


# What is a function? -----------------------------------------------------

# A function is an operation applied to a vector
  # A function is always followed by ()
  mean(temp)

  # Functions have "arguments", which are options you can apply to your function
  mean(c(2,4,6,NA), na.rm = TRUE)

  # Packages contain functions that you can use in addition to the functions that come pre-built in R
  # To see this in action, let's install the {weathermetrics} package: https://cran.r-project.org/web/packages/weathermetrics/index.html
  install.packages("weathermetrics")
  library(weathermetrics)

  fahrenheit.to.celsius(temp, round = 3)
  
# Data frames --------------------------------------------------------------

# A series of vectors in tabular form is called a data frame (also sometimes called a tibble, a type of data frame). Think Excel spreadsheet, but in R.
  # You can make data frames by hand using data.frame()
  inaugurations <- data.frame(pres, year, temp)
  
  # Some packages also have data pre-installed data frames
  data(newhaven)
  ?newhaven
  
  # We will learn how to read data from .csv files and other sources later in the course.
  
  # There are a few ways to quickly understand what your data frame looks like: View(), summary(), head(), and glimpse(). This last one comes from the tidyverse (remember library(tidyverse) from above?)
  View(inaugurations)
  summary(inaugurations)
  head(inaugurations)
  glimpse(inaugurations)

  # We can subset data frames using [], just like vectors. Because data frames have two dimensions rather than one, our subsets [] need two numbers: [rows, columns]
  inaugurations[18, 2]
  inaugurations[18,]
  inaugurations[,2]
  inaugurations[,c(2, 3)]
  inaugurations[-c(1:10),c(2, 3)]


  # As you can see above, a data frame is just a series of vectors, and we give each of those vectors a name (a header, field name, variable name, column name, whatever you want to call it). You can call a single one of these vectors by name using $.
  inaugurations$temp
  
  

# End of Day 1 ------------------------------------------------------------


# Start of Day 2 ----------------------------------------------------------

options(tibble.width = Inf)
# Let's review some important information from last week's class.
  
# install.packages() vs. library()
  
  # We use install.packages() once in each new project; we use library() once in each session of R
  # This is one reason why we always record our code in the .R script rather than just typing away in the console below
  # But wait: Posit Cloud restored everything from last week when I opened it - my objects, my loaded packages, even my console history. Why bother recording everything if nothing gets lost?
  # Two reasons: when you share your code (e.g., with the professor for an assignment), the other user needs to be able to reproduce your work. Also, if your R session ever restarts, such as when you have a bug, you don't want to lose all your hard work and not know how to recreate it.
  
# The core building block of R is an object, and most objects are vectors.
example <- c("this", "is", "a", "character", "vector")
class(example)
  
  # We can subset vectors using [ ]
    BostonMarathon <- c(1897:2023)
    BostonMarathon[-c(length(1897:1918), length(1897:2020))]
  
# A data frame is a two-dimensional table of vectors
  
  # We subset data frames in two ways: [rows, columns] and $
    year <- c(2018:2023)
    winner <- c("Desiree Linden", "Worknesh Degefa", NA, "Edna Kiplagat", "Peres Jepchirchir", "Hellen Obiri")
    BostonMarathon <- data.frame(year, winner)
    glimpse(BostonMarathon)
    BostonMarathon[,2]
    BostonMarathon[6,]
    BostonMarathon$winner

  # We will talk a lot more about modifying data frames in the data wrangling portion of the course, but there are a few basic tasks you can carry out right now.

    # Adding new columns using $
    BostonMarathon$country <- c("United States", "Ethiopia", NA, rep("Kenya", 3))

    # Modifying a column
    BostonMarathon$winner[is.na(BostonMarathon$winner)] <- "Canceled due to the COVID-19 pandemic"
    note <- "Canceled due to the COVID-19 pandemic"
    BostonMarathon$country[is.na(BostonMarathon$country)] <- note

    # Selecting rows using logical operators
    BostonMarathon[BostonMarathon$country == "Kenya",]

  # Important! Any changes you make need to be saved using an <- operator


# Try it yourself! --------------------------------------------------------

# First, install the "nycflights13" package and load it using library()
install.packages("nycflights13")
library(nycflights13)

# Then, run the following to load the "flights" data frame
data(flights)

# Look at the help file for the data frame you just loaded
?flights

# Explore the data frame using glimpse()
glimpse(flights)

# Now we want to find out how many flights were delayed by 30 minutes or more when departing JFK airport. First, subset the data frame to only those rows where the origin airport is "JFK"
flights <- flights[flights$origin == "JFK",]

# Now subset the data frame again, to only those rows where the departure delay is greater than or equal to 30.
flights <- flights[flights$dep_delay >= 30,]

# Use the nrow() function to get the number of rows in the resulting data frame (flights from JFK with departure delays of at least 30 minutes).
nrow(flights)

# Create a new column that represents the departure delay in hours rather than minutes (i.e., divide departure delay by 60).
flights$dep_delay_hours <- flights$dep_delay/60

# What is the average departure delay of these flights in hours? Hint: look at the help file for "mean". How can you ask this function to ignore the flights where the departure delay is NA (because the flight was cancelled)?
mean(flights$dep_delay_hours, na.rm= TRUE)
    

# More Base R Tips and Tricks ---------------------------------------------

# %in% operator
  # Let's say we wanted to limit our data to only the "Big Three" U.S. airlines: American, Delta, and United
  major_airlines <- flights[flights$carrier == c("AA", "DL", "UA"),]
  nrow(major_airlines)
  major_airlines <- flights[flights$carrier %in% c("AA", "DL", "UA"),]
  nrow(major_airlines)
  
# table() for quick checks
  table(flights$month)
  table(flights$month, flights$origin)
  
# & and | for multiple conditions
  flights[flights$dep_delay > 0 & flights$ arr_delay <= 0,]
  flights[flights$dep_delay > 0 | is.na(flights$dep_delay),]

#! for "not" conditions
  # Remember that != is "does not equal"
  flights[flights$month != 2 & flights$day != 8 & flights$day != 9,]
  # We can also use ! to negate entire expressions or functions
  flights[flights$month != 2 & !(flights$day %in% c(8, 9)),]
  flights[!is.na(flights$dep_delay),]

# ifelse for if... else... choices
  flights$late <- ifelse(flights$arr_delay >= 0 & !is.na(flights$arr_delay), TRUE, FALSE)
  prop.table(table(flights$late))
  
# Try it yourself! --------------------------------------------------------
  
# Looking only at airports actually located in New York City (JFK and LGA) and flights that were not cancelled, create a column that is 1 if the flight left on time or early but arrived late and 0 otherwise.
  
dta <- flights[flights$origin %in% c("JFK", "LGA") & !is.na(flights$dep_delay),]
dta$dest_delay <- ifelse(dta$dep_delay <= 0 & dta$arr_delay > 0, 1, 0)

# How many flights left on time or early but arrived late?
table(dta$dest_delay)

# What proportion of flights left on time or early but arrived late?
mean(dta$dest_delay, na.rm = T)