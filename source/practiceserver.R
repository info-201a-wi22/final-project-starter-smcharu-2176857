state_df <- read.csv("https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnytimes%2Fcovid-19-data%2Fmaster%2Fus-states.csv&filename=us-states.csv", header = TRUE, stringsAsFactors = FALSE)
hospital_df <- read.csv("https://api.covidtracking.com/v1/states/current.csv", header = TRUE, stringsAsFactors = FALSE)
funds_df <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
library("dplyr")
library("tidyr")
library("ggplot2")
library("usdata")
library("shiny")

# DATA WRANGLING
# Getting rid of commas and dollar signs in X1st.Round.Payment
funds_df$X1st.Round.Payment <- c(funds_df$X1st.Round.Payment)
funds_df$X1st.Round.Payment <- gsub("[$,]", "", funds_df$X1st.Round.Payment)
funds_df$X1st.Round.Payment <- as.numeric(funds_df$X1st.Round.Payment)

# Getting rid of commas and dollar signs in X2nd.Round.Payment
funds_df$X2nd.Round.Payment <- c(funds_df$X2nd.Round.Payment)
funds_df$X2nd.Round.Payment <- gsub("[$,]", "", funds_df$X2nd.Round.Payment)
funds_df$X2nd.Round.Payment <- as.numeric(funds_df$X2nd.Round.Payment)

# Data Frame with total sum of payment for each state
funds_data <- funds_df %>%
  group_by(State) %>%
  select(-c(Returned..1st.Payment.)) %>%
  summarize(
    first_round_payment = sum(X1st.Round.Payment, na.rm = TRUE),
    second_round_payment = sum(X2nd.Round.Payment, na.rm = TRUE)
  ) %>% 
  mutate(total_payment = first_round_payment + second_round_payment) %>% 
  rename(state = State)
#Combining funds data and hospital data
combined_data <- left_join(funds_data, hospital_df, by = c("state")) 
#DATA WRANGLING: 
#Changing the combined data frame to show full state name:
combined_data <- combined_data %>% 
  mutate(state = abbr2state(state)) %>% 
  select(state, hospitalizedCumulative)
#Data wrangled the state dataset so that it matches the date 
state_data <- state_df %>% 
  filter(date == "2021-03-07") %>% 
  select(state, deaths, date)
#Joining the data frame containing deaths and cases with the hospital data frame
final_data <- left_join(combined_data, state_data, by = c("state")) %>% 
  select(state, hospitalizedCumulative, deaths) %>% 
  rename(hospitalized = hospitalizedCumulative) %>% 
  na.omit()
#Made the final data frame for the chart showing all interest variables
final <- final_data %>%
  gather(type, amount, -state) %>% 
  na.omit()
#DEFINED A SERVER
server <- function(input, output){ 
  output$barchart <- renderPlot({
    final <- final_data %>%
      filter(state == input$state) %>% 
      gather(type, amount, -state) 
   ggplot(data = final) +
      geom_col(mapping = aes(x = type , y = amount , fill = input$state)) +
     scale_fill_manual(values = "#A846A0") +
      labs(
        title = "Measurements of COVID-19 since March 7, 2020",
        x = "Measurements of COVID-19",
        y = "Total Amount of People", 
        fill = "state"
      ) 
  })
}