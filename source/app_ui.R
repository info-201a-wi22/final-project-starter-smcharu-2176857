library(shiny)
library(ggplot2)
library(plotly)
state_df <- read.csv("https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnytimes%2Fcovid-19-data%2Fmaster%2Fus-states.csv&filename=us-states.csv", header = TRUE, stringsAsFactors = FALSE)

# Define Page One

# Define Page Two
page_two <- 
  tabPanel(
    "Map",
    fluidPage(
h1("Hospitalization Funds and Hospitlaizations in the United States"),
p("This is a map of the United States that shows the amount of funds given to
  hospitals in each state through the Bipartisan CARES Act Paycheck 
  Protection Program and Health Enhancement Act and it also shows the number
  of hospitlizations per state. Based on the scale, you can see that the lighter 
  the blue is, the more hospital funds and hospitlization numbers the state 
  has gotten. Grayed out states are ones that do not have any accumulated data.
  One of our main research questions was surrounding the allocation
  of these funds and if they were done in an effective manner. When clicking 
  between the Funds and Patients option you can see that for a few states 
  there is not much of a differnce and this would mean that the funds were
  allocated in an effective manner. For example, California and Texas are 
  both light blue for both options which means that there was a meaningful 
  and effective allocation of funds. On the other hand, the amount of funds 
  that were allocated to New York is not proportional to the number of patients
  that they had. New York got almost 800 million dollars given to their 
  hosptials but only had around 40,000 patients hospitlized compared to other
  states that had more patients but got less funds. Another example is Illinois
  that got more than 800 million dollars in funds but had around 40,000 
  hospitlized patients."),
sidebarLayout(
  sidebarPanel(
    radioButtons(
      inputId = "value",
      label = h3("Type of Value"),
      choices = list("Funds (in Dollars)" = "total_funds", 
                     "Hospitilized Patients" = "state_total_patients"),
      selected = "total_funds"
    )
  ),
  mainPanel(
    plotlyOutput("map")
  )
)
    )
  )

# Define Page Three
page_three <-
  tabPanel(
    "Scatter Plot",
    fluidPage(
      titlePanel("Measurements of COVID-19 per state"),
      sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "state",
                      label = "Select A state",
                      choices = choice_states,
                      selected = "Washington"
          )
        ),
        mainPanel(plotlyOutput(outputId = "scatterplot"))
      )
    )
  )

# Define ui
ui <- (
  fluidPage(
    navbarPage(
      "Final Project",
      page_two, 
      page_three
    )
  )
)
