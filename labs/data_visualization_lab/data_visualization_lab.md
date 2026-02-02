# Lab \#1 - Data Visualization
SMPA 2152 (Prof. Bell)

For this lab, we will practice creating data visulization in R using the
`ggplot2` package with data on SAT and GPA scores from 1000 students.
This data was collected in the 1990s from various universties.

All graphs must be properly labeled with titles, axis labels, and a
caption. You must use a `theme` function to improve the appearance of
your graphs, but you may choose which theme you prefer.

You must submit your lab assignment as a PDF file via Blackboard. In
Google Colab, use the “Print” option under “File”. But first, be sure to
clear any cells and outputs that are not part of your answers to the lab
assignment. Points will be deducted for “messy” submissions.

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

1.  Install the `openintro` package, as well as the `tidyverse`. Load
    the `tidyverse` and `openintro` packages, and then load the `satgpa`
    data using the `data()` function.

2.  Using CRAN or the `openintro` package website, identify the
    theoretical maximum value of the `sat_sum` column. Using the `max()`
    function, what is the actual maximum value in the data? What does
    this tell you about the students in this dataset? Do you think this
    data is representative of all the students who took the SAT?

    *Hint: In R, we can use `$` to indicate that we want to use a column
    inside of a particular dataframe, e.g., `data$col`, replacing `data`
    with the name of the object containing your data, and `col` with the
    name of the column in the data. Remember, R is case sensitive.*

3.  Let’s learn a little more about how students performed on the two
    sections of the SAT: the verbal (reading comprehension) section and
    the math section. Generate two graphs, each showing the count of
    students by score for one of the sections. How do these two
    distributions compare?

4.  The data contains a column called `sex` where `"1" == "Male"` and
    `"2" == "Female"`. Generate one graph comparing the distributions of
    `sat_sum` for the two sexes. Be sure to change the labels on the
    axis to use words rather than numbers for the sexes. What do you
    notice about the two distributions?

    *Hint: You should use the `factor()` function around the `sex`
    variable inside the `aes()` function. Why do you think this is?*

5.  Is a student’s SAT score or their high school GPA a better predictor
    of their first year college GPA? Use two graphs, each comparing one
    of these measures with first year college GPA, to answer this
    question.

    *Hint: Each graph will have at least two `geom` layers.*
