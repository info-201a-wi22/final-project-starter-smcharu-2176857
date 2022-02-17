##CHART 3: percentage of states that actually repaid their funds (this will be like percent) Pie Chart, Stacked Bar Plot
##This shows that many hospitals have not paid the money backT##his also shows the impact Covid 19 had economically, as many hospitals did not have the resources to pay back the funds 

df1 <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
df2 <- read.csv("https://api.covidtracking.com/v1/states/current.csv", header = TRUE, stringsAsFactors = FALSE)

library("dplyr")
library("tidyr")


df1$X1st.Round.Payment <- c(df1$X1st.Round.Payment)
df1$X1st.Round.Payment <- gsub("[$,]","",df1$X1st.Round.Payment)
df1$X1st.Round.Payment <- as.numeric(df1$X1st.Round.Payment)

#getting rid of commas and dollar signs in X2nd.Round.Payment

df1$X2nd.Round.Payment <- c(df1$X2nd.Round.Payment)
df1$X2nd.Round.Payment <- gsub("[$,]","",df1$X2nd.Round.Payment)
df1$X2nd.Round.Payment <- as.numeric(df1$X2nd.Round.Payment)
df_tester <- df1 %>% 
  group_by(State) %>% 
  select(-c(Returned..1st.Payment.)) %>%
  summarize(
    first_round_payment = sum(X1st.Round.Payment, na.rm = TRUE),
    second_round_payment = sum(X2nd.Round.Payment, na.rm = TRUE), 
    payment_returned = filter(Returned..1st.Payment. == "") %>% 
      nrow(payment_returned)) %>% 
  mutate(total_payments = first_round_payment + second_round_payment) %>% 
  rename(state = State)
##combined dataset for everything
combined_data <- left_join(df_charts, df2, by = c("state"))

##making the chart 3

chart_3 <- ggplot(data = combined_data) +
  geom_bar(mapping = aes(x ="", y =   , fill = group)) +
  coord_polar()



