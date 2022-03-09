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
        mainPanel(plotlyOutput(outputId = "scatterplot"), 
        p("This scatterplot shows the number of cases versus deaths for 
        each state.Here looking at this data it can be seen that for each 
        state as cases are 
        still increasing continuously near the 
        end of the graph its evident that the plot flattens out 
        for each state near the end. This shows that less people 
        are dying, giving insight into the trajectory of COVID-19 in our 
        nation. Although cases are still prevalent the amount of deaths are 
        decreasing.Answering the question
        on how COVID-19 has progressed over time.
        This scatterplot shows us how COVID-19 has impacted each 
        state, being able to put a number to the exact amount of cases and 
        deaths shows impac, as it can be seen California had one of the
        highest numbers of cases. This chart can also be used in comparison with
        additonal data such as the map. This comparison can reveal if states with
        a high number of cases also have the highest number of hospitalizations. " 

))
      )
    )
  )

page_four <- 
  tabPanel(
    "Summary",
    fluidPage( titlePanel("What to Take Away"),
      p("As can be seen, the main takeaways from the project are the analysis 
      regarding which states had the most funding, which states had the most 
      patients, and which state had the least funding. First, it is evident 
      that California, Texas, and Florida had the most patients hospitalized 
      with the number of people hospitalized being around 80,000. This is a 
      big number compared to the rest of the U.S. mostly had around 40-50,000
      people hospitalized per state. However, it is important to mention the 
      fact that Illinois was the state who had the most funding. Even though 
      they had 41,630 patients they received about 200,000,00 million dollars
      more than California. This helps us understand the allocation of funds
      better, as seen from the example above it is not based solely on the 
      number of patients being treated per state, if that were the case 
      California, Texas, and Florida would have the most funding. One has 
      to consider population size in this case, as the population size of 
      Illinois is much smaller than that of California. Hence, even though
      California had more patients when comparing it to their total population 
      of about 40 million people it isn't as dramatic as 41,000 people in a
      hospital with Illionos’s population size of 12 million. Another key
      takeaway to mention is that the number of cases will not always 
      translate to the number of hospitalizations. Showing that although 
      the number of cases shows the impact of COVID-19 for each state, it 
      is not sufficient to allocate funding primarily based on the number 
      of cases. This is because not all cases are considered fatal and in
      need of hospitalizations. This is evident in the fact that although
      California had the most cases but the state with the most amount of 
      patients was Florida. Providing insight on the fact that maybe the cases 
      in Florida were more severe than those in California resulting in more 
      hospitalizations.")
     
    )
  )

# Define ui
ui <- (
  fluidPage(
    navbarPage(
      "Final Project",
      page_two, 
      page_three, 
      page_four
    )
  )
)
