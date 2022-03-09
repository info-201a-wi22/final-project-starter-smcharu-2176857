#Loading packages
library(shiny)
library(ggplot2)
library(dplyr)
library(stringr)
library(tidyr)
library(plotly)
library(maps)
library(usdata)
library(usmap)

funds_df <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
hospital_df <- read.csv("https://healthdata.gov/resource/g62h-syeh.csv", header = TRUE, stringsAsFactors = FALSE)
state_df <- read.csv("https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnytimes%2Fcovid-19-data%2Fmaster%2Fus-states.csv&filename=us-states.csv", header = TRUE, stringsAsFactors = FALSE)
hospital_df2 <- read.csv("https://api.covidtracking.com/v1/states/current.csv", header = TRUE, stringsAsFactors = FALSE) 


  
# MAP

#DATA WRANGLING
# Getting rid of commas and dollar signs in X1st.Round.Payment
funds_df$X1st.Round.Payment <- c(funds_df$X1st.Round.Payment)
funds_df$X1st.Round.Payment <- gsub("[$,]", "", funds_df$X1st.Round.Payment)
funds_df$X1st.Round.Payment <- as.numeric(funds_df$X1st.Round.Payment)

# Getting rid of commas and dollar signs in X2nd.Round.Payment
funds_df$X2nd.Round.Payment <- c(funds_df$X2nd.Round.Payment)
funds_df$X2nd.Round.Payment <- gsub("[$,]", "", funds_df$X2nd.Round.Payment)
funds_df$X2nd.Round.Payment <- as.numeric(funds_df$X2nd.Round.Payment)

# Data Wrangling to make data sets usable
hospital_df$date <- str_sub(hospital_df$date, end = -14)
hospital_df <- hospital_df %>%
  mutate(year = substr(hospital_df$date, start = 1, stop = 4)) 
# Data Frame with total fund for each state
state_total_funding <- funds_df %>%
  group_by(State) %>%
  summarize(total_funds = sum(X2nd.Round.Payment, na.rm = TRUE))

state_total_funding$State <- abbr2state(state_total_funding$State)

# Data frame with total patients in each state
state_total_patient<- hospital_df %>% 
  group_by(state) %>% 
  summarize(state_total_patients = sum(inpatient_beds_used_covid, na.rm = TRUE))

state_total_patient$state <- abbr2state(state_total_patient$state)

# Renaming column to join data sets by State
state_total_funding <- state_total_funding %>%
  rename(state = State)

# Combining Data frames
patient_funding_comparison <-
  left_join(state_total_funding, state_total_patient, by = c("state"))

##########################################################################

# Scatter Plot
#Data Wrangling
#state_data <- state_df %>%
  #filter(date == "2021-03-07") %>% 
  #select(state, deaths)  

#hospital <- hospital_df2 %>% 
  #mutate(state = abbr2state(state)) %>% 
  #select(state, hospitalizedCumulative)

#Combined the data set:
#final_data <- left_join(hospital, state_data, by = c("state")) %>% 
  #rename(hospitalized = hospitalizedCumulative) %>% 
 # na.omit()

#Made the final dataset
#final <- final_data %>%
  #gather(type, amount, -state) %>% 
  #na.omit()

#Made a variable for UI select options for the scatterplot
choice_states <- unique(state_df$state)


#####################################################################
server <- function(input, output) {
  # Map!!
  output$map <- renderPlotly({
     plot_usmap(data = patient_funding_comparison, values = input$value, 
                color = "red") + 
      scale_fill_continuous(name = "Value", label = scales::comma) + 
      theme(legend.position = "right")
  })
  
  
  # Scatter Plot !!
  output$scatterplot <- renderPlotly({
    final <- state_df %>%
      filter(state == input$state) 
    
    ggplot(data = final) +
      geom_point(mapping = aes(x = cases , y = deaths , color = input$state), 
                 size = 1.5) +
      labs(
        title = "Cases vs Deaths per State",
        x = "Cases",
        y = "Deaths", 
        color = "state"
      ) 
  })
}
