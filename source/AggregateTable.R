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

covid_patients_compare <- hospital_df %>% 
  filter(year == 2020) %>% 
  group_by(state) %>% 
  summarize(proportion_2020 = inpatient_beds_used_covid/sum(inpatient_beds_used_covid, na.rm = TRUE) * 100) 
  
  

