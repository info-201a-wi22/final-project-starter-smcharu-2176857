##CHART 3: percentage of states that actually repaid their funds (this will be like percent) Pie Chart, Stacked Bar Plot
##This shows that many hospitals have not paid the money backT##his also shows the impact Covid 19 had economically, as many hospitals did not have the resources to pay back the funds 

df1 <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
df2 <- read.csv("https://api.covidtracking.com/v1/states/current.csv", header = TRUE, stringsAsFactors = FALSE)

library("dplyr")
library("tidyr")
