# server.R
# Load the necessary library
library(tidyverse)
library(dplyr)
library(ggplot2)
library(shiny)
library(plotly)

# Obtain the CO2 data name the variable "co2_data"
# Load Data 

co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv",
                     stringsAsFactors = FALSE)



# Consumption CO2 across the country 

per_capita_consumption <- co2_data %>% 
  select(country, year, gdp, consumption_co2, consumption_co2_per_capita, consumption_co2_per_gdp)


# What is the average value of consumption CO2 per capita across all the countries in 2021?
# ("average_capita") 

average_capita <- per_capita_consumption %>% 
  filter(year == 2021) %>% 
  summarize(average_consumption_co2_per_capita = mean(consumption_co2_per_capita, na.rm = TRUE)) %>% 
  select(average_consumption_co2_per_capita)

# What country is the consumption CO2 per capita the highest in 2021?
# ("highest_consumption_co2_2021")

highest_cosumption_co2_2021 <- per_capita_consumption %>% 
  filter(year == 2021) %>% 
  filter(consumption_co2_per_capita == max(consumption_co2_per_capita, na.rm = TRUE)) %>% 
  select(country)

# How much has the average value of consumption of CO2 per capita across all of the countries changed over the past 20 years?
# ("change_over_20_years")

change_over_20_years <- per_capita_consumption %>% 
  filter( year %in% (2001:2021)) %>% 
  group_by(year) %>% 
  summarize(avg_consumption_co2_per_capita = mean(consumption_co2_per_capita, na.rm = TRUE)) %>% 
  mutate(change = avg_consumption_co2_per_capita - lag(avg_consumption_co2_per_capita)) %>% 
  select(change) %>% 
  drop_na()

# To add the scatterplot to shiny

server <- function(input, output, session) {
  output$selectCountry <- renderUI({
    selectInput("Country", "Choose Country", choices = unique(change_over_20_years$country))
  })
  output$selectXVar <- renderUI({
    selectizeInput("x", "Select the X Variable", choices = c("gdp", "year"), selected = "year")
  })
  output$selectYVar <- renderUI({
    selectizeInput("y", "Select the Y Variable", choices = c("consumption_co2_per_capita", "consumption_co2_per_gdp"), selected = "CO2 Consumptions per capita")
  })
  scatterplot <- reactive({
    plotCountry <- change_over_20_years %>% 
      filter(country %in% input$Country)
  })
  scatter_plot <- ggplot(plotCountry,
                         aes_string(x = input$x,
                                    y = input$y)) +
    geom_point() +
    labs(
      x = input$x,
      y = input$y,
      title = "Consumption of CO2 per capita and per GDP in the Last 20 Years.")
}

output$co2scatterplot <- renderPlotly({
  scatterplot()

output$table_1 <- renderTable({
  table_1 <- average_capita
})
output$table_2 <- renderTable({
  table_2 <- highest_cosumption_co2_2021
})
output$table_3 <- renderTable({
  table_3 <- change_over_20_years
  })
})

