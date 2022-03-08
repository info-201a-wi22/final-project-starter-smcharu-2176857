library("dplyr")
library("tidyr")
library("ggplot2")
library("shiny")

#sourced both my files
source("practiceui.R")
source("practiceserver.R")

#made the shinyApp
shinyApp(ui = ui, server = server)