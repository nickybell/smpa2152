# File Name: 	  	  sampling.R
# File Purpose:  	  Sampling In-class Exercises
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2025-02-18

# Load packages
library(infer)
library(moderndive)
library(dplyr)
library(ggplot2)

# Load the house_prices data
data(house_prices)
house_prices$price_thousands <- house_prices$price/1000

# What is the average price of homes sold from May 2014 to May 2015?
mean(house_prices$price_thousands)

# What if I sample 50 houses?
mean(sample(house_prices$price_thousands, 50))

# Recall that the *95% confidence interval* means that if we repeat the sample 100 times, 95 of the means will fall within the confidence interval.
# Therefore, we are 95% confident that the true mean falls within those 95 samples. (5% chance of Type 1 error - the true mean is one of the other 5 samples.)
# If we repeat the sample 1000 times, then 950 of the means will fall within the confidence interval. The number of repititions isn't important - it's only theoretical (we don't actually repeat samples to generate confidence intervals).

rep_sample_n(house_prices, size = 50, reps = 1000) |>
  group_by(replicate) |>
  summarize(mean_price_thousands = mean(price_thousands)) |>
  ggplot() +
    geom_histogram(aes(x = mean_price_thousands)) +
    stat_summary(aes(x = mean(mean_price_thousands), y = mean_price_thousands), fun.data = \(x) data.frame(xintercept = quantile(x, c(.025, .975))), geom = "vline", color = "red", linetype = "dashed") +
  stat_summary(aes(x = mean(mean_price_thousands), y = mean_price_thousands), fun.data = \(x) data.frame(xintercept = mean(x)), geom = "vline", color = "blue", size = 1)

# This is known as the sampling distribution. The sampling distribution gets narrower (tighter) as the sample size increases.

bind_rows(
  rep_sample_n(house_prices, size = 50, reps = 1000) |>
    mutate(sample = "50"),
  rep_sample_n(house_prices, size = 100, reps = 1000) |>
    mutate(sample = "100"),
  rep_sample_n(house_prices, size = 500, reps = 1000) |>
    mutate(sample = "500"),
  rep_sample_n(house_prices, size = 1000, reps = 1000) |>
    mutate(sample = "1000")) |>
  group_by(sample, replicate) |>
  summarize(mean_price_thousands = mean(price_thousands)) |>
  mutate(sample = factor(sample, levels = c("50", "100", "500", "1000"))) |>
  ggplot() +
  geom_histogram(aes(x = mean_price_thousands)) +
  stat_summary(aes(x = mean(mean_price_thousands), y = mean_price_thousands), fun.data = \(x) data.frame(xintercept = quantile(x, c(.025, .975))), geom = "vline", color = "red", linetype = "dashed") +
    stat_summary(aes(x = mean(mean_price_thousands), y = mean_price_thousands), fun.data = \(x) data.frame(xintercept = mean(x)), geom = "vline", color = "blue", size = 1) +
  facet_wrap(~ sample, nrow = 1)
