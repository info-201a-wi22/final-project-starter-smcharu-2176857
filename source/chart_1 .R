df1 <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
df2 <- read.csv("https://api.covidtracking.com/v1/states/current.csv", header = TRUE, stringsAsFactors = FALSE)



library("dplyr")
library("tidyr")
library("ggplot2")

df1$X1st.Round.Payment <- c(df1$X1st.Round.Payment)
df1$X1st.Round.Payment <- gsub("[$,]","",df1$X1st.Round.Payment)
df1$X1st.Round.Payment <- as.numeric(df1$X1st.Round.Payment)

#getting rid of commas and dollar signs in X2nd.Round.Payment

df1$X2nd.Round.Payment <- c(df1$X2nd.Round.Payment)
df1$X2nd.Round.Payment <- gsub("[$,]","",df1$X2nd.Round.Payment)
df1$X2nd.Round.Payment <- as.numeric(df1$X2nd.Round.Payment)
df_chart_1 <- df1 %>% 
  group_by(State) %>% 
  select(-c(Returned..1st.Payment.)) %>%
  summarize(
    first_round_payment = sum(X1st.Round.Payment, na.rm = TRUE),
    second_round_payment = sum(X2nd.Round.Payment, na.rm = TRUE)
  ) %>% 
  mutate(total_payments = first_round_payment + second_round_payment)

## making the chart

chart_1 <- ggplot(data = df_chart_1) + 
  geom_col(mapping = aes(x = State, y = total_payments)) +
  labs(
    title = "Total Number of Funds for Each State", 
    x = "State", 
    y = "Total Funds Given"
  ) +
  options(scipen = 999) 
  

