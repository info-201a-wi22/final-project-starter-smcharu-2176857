funds_df <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
hospital_df <- read.csv("https://healthdata.gov/resource/g62h-syeh.csv", header = TRUE, stringsAsFactors = FALSE)

#DATA WRANGLING
# Getting rid of commas and dollar signs in X1st.Round.Payment
funds_df$X1st.Round.Payment <- c(funds_df$X1st.Round.Payment)
funds_df$X1st.Round.Payment <- gsub("[$,]","",funds_df$X1st.Round.Payment)
funds_df$X1st.Round.Payment <- as.numeric(funds_df$X1st.Round.Payment)

# Getting rid of commas and dollar signs in X2nd.Round.Payment

funds_df$X2nd.Round.Payment <- c(funds_df$X2nd.Round.Payment)
funds_df$X2nd.Round.Payment <- gsub("[$,]","",funds_df$X2nd.Round.Payment)
funds_df$X2nd.Round.Payment <- as.numeric(funds_df$X2nd.Round.Payment)

library(stringr)
library(dplyr)

#
#
#
#

# Table with each state, total amount of funding they got, and the percentage 
# of the total that it is
state_total_funding <- funds_df %>% 
  group_by(State) %>% 
  summarize(total_funds = sum(X2nd.Round.Payment, na.rm = TRUE)) %>% 
  mutate(us_total = sum(total_funds)) %>% 
  mutate(
    percentage_of_funds = paste(round((total_funds / us_total) * 100, 2), "%")
    ) %>% 
  select(-c(us_total))
  

#Data Wrangling to make data sets usable
hospital_df$date <- str_sub(hospital_df$date, end = -14) 
hospital_df <- hospital_df %>% 
  mutate(year = substr(hospital_df$date, start = 1, stop = 4)) %>% 
  select(year, state, inpatient_beds_used_covid)

# Table with each state, total amount of funding they got, and the pecentage
# of the total that it is
total_patient_comparison <- hospital_df %>% 
  group_by(state) %>% 
  summarize(state_total_patients = sum(inpatient_beds_used_covid, na.rm = TRUE)) %>% 
  mutate(us_total_patients = sum(state_total_patients)) %>% 
  mutate(
    percentage_of_patients = 
      paste(round((state_total_patients / us_total_patients) * 100, 2), "%")
  ) %>% 
  select(-c(us_total_patients))

# Renaming column to join data sets by State
total_patient_comparison <- total_patient_comparison %>% 
  rename(State = state)

# Joining datasets together 
patient_funding_comparison <- 
  left_join(state_total_funding, total_patient_comparison, by = c("State"))

