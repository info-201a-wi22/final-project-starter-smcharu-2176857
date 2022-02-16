df1 <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
df2 <- read.csv("https://api.covidtracking.com/v1/states/current.csv", header = TRUE, stringsAsFactors = FALSE)

# Trying to get rid of dollar sign and spaces in X1st.Round.Payment bc you cant
# add up the values with the dollar sign and spaces. When I run it, nothing 
# changes in df1 file?
df1$X1st.Round.Payment <- gsub("$   ","",as.character(df1$X1st.Round.Payment))

#Example from internet for what I did above
df1$x1<-gsub("1","",as.character(df1$x1))

# Trying to get sum of values, but I can't because of the stupid dollar and spaces
# It should work otherwise? idfk anymore man
df1_state <- df_1 %>% 
  group_by(State) %>% 
  select(-c(Returned..1st.Payment.)) %>%
  summarize(
    first_round_total <- sum(X1st.Round.Payment, na.rm = TRUE)
  ) 
