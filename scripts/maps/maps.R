# File Name: 	  	  maps_teachingkey.R
# File Purpose:  	  Maps in R
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2024-11-04

# Today, we will learn how to make maps in R. There are many tools for mapping in R that range from simple to highly technical. Geographic Information Systems (GIS) is an entire field of study, and many of the packages that have been developed for mapping in R are for professionals in this field. We will learn how to use "wrapper" functions -- which simplify complex processes into a single function -- to create maps of the United States. However, if you are interested in making more complex maps (or non-U.S. maps), there is much more in R that you could learn.

# First, let's learn some basic principles of mapping. The first principle is called projection: https://www.youtube.com/watch?v=UPaca-SrvEk&t=13s

install.packages(c("mapproj", "usmap"))
library(tidyverse)
library(usmap)
library(usmapdata)

state <- map_data("state")

# mercator, mollweide, gilbert, polyconic
ggplot(state) +
  geom_polygon(aes(x = long, y = lat, group = group), fill = "white", color = "black") +
  coord_map("mercator") +
  theme_void()

# The next principle is identification. What do we do when some geographic units share a name? E.g.,


# FIPS codes are unique identifiers assigned to every state and county (or county-equivalent) in the United States. They are five digit codes; the first two digits are states and the last three digits are counties.

# The codes stay relatively consistent over time, but there are changes that you need to be aware of when working with data over time. For example, in 2022, Connecticut requested that the Census Bureau use nine regions rather than counties for collecting and reporting statistics. The regions have different FIPS codes than the counties. We'll come back to this a bit later.

# The third principle, really a term to know, if a "chloropleth" map. These are maps that use color gradients to display data across different geographies. For example, let's plot the percentage of each state's population that is in poverty in 2021:


# There is one big problem with this map: where are Hawaii and Alaska?

# That is because plotting uses the literal geographic coordinates and maps it to an x-y coordinate graph. Since Alaska and Hawaii are very far from the U.S. mainland, this can make it difficult to include them and maintain a readable scale.

# Enter the {usmap} package. The plot_usmap() function returns a ggplot (meaning we can add our usual ggplot functions to it) *including* Hawaii and Alaska.

# Some important notes:
# 1. The columns of data you want to display (in our case, poverty rate) must include EITHER "fips" or "state"
# 2. If the map uses states, the "state" variable can be either a state name, abbreviation or FIPS code. For counties, the FIPS must be provided as there can be multiple counties with the same name.



# Let's do this with a relevant example: showing county-level two-party vote shifts from Clinton to Biden in the 2020 presidential election. I've already provided you with the county-level results data.
pres <- read_csv("countypres.csv")

# To answer this question, we need to:
# 1. Filter the data to just 2016 and 2020 and the Democratic and Republican candidates
# 2. Calculate the two-party vote share for the Democrat in each election in each county
# 3. Calculate the difference in two-party vote share between 2016 and 2020
# 4. Make a map!


