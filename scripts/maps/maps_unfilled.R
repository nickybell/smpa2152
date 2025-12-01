# fmt: skip
# File Name: 	  	  maps.R
# File Purpose:  	  Maps in R
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2025-11-30

# Today, we will learn how to make maps in R. There are many tools for mapping in R that range from simple to highly technical. Geographic Information Systems (GIS) is an entire field of study, and many of the packages that have been developed for mapping in R are for professionals in this field. We will learn how to use "wrapper" functions -- which simplify complex processes into a single function -- to create maps of the United States. However, if you are interested in making more complex maps (or non-U.S. maps), there is much more in R that you could learn.

# First, let's learn some basic principles of mapping. The first principle is called projection: https://www.youtube.com/watch?v=UPaca-SrvEk&t=13s

install.packages(c("mapproj", "usmap"))
library(tidyverse)
library(usmap)
library(usmapdata)

state <- map_data("state")

# mercator, mollweide, gilbert, polyconic
ggplot(state) +
  geom_polygon(
    aes(x = long, y = lat, group = group),
    fill = "white",
    color = "black"
  ) +
  coord_map("mercator") +
  theme_minimal()

# The next principle is identification. What do we do when some geographic units share a name? E.g.,
county <- fips_data("county")
county |>
  count(county) |>
  arrange(desc(n)) |>
  head(5)
county |> filter(county == "Washington County")

# FIPS codes are unique identifiers assigned to every state and county (or county-equivalent) in the United States. They are five digit codes; the first two digits are states and the last three digits are counties.

# The codes stay relatively consistent over time, but there are changes that you need to be aware of when working with data over time. For example, in 2022, Connecticut requested that the Census Bureau use nine regions rather than counties for collecting and reporting statistics. The regions have different FIPS codes than the counties. We'll come back to this later.

# The third principle, really a term to know, is a "chloropleth" map. These are maps that use color gradients to display data across different geographies. For example, let's plot the percentage of each state's population that is in poverty in 2021:
data(statepov)

state_fips <- fips_data("state") |>
  mutate(region = str_to_lower(full))

state_w_fips <- left_join(state, state_fips, by = join_by(region))

state_w_pov <- left_join(state_w_fips, statepov, by = join_by(fips))

ggplot(state_w_pov) +
  geom_polygon(
    aes(x = long, y = lat, group = group, fill = pct_pov_2021),
    color = "black"
  ) +
  coord_map("mercator") +
  scale_fill_gradient(low = "#e5f5f9", high = "#2ca25f") +
  labs(
    title = "Poverty Rate in 2021",
    fill = "Poverty Rate",
    caption = "Source: U.S. Census Bureau"
  ) +
  theme_minimal()

# There is one big problem with this map: where are Hawaii and Alaska?

# That is because plotting uses the literal geographic coordinates and maps it to an x-y coordinate graph. Since Alaska and Hawaii are very far from the U.S. mainland, this can make it difficult to include them and maintain a readable scale.

# Enter the {usmap} package. The plot_usmap() function returns a ggplot (meaning we can add our usual ggplot functions to it) *including* Hawaii and Alaska.

# Some important notes:
# 1. The columns of data you want to display (in our case, poverty rate) must include a column called either "fips" or "state" (lowercase, and not both).
# 2. If the map uses states, the "state" variable can be either a state name, abbreviation or FIPS code. For counties, the FIPS must be provided as there can be multiple counties with the same name.

# Real-World Example: Trade Adjustment Assistance and Job Losses

# The Trade Adjustment Assistance (TAA) program provides aid to workers who have lost their jobs as a result of increased imports, outsourcing, or foreign competition. When a TAA petition is filed, the Department of Labor estimates the number of workers affected. We can use these petitions to estimate the number of trade-related job losses in each county in the United States.

# Note: In counties with small numbers of workers or manufacturing workers, these proportions may be less reliable due to small sample sizes.

# Load the trade job losses data
trade_losses <- read_csv("scripts/maps/trade_job_losses.csv")

# Examine the data structure

# Create a FIPS code by combining state and county FIPS
# The plot_usmap() function requires a single "fips" column for county-level maps

# Map 1: Proportion of Manufacturing Workers Lost to Trade

# Map 2: Counties with Major Losses due to Trade
