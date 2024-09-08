# File Name: 	  	  introduction_base_r_bellringer.R
# File Purpose:  	  Introduction and Base R Bellringer
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2024-09-08

# Write this vector using seq()
months <- c(1,2,3,4,5,6,7,8,9,10,11,12)
months <- seq(1,12,1)

# Write this vector using rep()
days <- c(31,28,31,30,31,30,31,31,30,31,30,31)
days <- c(31,28, rep(c(31,30), 2), rep(31,2), rep(c(30,31), 2))

# What class (type) is this object? (P.S. This object is always available in R.)
class(month.name)
# character

# Make a data frame containing columns for the months (by number and name) and the number of days in each month. (Hint: Look at how we made the data frame of Presidential inauguration temperatures)
df <- data.frame(month = months, name = month.name, days = days)

# This year is a leap year. Change the number of days for February from 28 to 29 in your data frame.
df[2,3] <- 29