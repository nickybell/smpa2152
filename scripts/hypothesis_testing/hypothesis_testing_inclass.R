# File Name: 	  	  hypothesis_testing_inclass.R
# File Purpose:  	  Hypothesis Testing In-class Examples
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)

library(tidyverse)
library(palmerpenguins)
library(infer)
library(glue)
data(penguins)

# One-tailed, one-sample t-test

# H0: The mean body mass of penguins is not greater (less than or equal to) 4000g.
# HA: The mean body mass of penguins is greater than 4000g.

samp_dist <- rep_slice_sample(penguins,
                              n = 20,
                              reps = 1000) |>
  summarize(mean_body_mass = mean(body_mass_g, na.rm = T))

ggplot(samp_dist) +
  geom_histogram(aes(x = mean_body_mass), binwidth = 50) +
  geom_histogram(data = samp_dist[samp_dist$mean_body_mass >= quantile(samp_dist$mean_body_mass, .05),], aes(x = mean_body_mass), binwidth = 50, fill = "coral") +
  geom_vline(xintercept = 4000, linewidth = 1, linetype = "dashed", color = "seagreen3") +
  labs(title = glue("H0: The mean body mass of penguins is less than or equal to 4000g.",
                    "There is a {round(mean(samp_dist$mean_body_mass <= 4000), 2)*100}% chance that H0 is true (p-value: {round(mean(samp_dist$mean_body_mass <= 4000), 2)}).",
                    "Therefore, we can{ifelse(round(mean(samp_dist$mean_body_mass <= 4000), 2) > .05, \"not reject H0.\", \" reject H0 and accept HA.\")}",
                    .sep = "\n"),
       caption = "95% of sampling distribution indicated in orange.") +
  theme_minimal()

# Two-tailed, one-sample t-test

# H0: The mean body mass of penguins is not greater nor less than (is equal to) 4000g.
# HA: The mean body mass of penguins is greater or less than (differnt from) 4000g.

samp_dist <- rep_slice_sample(penguins,
                              n = 50,
                              reps = 1000) |>
  summarize(mean_body_mass = mean(body_mass_g, na.rm = T))

ggplot(samp_dist) +
  geom_histogram(aes(x = mean_body_mass), binwidth = 50) +
  geom_histogram(data = samp_dist[samp_dist$mean_body_mass >= quantile(samp_dist$mean_body_mass, .025) & samp_dist$mean_body_mass <= quantile(samp_dist$mean_body_mass, .975),], aes(x = mean_body_mass), binwidth = 50, fill = "coral") +
  geom_vline(xintercept = 4000, linewidth = 1, linetype = "dashed", color = "seagreen3") +
  labs(title = glue("H0: The mean body mass of penguins is 4000g.",
                    "There is a {round(mean(samp_dist$mean_body_mass <= 4000), 2)*100}% chance that the mean is less than 4000g. (p-value: {round(mean(samp_dist$mean_body_mass <= 4000), 2)}*2 = {round(mean(samp_dist$mean_body_mass <= 4000), 2)*2}).",
                    "Therefore, we can{ifelse(round(mean(samp_dist$mean_body_mass <= 4000), 2)*2 > .05, \"not reject H0.\", \" reject H0 and accept HA.\")}",
                    .sep = "\n"),
       caption = "95% of sampling distribution indicated in orange.") +
  theme_minimal()

# One-tailed, two-sample t-test

# H0: The mean body mass of Adelie penguins is not less than (greater than or equal to) the mean body mass of Chinstrap penguins.
# HA: The mean body mass of Adelie penguins is less than the mean body mass of Chinstrap penguins.

n <- 10
samp_dist <- bind_cols(
  rep_slice_sample(penguins[penguins$species == "Adelie",],
                   n = n,
                   reps = 1000) |>
    summarize(adelie_mean_body_mass = mean(body_mass_g, na.rm = T)),
  rep_slice_sample(penguins[penguins$species == "Chinstrap",],
                   n = n,
                   reps = 1000) |>
    summarize(chinstrap_mean_body_mass = mean(body_mass_g, na.rm = T)) 
) |>
  mutate(diff = adelie_mean_body_mass - chinstrap_mean_body_mass)

ggplot(samp_dist) +
  geom_histogram(aes(x = diff), binwidth = 50) +
  geom_histogram(data = samp_dist[samp_dist$diff >= quantile(samp_dist$diff, .05),], aes(x = diff), binwidth = 50, fill = "coral") +
  geom_vline(xintercept = 0, linewidth = 1, linetype = "dashed", color = "seagreen3") +
  labs(title = glue("H0: The mean body mass of Adelie penguins is greater than or equal to\nthe mean body mass of Chinstrap penguins.",
                    "There is a {round(mean(samp_dist$diff >= 0), 2)*100}% chance that H0 is true (p-value: {round(mean(samp_dist$diff >= 0), 2)}).",
                    "Therefore, we can{ifelse(round(mean(samp_dist$diff >= 0), 2) > .05, \"not reject H0.\", \" reject H0 and accept HA.\")}",
                    .sep = "\n"),
       caption = "95% of sampling distribution indicated in orange.") +
  theme_minimal()

# Two-tailed, two-sample t-test

# H0: The mean flipper lengths of Adelie and Chinstrap penguins are not different.
# HA: The mean flipper lengths of Adelie and Chinstrap penguins are different.

n <- 7
samp_dist <- bind_cols(
  rep_slice_sample(penguins[penguins$species == "Adelie",],
                   n = n,
                   reps = 1000) |>
    summarize(adelie_mean_flipper_length = mean(flipper_length_mm, na.rm = T)),
  rep_slice_sample(penguins[penguins$species == "Chinstrap",],
                   n = n,
                   reps = 1000) |>
    summarize(chinstrap_mean_flipper_length = mean(flipper_length_mm, na.rm = T)) 
) |>
  mutate(diff = adelie_mean_flipper_length - chinstrap_mean_flipper_length)

ggplot(samp_dist) +
  geom_histogram(aes(x = diff), binwidth = 1) +
  geom_histogram(data = samp_dist[samp_dist$diff >= quantile(samp_dist$diff, .025) & samp_dist$diff <= quantile(samp_dist$diff, .975),], aes(x = diff), binwidth = 1, fill = "coral") +
  geom_vline(xintercept = 0, linewidth = 1, linetype = "dashed", color = "seagreen3") +
  labs(title = glue("H0: The mean flipper lengths of Adelie and Chinstrap penguins are equal.",
                    "There is a {round(mean(samp_dist$diff >= 0), 2)*100}% chance that the difference in means is greater than 0. (p-value: {round(mean(samp_dist$diff >= 0), 2)}*2 = {round(mean(samp_dist$diff >= 0), 2)*2}).",
                    "Therefore, we can{ifelse(round(mean(samp_dist$diff >= 0), 2)*2 > .05, \"not reject H0.\", \" reject H0 and accept HA.\")}",
                    .sep = "\n"),
       caption = "95% of sampling distribution indicated in orange.") +
  theme_minimal()
