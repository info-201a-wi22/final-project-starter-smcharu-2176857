df3 <- read.csv("https://healthdata.gov/resource/g62h-syeh.csv", header = TRUE,stringsAsFactors = FALSE)
df4 <- read.csv("https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnytimes%2Fcovid-19-data%2Fmaster%2Fus-states.csv&filename=us-states.csv", header = TRUE, stringsAsFactors = FALSE)
library(stringr)
library(dplyr)
library("ggplot2")
df
df3 = df3$date

df3 <- df3 %>% 
  mutate(year = substr(df3$date, start = 1, stop = 4))
View(df3)

data_chart_3 <- df3 %>% 
  group_by(state) %>% 
  top_n(5, wt = inpatient_beds_used_covid) %>% 
  select(date, state, inpatient_beds_used, inpatient_beds_used_covid)
  
chart_3 <- ggplot(data = data_chart_3)+ 
  geom_point(mapping = aes(x = state, y = patient_sum)) +
  geom_smooth(mapping = aes(x = state, y = patient_sum)) +
  labs(
    title = "Number of patients in the hosptial by State",
    x = "State",
    y = "Number of patients in Hospital"
  )

# Scatterplot (use this one if nothing else works for chart 3)
# Scatterplot shows the spikes in data. As time goes by, cases increase but the 
# number of deaths are slowly flattening out which means that vaccinations, 
# mandates, and other precautions have reduced the death-risk of COVID-19 though
# the cases have continued to increase. 
chart_3_a <- ggplot(df4) +
  geom_point(mapping = aes(x = cases, y = deaths)) +
  labs(
    title = "Comparison between Cases and Deaths"
  )
  
