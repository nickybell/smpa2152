# Lab \#2 - Data Wrangling
SMPA 2152 (Prof. Bell)

For this lab, we will practice data wrangling and data visualization
using data on union membership in the United States from
[](https://www.unionstats.com/) by Barry Hirsch (Georgia State
University), David Macpherson (Trinity University), and William Even
(Miami University). The data is provided to you as
`union_membership.csv`.

You will find the following columns in the data:

| variable   | class     | description                            |
|:-----------|:----------|:---------------------------------------|
| state_cens | double    | Census state code used in CPS          |
| state      | character | State name                             |
| state2     | character | State abbreviation                     |
| empl       | double    | Wage and salary employment             |
| member     | double    | Employed workers who are union members |
| year       | double    | Year of the survey                     |

You must submit your lab assignment as a PDF file via Blackboard. In
Google Colab, use the “Print” option under “File”. But first, be sure to
clear any cells and outputs that are not part of your answers to the lab
assignment. Points will be deducted for “messy” submissions.

All graphs must be properly labeled with titles, axis labels, and a
caption. You must use a `theme` function to improve the appearance of
your graphs, but you may choose which theme you prefer.

You may complete the assignments on your own or in collaboration with
other students. This means that you may work together to write code
and/or solve problems. **Do not split up the questions or combine
independent work.**

As a reminder, this course has no restriction on the use of AI tools for
**code**. However, the use of AI tools for **written text** (e.g.,
explanations, analysis, etc.) is not permitted. In addition, a portion
of your lab grade will be based on your application of the materials
covered in the video lecture.

If you work with other students, please indicate their names at the top
of your submission. Each student must submit an assignment on
Blackboard.

------------------------------------------------------------------------

1.  Load the `union_membership.csv` data.

2.  What are the five states with the largest percentage of union
    members in 2024? Provide their names and percentage of union
    members. Why do you think these states have relatively high union
    membership?

3.  Create a nicely-formatted graph that shows the total number of union
    members in millions of workers over time.

4.  Make the same graph, but this time, use the *percentage* of workers
    who are in a union rather than the total number of union members.
    Compare the two graphs you just made. What does this tell you about
    union membership in the United States over time?

5.  What are the five states with the largest percentage point decline
    in the percent of workers who are unionized between 1983 and 2024?
    Provide their names and the percentage point decline. (A percentage
    point change means that you are subtracting one percentage from
    another.)

    *Hint: You will need to use the summary functions `first()` and
    `last()` to answer this question. Check the `dplyr` cheat sheet for
    a clue about where to use these functions.*
