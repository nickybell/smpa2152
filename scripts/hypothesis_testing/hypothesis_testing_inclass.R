library(tidyverse)
library(palmerpenguins)
library(infer)
library(glue)
data(penguins)

# One-tailed, one-sample t-test

# H0: The mean body mass of penguins is less than or equal to 4000g
# HA: The mean body mass of penguins is greater than 4000g

samp_dist <- rep_slice_sample(penguins,
                 n = 20,
                 reps = 1000) |>
  summarize(mean_body_mass = mean(body_mass_g, na.rm = T))

ggplot(samp_dist) +
  geom_histogram(aes(x = mean_body_mass), bins = 10) +
  geom_vline(xintercept = 4000, color = "red", linewidth = 2) +
  labs(title = glue("p-value: {round(mean(samp_dist$mean_body_mass <= 4000), 2)}"))

# Two-tailed, one-sample t-test

# H0: The mean body mass of penguins is not 4000g
# HA: The mean body mass of penguins is 4000g

samp_dist <- rep_slice_sample(penguins,
                              n = 20,
                              reps = 1000) |>
  summarize(mean_body_mass = mean(body_mass_g, na.rm = T))

ggplot(samp_dist) +
  geom_histogram(aes(x = mean_body_mass), bins = 10) +
  geom_vline(xintercept = quantile(samp_dist$mean_body_mass, .025), color = "red", linewidth = 2) +
  geom_vline(xintercept = quantile(samp_dist$mean_body_mass, .975), color = "red", linewidth = 2) +
  labs(title = glue("p-value: {round(mean(samp_dist$mean_body_mass < 4000), 2)*2}"))

# One-tailed, two-sample t-test

# H0: The mean body mass of Adelie penguins is greater than or equal to the mean body mass of Chinstrap penguins
# HA: The mean body mass of Adelie penguins is less than the mean body mass of Chinstrap penguins

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
  geom_histogram(aes(x = diff), bins = 10) +
  geom_vline(xintercept = 0, color = "red", linewidth = 2) +
  labs(title = glue("p-value: {round(mean(samp_dist$diff >= 0), 2)}"))

# Two-tailed, two-sample t-test

# H0: The mean flipper length of Adelie and Chinstrap penguins is equal.
# HA: The mean flipper length of Adelie and Chinstrap penguins is different.

n <- 5
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
  geom_histogram(aes(x = diff), bins = 10) +
  geom_vline(xintercept = quantile(samp_dist$diff, .025), color = "red", linewidth = 2) +
  geom_vline(xintercept = quantile(samp_dist$diff, .975), color = "red", linewidth = 2) +
  labs(title = glue("p-value: {round(mean(samp_dist$diff >= 0), 2)*2}"))
