# server.R
library(dplyr)
library(ggplot2)

# Obtain the CO2 data name the variable "co2_data"
co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv",
                     stringsAsFactors = FALSE)

View(co2_data)

