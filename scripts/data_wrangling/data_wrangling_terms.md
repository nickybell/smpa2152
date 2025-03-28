---
output:
  pdf_document: default
  html_document: default
---
### Data Wrangling

---

* **tidyverse**: Collection of packages that make it easier to work with data in R. All of the packages can be loaded at once using `library(tidyverse)`
* `dplyr` verbs:
  * **`filter()`**: Choose which rows in a data frame to keep using logical statements
  * **`mutate()`**: Add or change columns in a data frame
  * **`arrange()`**: Sort data in a data frame
      * **`desc()`**: Typically, `arrange()` sorts in ascending order; use this function to sort in descending order
  * **`select()`**: Choose which columns in a data frame to keep
  * **`summarize()`**: Generate summary statistics; often used with `group_by()`
  * **group_by()**: Use with `summarize()` to generate summary statistics for grouped data (e.g., by political party)
* **`read_csv()`**: Load a `.csv` file
* **`|>`**: The pipe operator, which takes the result of the function on the left hand side (a data frame, typically) and uses it as the data in the function on the right hand side
* **`slice_head(..., n = N)`**: Limits the data frame to only the first *N* rows
* **`kable()`**: From the `{knitr}` package, provides pretty printing of tables in Quarto reports
* Join functions:
  * **`inner_join(x, y)`**: keep only the rows that match in both x and y
  * **`full_join(x, y)`**: keep all the rows in both x and y
  * **`left_join(x, y)`**: keep all the rows in x and the matching rows in y
  * **`right_join(x, y)`**: keep all the rows in y and the matching rows in x
* Pivot functions:
  * **`pivot_longer()`**: Takes data that is spread across columns and converts it into rows, with one column representing the original column names and one column representing the original values in those columns. For example:

  |Election Year|Democrat|Republican|
  |---|---|---|
  |2020|51.3|46.8|
  
    becomes:

  |Election Year|Party|Result|
  |---|---|---|
  |2020|Democrat|51.3|
  |2020|Republican|46.8|
  
  * **`pivot_wider()`**: Takes data that is spread across rows and converts it into columns. For example:
  
  |Election Year|Party|Result|
  |---|---|---|
  |2020|Democrat|51.3|
  |2020|Republican|46.8|
  
    becomes:
    
  |Election Year|Democrat|Republican|
  |---|---|---|
  |2020|51.3|46.8|