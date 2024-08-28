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
  
  # There are a few ways to quickly understand what your data frame looks like: View(), summary(), and head()
  View(olympics)
  summary(olympics)
  head(olympics)

# Try it yourself! --------------------------------------------------------
# Create a data frame containing the year, President, and temperature for every presidential inauguration since 1989. Can you use seq() and rep() to reduce your typing?
# Call your new data frame "pres"
# Data at: https://www.weather.gov/lwx/events_Inauguration#Present-to-Past

  

# So what is a data frame? It is just a series of vectors arranged into columns! This is why we access items of a data frame similarly to how we access items of a vector. We use the [ ], but now we have two dimensions instead of one, so we have to indicate rows AND columns like this: [rows,columns]
  pres[5,3]
  pres[2, c(1,2)]
  pres[-1,]
    # What happens when we leave either the rows or columns blank? That is the equivalent of saying "everything".
  identical(pres,pres[,])
  
  # There is a very useful feature of a data frame, which is that we can get a single column (vector) of a data frame by name instead of number. We do this using the $ operator.
  pres$Temperature
  identical(temp, pres$Temperature)
  
  # And we can add new columns using the $ operator as well! Let's add a new column to our data frame that is the temperature in Celsius (instead of Fahrenheit).
  pres$Celsius <- (pres$Temperature - 32) * (5/9)
  
  # We can modify existing columns in the same way. Let's use the round() function to round these temperatures to one decimal place.
  pres$Celsius <- round(pres$Celsius, 1)
  

# Try it yourself! --------------------------------------------------------

# Add a new column to the data frame that includes a description of the weather in just one or two words for each inauguration, e.g., "sunny", "rainy", "cloudy"


  
# It can be difficult to pick out the rows of our data frame that we want to see using just the row numbers alone. This is where R's logical operators are useful.
  
  # ==, !=, <, >, <=, >=, %in%
    # These always return a value of TRUE or FALSE
  # Note that equals is "==", not "="
  # == means equals
  5 == 6
  (20/4) == 5
  c("red", "blue", "red", "red", "blue") == "blue"
  # != means NOT equal
  5 != 6
  (20/4) != 5
  c("red", "blue", "red", "red", "blue") != "blue"
  # < is less than
  # > is greater than
  # <= is less than or equal to
  # >= is greater than or equal to
  # %in% allows you to match an == to multiple values
  rep(1:5, 2) %in% c(1,3,5)
  
# We can use logical operators to select particular rows of a data frame.
  pres[pres$Temperature < 32,]
  pres[pres$Year > 2004,]
  
# We can also use & (and) and | (or) to combine logical operators.
  pres[pres$Temperture > 45 & Year > 2010,]
  pres[pres$Year >= 2016 | pres$President == "George H.W. Bush",]

# Try it yourself! --------------------------------------------------------

# Select only the rows of the inauguration weather data frame for Democratic presidents (by name) and for whom the temperature is between 32 and 40 degrees (i.e. greater than or equal to 32 and less than or equal to 40).
  

  
# What is a function? -----------------------------------------------------

# A function is an operation applied to a vector
  # A function is always followed by ()
  max(pres$Temperature)
  min(pres$Temperature)

  # Functions have "arguments", which are options you can apply to your function
  min(c(2,4,6,NA))
  min(c(2,4,6,NA), na.rm = TRUE)
  
  # To see the arguments for a function, use the "?" operator
  ?max
  
  # There are also data frames already built into R.
  data(iris)
  ?iris
  
  # Packages also sometimes contain their own data as well.
  
# Packages are collections of functions that aren't included in R itself. They must be downloaded and then loaded in order to use them. There are over 20,000 packages available on the Comprehensive R Archive Network, which is where most developers put their packages.
  
  # To install a package, you can use install.packages()
  install.packages("dplyr")
  
  # You only need to install a package one time per project.
  # You will need to load a package each time you start an R session (usually you will only do this when you start the project for the first time, but if you need to restart your R session, you will need to re-load your packages; this is a good reason to keep track of all of your code in a .R file!)
  library(dplyr)
  
  # There is a function in {dplyr} called glimpse() that makes it very easy to quickly look at a data frame and get a sense of what is in there.
  glimpse(pres)

# Try it yourself! --------------------------------------------------------

# First, install the "nycflights13" package
  
# Load the package using library()

# Then, run the following to load the "flights" data frame
data(flights)

# Look at the help file for the data frame you just loaded


# Explore the data frame using glimpse()


# Now we want to find out how many flights were delayed by 30 minutes or more when departing JFK airport. First, create a new data frame with only those rows where the origin airport is "JFK" and where the departure delay is greater than or equal to 30. (Save your result as a new object.)

# Use the nrow() function to get the number of rows in the resulting data frame (flights from JFK with departure delays of at least 30 minutes).

# Create a new column that represents the departure delay in hours rather than minutes (i.e., divide departure delay by 60).

# What is the average departure delay of these flights in hours? Hint: look at the help file for "mean()". How can you ask this function to ignore the flights where the departure delay is NA (because the flight was cancelled)?
    

  
# ifelse for if... else... choices: ifelse(logical operation, value if true, value if false)
  flights$late <- ifelse(flights$arr_delay >= 0, TRUE, FALSE)
  table(flights$late)
  
# A common use of ifelse is to find rows that do or do not have an NA value. For example, if the "arr_delay" field is NA, that means that the flight was cancelled.
  flights$cancelled <- ifelse(is.na(flights$arr_delay), TRUE, FALSE)
  table(flights$cancelled)
  
# Try it yourself! --------------------------------------------------------
  
# Looking only at airports actually located in New York City (JFK and LGA) and flights that were NOT cancelled, create a column that is 1 if the flight left on time or early but arrived late and 0 otherwise. How many flights left on time or early but arrived late?
