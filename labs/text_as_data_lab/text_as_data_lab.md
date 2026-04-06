# Lab \#5 - Text-as-Data
SMPA 2152 (Prof. Bell)

For this assignment, we will use LDA topic modeling of UN General Debate
addresses delivered by Heads of State to observe changes in topic
prevalence over time. Every year, the leaders from most UN member states
deliver an address to the entire body, outlining the issues they
consider most important to international affairs and trying to persuade
other countries to advance their priorities.

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

1.  Using Voyant Tools (`voyant-tools.org`), perform an LDA topic
    modeling analysis of every UN General Debate speech given by the
    **United States**. You are strongly encouraged to make adjustments
    to the LDA parameters (number of terms, number of iterations, and
    number of topics). Provide a screenshot of the topic model results
    (there is an Insert Image option for text cells). In addition,
    report the values you selected for those LDA parameters.

    *Hint: Remember that each iteration of LDA topic modeling is random,
    so if you run the model again, you may not get the same results.*

2.  Export the topic model results from Voyant Tools by copying all of
    the text in the lower text box, going to Gemini (or any LLM), and
    prompting it to “Convert this tsv to csv.” and pasting the values
    from the text box. You can import the resulting data as a `.csv`
    file into Google Colab as you have previously done (using
    `read_csv()`).

    *Hint: The first topic is called “Topic 0” in the resulting `.csv`
    file.*

3.  Generate a graph showing the weight of **one** topic over time.
    Provide a brief written analysis of the results. (You should use a
    meaningful topic name in your visualization and analysis.)

    *Hint: The `dplyr` verb to rename variables is rename({NEW_NAME} =
    {OLD_NAME}). You should also **NOT** use `method = "lm"` in
    `geom_smooth()` since the relationship is not necessarily linear.*

4.  Now, choose **five** countries that all gave speeches in 2025.
    Rename their 2025 text files to the name of the country (e.g.,
    `United States.txt`, `China.txt`, etc.) and perform LDA topic
    modeling on those five speeches. Again, provide a screenshot of the
    topic model results and report the values you selected for the LDA
    parameters.

5.  Export the topic model results from Voyant Tools and generate a
    graph showing the weight of **one** topic across those five
    countries in 2025. Provide a brief written analysis of the results.
    (Again, you should use a meaningful topic name in your visualization
    and analysis.)
