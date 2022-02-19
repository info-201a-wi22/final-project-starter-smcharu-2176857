library("dplyr")
library("tidyr")
library("stringr")
library("tidyverse")

funding_df <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
hospital_df <- read.csv("https://healthdata.gov/resource/g62h-syeh.csv", header = TRUE, stringsAsFactors = FALSE)
state_df <- read.csv("https://healthdata.gov/resource/g62h-syeh.csv", header = TRUE, stringsAsFactors = FALSE)


#FIXING FUNDING_DF SO U CAN ACTUALLY USE IT

#getting rid of commas and dollar signs in X1st.Round.Payment
funding_df$X1st.Round.Payment <- c(funding_df$X1st.Round.Payment)
funding_df$X1st.Round.Payment <- gsub("[$,]","",funding_df$X1st.Round.Payment)
funding_df$X1st.Round.Payment <- as.numeric(funding_df$X1st.Round.Payment)

#getting rid of commas and dollar signs in X2nd.Round.Payment
#funding_df <- funding_df %>% 
 # select(X2nd.Round.Payment) %>% 
 # gsub("$", "")
#FIXING HOSPITAL_DF SO U CAN ACTUALLY USE IT

funding_onedf <- funding_df ["X2nd.Round.Payment"]

funding_df$X2nd.Round.Payment <- str_replace_all(funding_onedf$X2nd.Round.Payment, "\\$", "")
data.frame(funding_df)

hospital_df$date <- str_sub(hospital_df$date, end = -14) 


diff_var <- funding_df %>% 
  full_join(hospital_df)

#Makes a separate column with just the year
hospital_df <- hospital_df %>% 
  mutate(year = substr(hospital_df$date, start = 1, stop = 4)) %>% 
  select(year, state, inpatient_beds_used_covid)

covid_line <- ggplot(data = hospital_df) + 
  geom_line(mapping = aes(x = state, y = inpatient_beds_used_covid))
