# Assignment \#6
SMPA 2152 (Prof. Bell)

For this week’s homework, we will use hypothesis tests to explore
Americans’ views of free expression on college campuses. You will need
to download the data for the [Ipsos/Knight Foundation Survey: Free
Expression in America
Post-2020](https://doi.org/10.25940/ROPER-31119146) from Roper iPoll.
You will need to dowload the `.csv` file from Roper iPoll and upload it
to your Posit Cloud project.

``` r
library(tidyverse)
library(infer)
poll <- read_csv("31119146.csv")
```

For each question below, you must write both the $H_0$ and the $H_A$.
How do you interpret the results of each hypothesis test?

1.  Conduct a hypothesis test showing whether a majority of Americans
    believe that freedom of speech is “extremely important” to them
    (`Q1_5`).

- $H_0$: The percentage of Americans who believe that freedom of speech
  is “extremely important” to them is less than or equal to 50%.
- $H_A$: The percentage of Americans who believe that freedom of speech
  is “extremely important” to them is greater than 50%.

``` r
poll |>
  filter(Q1_5 != "Skipped") |>
  mutate(free_speech = ifelse(Q1_5 == "Extremely important", 1, 0)) |>
  t_test(response = free_speech,
         mu = .5,
         alternative = "greater") |>
  knitr::kable()
```

| statistic | t_df | p_value | alternative |  estimate |  lower_ci | upper_ci |
|----------:|-----:|--------:|:------------|----------:|----------:|---------:|
|  21.08597 | 5255 |       0 | greater     | 0.6396499 | 0.6287543 |      Inf |

> The p-value is about 0, so we can reject the null hypothesis and
> accept the alternative hypothesis that the percentage of Americans who
> believe that freedom of speech is “extremely important” to them is
> greater than 50%. Americans clearly feel that free speech is an
> important right.

2.  Conduct a hypothesis test showing whether the proportion of college
    students who believe that colleges and universities should **allow**
    offensive political speech on campus is less than among non-college
    students (`Q11_4`).

    Please note that **non**-college students are represented with the
    values `No` *and* `NA` in the variable `Student1`; any other values
    represent college students. You should have 4,276 non-college
    students and 1,023 college students.

- $H_0$: The proportion of college students who believe that colleges
  and universities should allow offensive political speech is greater
  than or equal to the proportion among non-college students.
- $H_A$: The proportion of college students who believe that colleges
  and universities should allow offensive political speech is less than
  the proportion among non-college students.

``` r
poll |>
  filter(Q11_4 != "Skipped") |>
  mutate(College = ifelse(Student1 == "No" | is.na(Student1), "Not a student", "Student"),
         AllowSpeech = ifelse(Q11_4 == "Allow", 1, 0)) |>
  t_test(AllowSpeech ~ College,
         order = c("Student", "Not a student"),
         alternative = "less") |>
  knitr::kable()
```

| statistic |     t_df |   p_value | alternative |   estimate | lower_ci |   upper_ci |
|----------:|---------:|----------:|:------------|-----------:|---------:|-----------:|
| -2.237391 | 1476.345 | 0.0127048 | less        | -0.0376993 |     -Inf | -0.0099667 |

> The p-value is .013, so we can reject the null hypothesis and accept
> the alternative hypothesis that the proportion of college students who
> believe that colleges and universities should allow offensive
> political speech is less than the proportion among non-college
> students. However, the estimate is only -4 percentage points, which is
> not very much, suggesting that views are not sharply divided between
> these two groups.

3.  Now, we will focus only on college students. Conduct a hypothesis
    test showing whether a different proportion of self-identified
    Democratic and Republican (`QPID100`) college students agree that,
    “The climate at my school or on my campus prevents some people from
    saying things they believe because others might find it offensive”
    (`Q16_5`).

- $H_0$: Democratic and Republican college students are equally likely
  to believe that, “The climate at my school or on my campus prevents
  some people from saying things they believe because others might find
  it offensive.”
- $H_A$: Democratic and Republican college students are not equally
  likely to believe that, “The climate at my school or on my campus
  prevents some people from saying things they believe because others
  might find it offensive.”

``` r
poll |>
  mutate(College = ifelse(Student1 == "No" | is.na(Student1), "Not a student", "Student"),
         CampusClimate = ifelse(Q16_5 %in% c("Strongly agree", "Somewhat agree"), 1, 0)) |>
  filter(Q16_5 != "Skipped" & College == "Student") |>
  t_test(CampusClimate ~ QPID100,
         order = c("Democrat", "Republican"),
         alternative = "two-sided") |>
  knitr::kable()
```

> The p-value is .025, so we can reject the null hypothesis and accept
> the alternative hypothesis that Democratic and Republican college
> students are not equally likely to believe that, “The climate at my
> school or on my campus prevents some people from saying things they
> believe because others might find it offensive.”. The estimate is that
> Republicans are 9 percentage points more likely to, perhaps because
> colleges are associated with liberalism in the popular imagination.
