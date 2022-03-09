state_df <- read.csv("https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnytimes%2Fcovid-19-data%2Fmaster%2Fus-states.csv&filename=us-states.csv", header = TRUE, stringsAsFactors = FALSE)
hospital_df2 <- read.csv("https://api.covidtracking.com/v1/states/current.csv", header = TRUE, stringsAsFactors = FALSE)
funds_df <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
library("dplyr")
library("tidyr")
library("ggplot2")
library("usdata")
library("shiny")

#DATA WRANGLING: 
#Data wrangled the state data set so that it matches the date of
#the hospital data frame 

#DEFINED A SERVER
server <- function(input, output){ 
  output$scatterplot <- renderPlot({
    final <- state_df %>%
      filter(state == input$state)  
     
   ggplot(data = final) +
      geom_point(mapping = aes(x = cases , y = deaths , color = input$state)) +
     scale_fill_manual(values = "#A846A0") +
      labs(
        title = "Measurements of COVID-19 since March 7, 2021",
        x = "Measurements of COVID-19",
        y = "Total Amount of People", 
        color = "state"
      ) 
  })
}