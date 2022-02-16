data_1 <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
data_2 <- read.csv("https://api.covidtracking.com/v1/states/current.csv", header = TRUE, stringsAsFactors = FALSE)

data_1_state <- data_1 %>% 
  group_by(State) %>% 
  summarize(
    first_round_total <- sum(X1st.Round.Payment, na.rm = TRUE)
  ) 
