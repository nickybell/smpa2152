# File Name: 	  	  regression.R
# File Purpose:  	  Regression
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2024-11-11

# Load packages
library(tidyverse)
library(palmerpenguins)

# Set options
options(tibble.width = Inf, scipen = 999)

# Load data
data(penguins)

#####################################################
## Prove that regression is just the best fit line ##
#####################################################

# What is the relationship between flipper length and body mass?
ggplot(penguins, aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(color = "gray70") +
  geom_smooth(method = "lm", se = F, linetype = "dashed", linewidth = 2) +
  theme_minimal()

reg <- lm(flipper_length_mm ~ body_mass_g, data = penguins)
summary(reg)

ggplot(penguins, aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(color = "gray70") +
  geom_smooth(method = "lm", se = F, linetype = "dashed", linewidth = 2) +
  geom_abline(aes(intercept = reg$coefficients["(Intercept)"],
                  slope = reg$coefficients["body_mass_g"]),
              color = "red",
              linewidth = 1) +
  theme_minimal()

##############################
## Simple Linear Regression ##
##############################

desante <- read_csv("scripts/regression/desante2013_modified.csv")

reg2 <- lm(allocation ~ income_1000s, data = desante)
summary(reg2)

################################
## Multiple Linear Regression ##
################################

reg3 <- lm(allocation ~ race + work_ethic + age + gender + pid + income_1000s, data = desante)
summary(reg3)

# Let's look at the error
desante$prediction <- predict(reg3, desante)
desante$error <- desante$allocation-desante$prediction
desante |>
  select(allocation, prediction, error, race, work_ethic, pid, age, gender, income_1000s) |>
  slice_max(abs(error), n = 10)
