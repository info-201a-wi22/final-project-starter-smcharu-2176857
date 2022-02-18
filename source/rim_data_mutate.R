funding_df <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
hospital_df <- read.csv("https://healthdata.gov/resource/g62h-syeh.csv", header = TRUE, stringsAsFactors = FALSE)
state_df <- read.csv("https://healthdata.gov/resource/g62h-syeh.csv", header = TRUE, stringsAsFactors = FALSE)

library("dplyr")
library("tidyr")

#FIXING FUNDING_DF SO U CAN ACTUALLY USE IT

#getting rid of commas and dollar signs in X1st.Round.Payment
df1$X1st.Round.Payment <- c(df1$X1st.Round.Payment)
df1$X1st.Round.Payment <- gsub("[$,]","",df1$X1st.Round.Payment)
df1$X1st.Round.Payment <- as.numeric(df1$X1st.Round.Payment)

#getting rid of commas and dollar signs in X2nd.Round.Payment

df1$X2nd.Round.Payment <- c(df1$X2nd.Round.Payment)
df1$X2nd.Round.Payment <- gsub("[$,]","",df1$X2nd.Round.Payment)
df1$X2nd.Round.Payment <- as.numeric(df1$X2nd.Round.Payment)

#FIXING HOSPITAL_DF SO U CAN ACTUALLY USE IT

hospital_df$date <- str_sub(hospital_df$date, end = -14) 

#Makes a separate column with just the year
hospital_df <- hospital_df %>% 
  mutate(year = substr(hospital_df$date, start = 1, stop = 4)) %>% 
  select(year, state, inpatient_beds_used_covid)

