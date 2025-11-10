# fmt: skip file
# File Name: 	  	  text_as_data_unfilled.R
# File Purpose:  	  Pre-lab video lecture on text-as-data
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Last Modified:    2025-11-09

# As we discussed in class, we are going to use an online tool called Voyant Tools to estimate our topic models for our text corpuses. However, we will use R before and after we estimate our topic models to a) wrangle the text data and b) observe changes in topics across cases or over time.

# For today, we will need to download a package called "debates" using specific code.
library(tidyverse)
install.packages("remotes")
library(remotes)
install_github("jamesmartherus/debates")
library(debates)
data(debate_transcripts)
df <- debate_transcripts
glimpse(df)

# Looking at this data set, we will want to filter to only the cases that we are interested: presidential debates where the speaker is a candidate. Let's also limit the data to the modern era (1976 and on).



# Each row represents a "statement" - a piece of what the candidate said in the debate. We want to combine all of the statements in each year into a single "document", since we are going to examine changes in topics over time.



# Generating text files from a data frame that we can use in Voyant Tools is a bit tricky. It involves using a loop, where we do some operation to each row of the data frame individually, one at a time. This is a more advanced R technique that we won't cover in detail. However, this loop will work anytime you have a column of text that you want to convert into individual text files.



# Now that we have text files for every year, let's move over to Voyant Tools!

# ... #

# Now let's read the data from Voyant Data into R.



# Now we can make graphs showing the change in "weight", which is the degree to which a specific document is about that topic



