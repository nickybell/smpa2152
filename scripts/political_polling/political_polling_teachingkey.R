# File Name: 	  	  political_polling.R
# File Purpose:  	  Political Polling
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)

# Load the tidyverse and set options
library(tidyverse)


# Exit Polls --------------------------------------------------------------

# Today, we will learn how to use weights to help ensure that our survey samples are representative of the population. To demonstrate, we will use data from the 2020 National Election Pool (ABC News, CBS, CNN, NBC) exit poll that you may have seen watching telecasts of the election results. Exit polls are a good example of using weights because it is very difficult to generate a truly random sample of U.S. voters.
# - Exit polls are taken at select precincts across the United States. Are these precincts representative of the state/country as a whole?
# - Exit polls are traditionally conducted by approaching every nth voter leaving the polling place. Are these participants representative of voters as a whole?
# - In 2020, in-person exit polls were combined with telephone interviews due to the ubiquity of early voting and vote-by-mail. Could different survey methods yield different types of selection bias?

# Download the 2020 National Election Pool exit poll results from Roper iPoll and load the data in R: https://doi.org/10.25940/ROPER-31119913
poll <- read_csv("31119913_National2020.csv")


# Survey Weights ----------------------------------------------------------

# Let's begin by doing a little exploratory data analysis on the survey weights used in this poll. What does the distribution of weights look like?
ggplot(poll) +
  geom_histogram(aes(x = weight), binwidth = .2) +
  scale_x_continuous(limits = c(0, 30)) +
  geom_vline(xintercept = 1, color = "red", linetype = "dashed")

ggplot(poll) +
  geom_boxplot(aes(x = sex, y = weight), outliers = FALSE)

ggplot(poll) +
  geom_boxplot(aes(x = age10, y = weight), outliers = FALSE)

ggplot(poll) +
  geom_boxplot(aes(x = qraceai, y = weight), outliers = FALSE)

ggplot(poll) +
  geom_boxplot(aes(x = educcoll, y = weight), outliers = FALSE)

# Presidential vote is not a weighting variable (it is an outcome), but are Trump voters more heavily weighted than Biden voters?
ggplot(poll) +
  geom_boxplot(aes(x = pres, y = weight), outliers = FALSE)

# Using just the tidyverse, we can generate both the unweighted and weighted presidential vote. To make this easier, let's introduce a new function: count().

poll |>
  filter(!is.na(pres)) |>
  group_by(pres) |>
  summarize(n = n())

poll |>
  count(pres)

# The reason to use count() when working with political polls is that it allows you to easily add weights. You can do this with group_by() and summarize(), but it is much more difficult.

poll |>
  count(pres, wt = weight)

# What is we want proportions instead of counts?

poll |>
  count(pres, wt = weight) |>
  mutate(prop = n/sum(n))

# One of the challenges of count() is that it does not leave your data frame "grouped", so be careful when calculating proportions. Imagine we are doing a cross-tab, meaning that we are comparing the cross of two groups: Sex x Presidential Vote.

poll |>
  filter(!is.na(sex) & !is.na(pres)) |>
  count(sex, pres) |>
  mutate(prop = n/sum(n))

# We need to add a group_by() to get the proportions calculated in the right way. (We are keeping all the rows, so we use mutate() instead of summarize() here. One of the few times we do so.)

poll |>
  filter(!is.na(sex) & !is.na(pres)) |>
  count(sex, pres) |>
  group_by(sex) |>
  mutate(prop = n/sum(n))


# Plotting Poll Results ---------------------------------------------------

poll |>
  filter(!is.na(pres) & !is.na(issue20)) |>
  count(issue20, pres, wt = weight) |>
  group_by(issue20) |>
  mutate(prop = n/sum(n)) |>
  ungroup() |> # so that we don't continue to mutate within each group!
  filter(pres == "Joe Biden" & issue20 != "Omit") |>
  ggplot() +
  geom_col(aes(x = reorder(issue20, -prop), y = prop)) +
  scale_y_continuous(limits = c(0,1), labels = scales::percent_format()) +
  labs(x = "Most Important Issue",
       y = "Biden Support (%)",
       title = "Support for Biden in 2020 by Most Important Issue",
       caption = "Source: 2020 National Election Pool exit poll") +
  theme_classic() +
  theme(plot.title = element_text(hjust = .5),
        axis.text.x = element_text(angle = 45, hjust = 1))

# In 2020, many Democrats cast their ballots by mail due to the COVID-19 pandemic, while Republicans typically cast their ballots in person. This resulted in a wide partisan gap between election day ballots (which were counted immediately) and mail ballots. Can we visualize this divide?

poll |>
  filter(!is.na(pres) & !is.na(votemeth)) |>
  count(votemeth, pres, wt = weight) |>
  group_by(votemeth) |>
  mutate(prop = n/sum(n)) |>
  filter(pres %in% c("Joe Biden", "Donald Trump")) |>
  ggplot() +
  geom_col(aes(x = votemeth, y = prop, fill = pres), color = "black", position = "dodge") +
  scale_y_continuous(limits = c(0,1), labels = scales::percent_format()) +
  scale_fill_manual(values = c("#CA0120", "#0671B0")) +
  labs(x = "Vote Method",
       y = "Vote Share (%)",
       fill = "Candidate",
       title = "Vote Choice by Vote Method in 2020 Presidential Election",
       caption = "Source: 2020 National Election Pool exit poll") +
  theme_classic() +
  theme(plot.title = element_text(hjust = .5),
        legend.position = "bottom")

# When we present survey results, we always want to show the margin of error. Let's calculate the margin of error for these results and add it to our graph.

poll |>
  filter(!is.na(pres) & !is.na(votemeth)) |>
  count(votemeth, pres, wt = weight) |>
  group_by(votemeth) |>
  mutate(prop = n/sum(n),
         total = sum(n),
         moe = 1.96 * sqrt((prop * (1 - prop))/total)) |>
  filter(pres %in% c("Joe Biden", "Donald Trump")) |>
  ggplot() +
  geom_col(aes(x = votemeth, y = prop, fill = pres), color = "black", position = "dodge") +
  geom_errorbar(aes(x = votemeth, ymin = prop-moe, ymax = prop+moe, group = pres), position = position_dodge(.9), width = .2) +
  scale_y_continuous(limits = c(0,1), labels = scales::percent_format()) +
  scale_fill_manual(values = c("#CA0120", "#0671B0")) +
  labs(x = "When Voter Decided",
       y = "Vote Share (%)",
       fill = "Candidate",
       title = "Late Deciding Voters Broke for Trump in 2020",
       caption = "Source: 2020 National Election Pool exit poll") +
  theme_classic() +
  theme(plot.title = element_text(hjust = .5),
        legend.position = "bottom")

# A rule of thumb about the error bars: if they do NOT intersect, then the two numbers are statistically significantly different. If they DO intersect, then they *might* or *might not* be significantly different.