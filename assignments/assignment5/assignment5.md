# Problem Set \#5
SMPA 2152 (Prof. Bell)

For this week’s homework, we will work with survey data from the Chicago
Council on Global Affairs, which is widely considered to be the
gold-standard measure of Americans’ attitudes towards foreign policy.
You will need to download the 2022 survey data from Roper iPoll using
this link: <https://doi.org/10.25940/ROPER-31120078>

------------------------------------------------------------------------

1.  Some of the variables used to generate the survey weights are:

> - Gender (`ppgender`)
> - Age (`ppagect4`)
> - Race (`ppethm`)
> - Census Region (`ppreg4`)
> - Urban/Rural (`xurbanicity`)
> - Education (`ppeducat`)
> - Income (`ppinc7`)

On your own, conduct an exploratory data analysis to determine which
groups the survey had difficulty reaching. Do not include this
exploratory analysis in your Quarto report.

In your Quarto report, present **one** graph that shows the distribution
of weights for one of the variables – one that includes a group(s) that
was difficult for the survey to reach. Provide a possible explanation
for why this group(s) was hard to reach.

2.  Show the **unweighted** responses (in percentages) to the question:
    “Do you see the decline of democracy around the world as a critical
    threat, an important but not critical threat, or not an important
    threat at all to the vital interest of the United States in the next
    10 years?” (variable `Q5_NEW_38`). Be sure to include the margin of
    error on the graph.

    Visually, can you conclude that the percentage of respondents who
    believe that this is a critical threat is statisically different
    from the percentage who believe this is an important but not
    critical threat?

3.  Make the same graph, but this time, calculate the percentages with
    weights (`weight`). Visually, can you conclude that the percentage
    of respondents who believe that this is a critical threat is
    different from the percentage who believe this is an important but
    not critical threat?

4.  Create a graph that shows a cross-tab of the weighting variable that
    you identified in question 1 with the question on the decline of
    democracy around the world (that you used in questions 2 and 3).
    What can you conclude about why weighting is important in this case?

    *Hint: do not weight the percentages! We do not weight weighting
    variables (this is circular reasoning).*
