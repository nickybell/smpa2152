# File Name: 	  	  regression_inclass.R
# File Purpose:  	  Regression (in class)
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2024-12-02

# Load packages
library(tidyverse)
library(infer) # for the function t_test()

# Set options
options(tibble.width = Inf)

# Today we will be working with data from a poll of Washington, DC residents conducted by Abt Associates on behalf of The Washington Post (https://doi.org/10.25940/ROPER-31119329). You might recall this data from our lecture on hypothesis testing or from Emily Guskin's guest lecture. Let's begin by loading the data:

dc <- read_csv("31119329.csv")

# Let's start by exploring the question, "If you could, would you want to move out of District of Columbia, or not?" The relevant variable is `leavedcfull`. Please note that missing values are denoted with 98 and 99 rather than NA.

# Recall that the most important thing to remember about working with polling data is that hypothesis tests and regression are  tests of means (averages). So if we want to test a proportion (percentage), we want our variable to be in the form of 1s and 0s.



# Do a different proportion of residents in Wards 7 and 8 want to leave DC than residents of other wards? The relevant variable is `wardnew`. Please note that missing values are denoted with 98 and 99 rather than NA.



# Recall that there are a couple of challenges with this analysis:
# 1. We can only compare two groups at one time. There is no controlling for confounders. For example, could income explain both where someone lives in DC and whether they would like to leave DC?
# 2. We cannot weight a t-test if we are using survey data.

# Instead, we can use a type of regression called a linear probability model. It is called this because we are estimating the average percentage change in the dependent variable from a one-unit change in the independent variable. (It is possible to do a regression that has a categorical dependent variable, but these are way beyond the scope of this class.)



# Notice how the coefficient in the regression is the same as the estimated difference in means in the t-test. This is because a simple linear regression is just a best fit line between two variables; the slope is the mean change (difference) between them!

# Now let's adopt our survey weights



# Now we can control for confounders.



# Now let's explain one attitude with another attitude. This is a common type of analysis in journalism, for example, "How do feelings about the economy affect support for the incumbent President?" But these questions are very hard to determine causality. A regression can help you understand correlations, but it is not a substitute for a experiment when the dependent variable does not precede the independent variable. (On the other hand, it is very unlikely that someone wanted to leave DC and then moved to Wards 7 or 8.)

# Are fans of the Washington Football Team's new name (the Commanders) more likely to support public funding for a new football stadium?



# What if we want to change our comparison group? The first level of a factor variable is the "reference level" that is excluded.


# Now let's control for potential confounders.



# Try it yourself! --------------------------------------------------------

# What explains whether DC residents believe that a greater police presence patrolling neighborhoods would reduce violent crime (q21anet)? Consider how they rate the job that DC police are doing, whether they feel safe in their neighborhood, and whether someone in their household has been a victim of violent crime in the past five years. Hint: you'll may to look at the study documentation to find the right variables. https://ropercenter.cornell.edu/ipoll/study/31119329

