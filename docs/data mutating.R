df1 <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
df2 <- read.csv("https://api.covidtracking.com/v1/states/current.csv", header = TRUE, stringsAsFactors = FALSE)

library("dplyr")
library("tidyr")

#getting rid of commas and dollar signs in X1st.Round.Payment
df1$X1st.Round.Payment <- c(df1$X1st.Round.Payment)
df1$X1st.Round.Payment <- gsub("[$,]","",df1$X1st.Round.Payment)
df1$X1st.Round.Payment <- as.numeric(df1$X1st.Round.Payment)

#getting rid of commas and dollar signs in X2nd.Round.Payment
df1$X2nd.Round.Payment <- c(df1$X2nd.Round.Payment)
df1$X2nd.Round.Payment <- gsub("[$,]","",df1$X2nd.Round.Payment)
df1$X2nd.Round.Payment <- as.numeric(df1$X2nd.Round.Payment)

# Trying to get sum of values, but I can't because of the stupid dollar and spaces
# It should work otherwise? idfk anymore man
df1_state <- df1 %>% 
  group_by(State) %>% 
  select(-c(Returned..1st.Payment.)) %>%
  summarize(
    first_round_total <- sum(X1st.Round.Payment, na.rm = TRUE)
  ) 
