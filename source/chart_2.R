state_df <- read.csv("https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnytimes%2Fcovid-19-data%2Fmaster%2Fus-states.csv&filename=us-states.csv", header = TRUE, stringsAsFactors = FALSE)

library(stringr)
library(dplyr)
library("ggplot2")

# Scatterplot shows the spikes in data. As time goes by, cases increase but the
# number of deaths are slowly flattening out which means that vaccinations,
# mandates, and other precautions have reduced the death-risk of COVID-19 though
# the cases have continued to increase.
chart_2 <- ggplot(state_df) +
  geom_point(mapping = aes(x = cases, y = deaths)) +
  labs(
    title = "Comparison between Cases and Deaths",
    x = "Cases",
    y = "Deaths"
  )