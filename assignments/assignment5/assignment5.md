# Assignment \#5
SMPA 2152 (Prof. Bell)

For this week’s homework, we are going to explore how well the polls did
in predicting the results of the 2020 Presidential Election. We will be
using two datasets:

- Data on 2020 election polls collected by
  [FiveThirtyEight](https://abcnews.go.com/538). This data is available
  on Blackboard as `presidential_polls_2020.csv`.

- Results of the 2020 Presidential election compiled by the [MIT
  Election Data + Science Lab](https://electionlab.mit.edu/). This data
  is available on Blackboard as `2020-president.csv`.

------------------------------------------------------------------------

``` r
library(tidyverse)
polls <- read_csv("presidential_polls_2020.csv")
```

1.  Make a nicely-formatted graph showing the average support for Joe
    Biden and Donald Trump in each month over the course of the race.

    1.  Use the column `end_date` to represent the date of the poll.
    2.  Use only polls that are national polls (i.e., are not state
        polls).
    3.  Use only pollsters with a rating from 538 of 2.0 or higher.

``` r
polls |>
  filter(answer %in% c("Biden", "Trump") & numeric_grade >= 2 & !is.na(state)) |>
  mutate(end_date = mdy(end_date),
         month = month(end_date),
         year = year(end_date)) |>
  group_by(answer, month, year) |>
  summarize(pct = mean(pct, na.rm = T)) |>
  mutate(date = make_date(year, month)) |>
  ggplot(aes(x = date, y = pct, color = answer)) +
  geom_point() +
  geom_line() +
  scale_x_date(date_breaks = "2 months", date_labels = "%b %y") +
  scale_y_continuous(limits = c(0,100)) +
  scale_color_manual(values = c("#0671B0", "#CA0120")) +
  labs(x = "Month",
       y = "Polling Average (%)",
       color = "Candidate",
       title = "2024 Presidential Election National Polling",
       caption = "Source: 538 and MIT Election Data + Science Lab.") +
  theme_classic() +
  theme(plot.title = element_text(hjust = .5))
```

![](assignment5_files/figure-commonmark/unnamed-chunk-2-1.png)

2.  Some people believe that polls with live interviews produce more
    accurate results than other types of polls. Create the same graph as
    above, but this time, include a comparison between polls that use at
    least some `"Live Phone"` interviews and those that do not. Do you
    believe that Live Phone polls produce different polling results than
    non-Live Phone polls?

``` r
polls |>
  filter(answer %in% c("Biden", "Trump") & numeric_grade >= 2 & !is.na(state)) |>
  mutate(end_date = mdy(end_date),
         month = month(end_date),
         year = year(end_date),
         live = str_detect(methodology, "Live Phone")) |>
  group_by(live, answer, month, year) |>
  summarize(pct = mean(pct, na.rm = T)) |>
  mutate(date = make_date(year, month)) |>
  ggplot(aes(x = date, y = pct, color = answer)) +
  geom_point() +
  geom_line() +
  scale_x_date(date_breaks = "2 months", date_labels = "%b %y") +
  scale_y_continuous(limits = c(0,100)) +
  scale_color_manual(values = c("#0671B0", "#CA0120")) +
  labs(x = "Month",
       y = "Polling Average (%)",
       color = "Candidate",
       title = "2024 Presidential Election National Polling",
       caption = "Source: 538 and MIT Election Data + Science Lab.") +
  theme_classic(base_size = 8) +
  theme(plot.title = element_text(hjust = .5)) +
  facet_wrap(~ live)
```

![](assignment5_files/figure-commonmark/unnamed-chunk-3-1.png)

> Polls with live phone interviews were better at capturing late
> movement towards Trump than non-live phone interview polls.

3.  Estimate the polling error in each state by comparing the average
    two-party vote share for Biden in each state according to the
    polling vs. the actual two-party vote share for Biden in the
    election results. The two party vote share is:

    $BidenPct/(BidenPct + TrumpPct)$

    Use only polls where:

    1.  The `end_date` is on or after October 15, 2020.
    2.  The pollster has a rating from 538 of 2.0 or higher.

Make a nicely-formatted graph showing the polling error in each state
arranged from largest to smallest polling error. Comment on the graph.
What does this graph tell you about state polling in the 2020 election?

*Hint: You may need to use pivot_wider() to answer this question.*

``` r
elec <- read_csv("2020-president.csv")
elec <- elec |>
  filter(candidate_name == "Biden") |>
  mutate(two_party_vote = two_party_vote*100)

polls |>
  mutate(date = mdy(end_date)) |>
  filter(answer %in% c("Biden", "Trump") &
           numeric_grade >= 2 &
           date >= mdy("10-15-2020") &
           !is.na(state)) |>
  pivot_wider(names_from = answer, values_from = pct) |>
  mutate(BidenShare = Biden/(Biden+Trump)*100,
         state = str_to_upper(state)) |>
  group_by(state) |>
  summarize(BidenTwoParty = mean(BidenShare, na.rm = T)) |>
  inner_join(elec) |>
  mutate(difference = BidenTwoParty - two_party_vote,
         state = str_to_title(state),
         state = fct(state),
         state = fct_reorder(state, difference)) |>
  ggplot() +
  geom_col(aes(y = state, x = difference)) +
  labs(x = "Polling Error (%)",
       y = "State",
       title = "Polling Error in the 2024 Presidential Election",
       caption = "Source: 538 and MIT Election Data + Science Lab.") +
  theme_classic(base_size = 8) +
  theme(plot.title = element_text(hjust = .5))
```

![](assignment5_files/figure-commonmark/unnamed-chunk-5-1.png)

> Some of the largest polling errors were in states that are not
> competitive, meaning that there probably was not much polling in those
> states. However, most states have a polling error which overestimates
> Biden’s vote share, suggesting a general pattern in 2020 election
> polling to overestimate Biden.
