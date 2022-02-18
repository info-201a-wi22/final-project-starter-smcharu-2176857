funds_df <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
hospital_df <- read.csv("https://healthdata.gov/resource/g62h-syeh.csv", header = TRUE, stringsAsFactors = FALSE)
View(hospital_df)

library(stringr)
library(dplyr)

hospital_df$date <- str_sub(hospital_df$date, end = -14) 
hospital_df <- hospital_df %>% 
  mutate(year = substr(hospital_df$date, start = 1, stop = 4)) %>% 
  select(year, state, inpatient_beds_used_covid)

test <- hospital_df$year

patients_2020 <- hospital_df %>% 
  group_by(state) %>% 
  summarize(state_total = n()) %>% 
  mutate(percentage = round(state_total / sum(state_total), 2))
  
  

percentage_of_patients <-
  filter(year == 2020) %>% 

patients_2021 <- hospital_df %>% 
  filter(year == 2021) %>% 
  group_by(state) %>% 
  summarize(
    total_covid_patients_2021 = sum(inpatient_beds_used_covid)
  ) 

covid_patients_compare <- left_join(patients_2020, patients_2021,  by = c("state"))

test <- hospital_df %>% 
  filter(state == "FL")

View(hospital_df)

