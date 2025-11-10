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

df_pres <- filter(df, candidate == 1 & type == "Pres" & election_year >= 1976)

# Each row represents a "statement" - a piece of what the candidate said in the debate. We want to combine all of the statements in each year into a single "document", since we are going to examine changes in topics over time.

df_pres_year <-
  df_pres |>
  group_by(election_year) |>
  summarize(text = paste(text, collapse = " "))

# Generating text files from a data frame that we can use in Voyant Tools is a bit tricky. It involves using a loop, where we do some operation to each row of the data frame individually, one at a time. This is a more advanced R technique that we won't cover in detail. However, this loop will work anytime you have a column of text that you want to convert into individual text files.

for (row in 1:nrow(df_pres_year)) {
  file_name <- paste(df_pres_year$election_year[row], ".txt", sep = "")
  cat(df_pres_year$text[row], file = file_name)
}

# Now that we have text files for every year, let's move over to Voyant Tools!

# ... #

# Now let's read the data from Voyant Data into R.

voyant <- read_tsv(
  "scripts/text_as_data/debates_topic_models.tsv",
  name_repair = "universal"
)

# Now we can make graphs showing the change in "weight", which is the degree to which a specific document is about that topic

ggplot(voyant, aes(x = Document.Title, y = Topic.1.Weight)) +
  geom_line() +
  geom_point() +
  labs(
    x = "Year",
    y = "Topic Weight",
    title = "Frequency of China Topic in Pres. Debates",
    caption = "Source: debates package\nWords: going, people, said, say, fact, way, it's, china, talking"
  ) +
  theme_classic()

ggplot(voyant, aes(x = Document.Title, y = Topic.3.Weight)) +
  geom_line() +
  geom_point() +
  labs(
    x = "Year",
    y = "Topic Weight",
    title = "Frequency of Military Strength Topic in Pres. Debates",
    caption = "Source: debates package\nWords: president, believe, ive country, world, kind, nation, strong, way, weapons"
  ) +
  theme_classic()
