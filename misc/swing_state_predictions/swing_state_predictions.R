### This script is for the swing states prediction exercise

library(tidyverse)
library(googlesheets4)
bids <- read_sheet("1LXF7GD48oONxRinGpLcEGeK4wvD38JCFvTzmAoY2MQw")

# Weighted predictions
bids |>
  filter(!is.na(Result)) |>
  group_by(State, Result) |>
  summarize(total = sum(Bid)) |>
  arrange(State, desc(Result)) |>
  mutate(prop = round(total/sum(total)*100,0),
         position = lag(total) + total/2,
         position = if_else(is.na(position), total/2, position),
         State = factor(State, levels = group_by(bids, State) |>
                               summarize(total = sum(Bid)) |>
                               arrange(desc(total)) |>
                               pull(State))) |>
  ggplot() +
  geom_col(aes(x = State, y = total, fill = Result)) +
  geom_text(aes(x = State, y = position, label = paste0(prop, "%")), size = 3) +
  scale_fill_manual(values = c("#0671B0", "#CA0120")) +
  labs(y = "Total Bids",
       title = "Swing State Predictions by GW Students",
       caption = "Electoral College total: Harris 276/Trump 262\nlinkedin.com/nicholasbellphd") +
  theme_classic(base_size = 10) +
  theme(plot.title = element_text(hjust = .5),
        axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        plot.background = element_rect(fill = "white"))
ggsave("~/smpa2152/exercises/predictive_models/swing_state_predictions.png", width = 6, height = 4)


# Results -----------------------------------------------------------------

bids |>
  mutate(Bid = ifelse(Result == "Trump", Bid, 0)) |>
  group_by(Student) |>
  summarize(Total = sum(Bid, na.rm = T)) |>
  arrange(desc(Total)) |>
  mutate(Rank = min_rank(desc(Total))) |>
  relocate(Rank, .before = 0) |>
  write_sheet(ss = "1LXF7GD48oONxRinGpLcEGeK4wvD38JCFvTzmAoY2MQw", sheet = "Results")
