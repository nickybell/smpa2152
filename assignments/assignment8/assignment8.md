# Assignment \#8
SMPA 2152 (Prof. Bell)

For this week’s homework, we will use hypothesis tests and regression to
explore Americans’ views of free expression on college campuses. You
will need to download the data for the [Ipsos/Knight Foundation Survey:
Free Expression in America
Post-2020](https://doi.org/10.25940/ROPER-31119146) from Roper iPoll.

``` r
library(tidyverse)
library(infer)
library(sjPlot)
poll <- read_csv("31119146.csv")
```

**BEFORE YOU BEGIN**: Make the following change to your data frame in
your setup chunk before proceeding to any analysis.

``` r
poll <- 
  poll |>
  mutate(Main_Weights = ifelse(!is.na(Students_Weights),
                               Students_Weights,
                               Main_Weights))
```

1.  Conduct a hypothesis test showing whether the proportion of college
    students who believe that colleges and universities should **allow**
    offensive political speech on campus is less than among non-college
    students (`Q11_4`). You must write both the $H_0$ and the $H_A$. How
    do you interpret the results of your hypothesis test? The relevant
    variable for college students is `Student1`. (Hint: Non-college
    students are represented with the values `No` **and** `NA`.)

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
         College = factor(College, levels = c("Not a student", "Student")),
         AllowSpeech = ifelse(Q11_4 == "Allow", 1, 0)) |>
  t_test(AllowSpeech ~ College,
         order = c("Student", "Not a student"),
         alternative = "less") |>
  knitr::kable()
```

| statistic |     t_df |   p_value | alternative |   estimate | lower_ci |   upper_ci |
|----------:|---------:|----------:|:------------|-----------:|---------:|-----------:|
| -2.237391 | 1476.345 | 0.0127048 | less        | -0.0376993 |     -Inf | -0.0099667 |

> The p-value is .013, so we can reject $H_0$ and accept $H_A$, which is
> that non-college students are 3.8 percentage points less likely to
> support allowing offensive political speech on campus, on average.

2.  Using a linear probability model, estimate the difference in
    proportions from \#1 incorporating the survey weights. How does the
    estimated difference change when using survey weights?

``` r
poll2 <- poll |>
  filter(Q11_4 != "Skipped") |>
  mutate(College = ifelse(Student1 == "No" | is.na(Student1), "Not a student", "Student"),
         College = factor(College, levels = c("Not a student", "Student")),
         AllowSpeech = ifelse(Q11_4 == "Allow", 1, 0))

reg <- lm(AllowSpeech ~ College, weight = Main_Weights, data = poll2)
tab_model(reg,
          prefix.labels = "label",
          show.reflvl = TRUE,
          show.ci = FALSE,
          dv.labels = "Allow Offensive Speech on Campus")
```

|  |  |  |
|:--:|:--:|:--:|
|   | Allow Offensive Speech on Campus |  |
| Predictors | Estimates | p |
| (Intercept) | 0.70 | **\<0.001** |
| College: Not a student | *Reference* |  |
| College: Student | -0.07 | **\<0.001** |
| Observations | 5182 |  |
| R<sup>2</sup> / R<sup>2</sup> adjusted | 0.003 / 0.003 |  |

> With weights, college students are 7 percentage points less likely to
> support allowing offensive political speech on campus, on average,
> which is about twice as large the estimate from the t-test.

3.  Include at least two confounders in the regression you conducted for
    \#3. Please explain why you chose to control for those confounders
    (i.e., why do you think that variable is a confounder? Remember that
    confounders must explain change in both the dependent and the
    independent variables.)

    In addition, please describe the effect of being a current college
    student on support for allowing offensive political speech on campus
    given your results.

    Some potential confounders include:

    - Party ID: `QPID100`
    - Gender: `ppgender`
    - Household income: `ppinc7`
    - Race/Ethnicity: `ppethm`

``` r
poll3 <- poll |>
  filter(Q11_4 != "Skipped" & QPID100 != "Skipped") |>
  mutate(College = ifelse(Student1 == "No" | is.na(Student1), "Not a student", "Student"),
         College = factor(College, levels = c("Not a student", "Student")),
         AllowSpeech = ifelse(Q11_4 == "Allow", 1, 0),
         QPID100 = ifelse(QPID100 == "Something else", "Independent", QPID100),
         QPID100 = factor(QPID100, levels = c("Independent", "Democrat", "Republican")))

reg <- lm(AllowSpeech ~ College + QPID100 + ppgender, weight = Main_Weights, data = poll3)
tab_model(reg,
          prefix.labels = "label",
          show.reflvl = TRUE,
          show.ci = FALSE,
          dv.labels = "Allow Offensive Speech on Campus")
```

|  |  |  |
|:--:|:--:|:--:|
|   | Allow Offensive Speech on Campus |  |
| Predictors | Estimates | p |
| (Intercept) | 0.67 | **\<0.001** |
| College: Not a student | *Reference* |  |
| College: Student | -0.06 | **\<0.001** |
| ppgenderMale | 0.09 | **\<0.001** |
| QPID100: Independent | *Reference* |  |
| QPID100: Democrat | -0.11 | **\<0.001** |
| QPID100: Republican | 0.08 | **\<0.001** |
| Observations | 5168 |  |
| R<sup>2</sup> / R<sup>2</sup> adjusted | 0.040 / 0.039 |  |

> College students are about 6 percentage points less likely to support
> allowing offensive political speech on campus, on average, controlling
> for gender and political party.
