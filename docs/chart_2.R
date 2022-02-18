#CHART 2: number of hospitalizations for each state Leaflet Map (if we’re allowed to use)
#This data provides the reader with the hospitalizations related to COVID 19 BY EACH MONTH
#This is important because it provides justification for why some states may have received more money then others, hence a state with high allocation funds could have been because they had more patients and hence had more need 

df1 <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
df2 <- read.csv("https://api.covidtracking.com/v1/states/current.csv", header = TRUE, stringsAsFactors = FALSE)
df3 <- read.csv("https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnytimes%2Fcovid-19-data%2Fmaster%2Fus-states.csv&filename=us-states.csv", header = TRUE, stringsAsFactors = FALSE)

library("dplyr")
library("tidyr")
library("leaflet")
library("ggplot2")
library("maps")
library("mapdata")


df1$X1st.Round.Payment <- c(df1$X1st.Round.Payment)
df1$X1st.Round.Payment <- gsub("[$,]","",df1$X1st.Round.Payment)
df1$X1st.Round.Payment <- as.numeric(df1$X1st.Round.Payment)

#getting rid of commas and dollar signs in X2nd.Round.Payment

df1$X2nd.Round.Payment <- c(df1$X2nd.Round.Payment)
df1$X2nd.Round.Payment <- gsub("[$,]","",df1$X2nd.Round.Payment)
df1$X2nd.Round.Payment <- as.numeric(df1$X2nd.Round.Payment)
df_charts <- df1 %>% 
  group_by(State) %>% 
  select(-c(Returned..1st.Payment.)) %>%
  summarize(
    first_round_payment = sum(X1st.Round.Payment, na.rm = TRUE),
    second_round_payment = sum(X2nd.Round.Payment, na.rm = TRUE)) %>% 
  mutate(total_payments = first_round_payment + second_round_payment) %>% 
  rename(state = State)
##combineddatasetforeverything ##askforhowtomakeabettergraph

combined_data <- left_join(df_charts, df2, by = c("state"))

df3$state <- tolower(df3$state)
state_shape <- map_data("state") %>% 
  rename(state = region) %>% 
  left_join(df3, by = "state")

chart_2 <- ggplot(state_shape) +
  geom_polygon(
    mapping = aes (x = long, y = lat, group = group, fill = state, 
                   color = "white", 
                   size = .1)
  )+
  coord_map() + 
  scale_fill_continuous(low = "#132B43", high = "Red") +
  labs(fill = "Death Rate")
  
