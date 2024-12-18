# Assignment \#2
SMPA 2152 (Prof. Bell)

For this homework, please use the `assignment2_template.R` script.
Please submit your completed `.R` script via Blackboard. In addition,
please submit a Word document or PDF containing the visualizations for
each question *as well as your written response to the prompt*.

You may complete the assignments on your own or in collaboration with
other students. This means that you may work together to write code
and/or solve problems. **Do not split up the questions or combine
independent work.**

If you work with other students, please indicate their names at the top
of your submission. Each student must submit an assignment on
Blackboard.

------------------------------------------------------------------------

Before you begin, you will need to install and load the `{moderndive}`
package (as well as any other packages you will need) and load the
`house_prices` data.

``` r
library(ggplot2)
library(moderndive)
data(house_prices)
```

1.  Do homes with better views command a higher sales price? Please
    report prices in \$1000s, so divide price by 1000. (For `view`, 0 =
    Poor, 1 = Fair, 2 = Average, 3 = Good, and 4 = Very Good.)

``` r
ggplot(data = house_prices) +
    geom_boxplot(aes(x = factor(view), y = price/1000)) +
    labs(x = "Quality of View",
             y = "Price ($1000s)",
             title = "Price of Homes Sold by Quality of View",
             caption = "Source: moderndive package") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = .5))
```

![](assignment2_files/figure-commonmark/unnamed-chunk-2-1.png)

``` outputcode
Homes with better views command higher prices on average, but there are also many homes without good views that sell for higher prices than the homes with the best views. View quality is not the only factor that determines a home price.
```

3.  Design style has changed over the past century. Use a scatterplot
    and best fit lines to show how the number of bathrooms compares to
    the number of bedrooms. Do homes built on or after 1990 tend to have
    more bathrooms per bedroom than homes built before 1990? (Hint:
    Recall the result of a logical operator applied to a vector of
    values. Create a new column that is made up of `TRUE` and `FALSE`
    values.)

``` r
house_prices$after_1990 <- house_prices$yr_built >= 1990

ggplot(data = house_prices, aes(x = bedrooms, y = bathrooms, color = after_1990)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    labs(x = "Bedrooms",
             y = "Bathrooms",
             color = "Built on or after 1990?",
             title = "Bedrooms and Bathrooms Pre- and Post-1990 Construction",
             caption = "Source: moderndive package") +
  theme_minimal() +
    theme(plot.title = element_text(hjust = .5),
          legend.position = "bottom")
```

![](assignment2_files/figure-commonmark/unnamed-chunk-4-1.png)

``` outputcode
Homes built on or after 1990 tend to have more bathrooms per bedroom. The relationship between bedrooms and bathrooms is the same in both time periods, but the average number of bathrooms is higher at all numbers of bedrooms in the post-1990 period.
```

3.  Complete the following code to generate a line graph showing how the
    number of monthly home sales changes over the course of the year (we
    will learn what this code does in a couple of weeks). Modify the
    axes to better fit the data. What is the most popular time of year
    for home sales? Why do you think this might be?

``` r
library(dplyr) # This package is already installed with your other packages
house_prices |>
  mutate(month = format(date, "%m")) |>
  count(month) |>
  ggplot() +
    ...
```

``` r
library(dplyr)
house_prices |>
  mutate(month = as.numeric(format(date, "%m"))) |>
  count(month) |>
  ggplot() +
    geom_line(aes(x = month, y = n)) +
    scale_x_continuous(breaks = 1:12) +
    scale_y_continuous(limits = c(0,NA)) +
    labs(x = "Month",
         y = "Number of Homes Sold",
         title = "Number of Homes Sold Each Month",
         caption = "Source: moderndive package") +
    theme_classic() +
    theme(plot.title = element_text(hjust = .5),
          legend.position = "bottom")
```

![](assignment2_files/figure-commonmark/unnamed-chunk-7-1.png)
