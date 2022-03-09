
##interactive bar chart for the group project
state_df <- read.csv("https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnytimes%2Fcovid-19-data%2Fmaster%2Fus-states.csv&filename=us-states.csv", header = TRUE, stringsAsFactors = FALSE)

library("dplyr")
library("tidyr")
library("ggplot2")
library("usdata")
library("shiny")
# DATA WRANGLING

#Defined a UI
ui <- fluidPage(
  titlePanel("Measurements of COVID-19 per state"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "state",
                  label = "Select A state",
                  choices = state_df$state,
                  selected ="Washington"
                  )
    ),
    mainPanel(plotOutput(outputId = "scatterplot"))
  )
)
