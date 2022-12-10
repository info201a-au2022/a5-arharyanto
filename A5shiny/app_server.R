# server.R
# Load the necessary libraries

library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(shinythemes)


# Obtain the CO2 data and name the variable "co2_data"
# Load Data

co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv",
                     stringsAsFactors = FALSE)

# Load consumption of CO2 across the country
per_capita_consumption <- co2_data %>% 
  select(country, year, gdp, consumption_co2, consumption_co2_per_capita, consumption_co2_per_gdp)

# What is the average value of consumption of CO2 per capita across all the countries listed?
# ("average capita")
average_capita <- per_capita_consumption %>% 
  filter(year == 2021) %>% 
  summarize(average_consumption_co2_per_capita = mean(consumption_co2_per_capita,
                                                      na.rm = TRUE)) %>% 
  select(average_consumption_co2_per_capita) %>% 
  pull()


# What country has the highest consumption of co2 per capita in 2020?
# ("highest_consumption_co2_2020")

highest_cosumption_co2_2020 <- per_capita_consumption %>% 
  filter(year == 2020) %>% 
  filter(consumption_co2_per_capita == max(consumption_co2_per_capita, na.rm = TRUE)) %>% 
  select(country) %>% 
  pull()

# How much has the average value of consumption of the co2 per capita across all countries changed over the last 20 years?
# ("change_consumption_20_years")
change_consumption_20_years <- per_capita_consumption %>% 
  filter( year %in% (2001:2021)) %>% 
  group_by(year) %>% 
  summarize(avg_consumption_co2_per_capita = mean(consumption_co2_per_capita, na.rm = TRUE)) %>% 
  mutate(change = avg_consumption_co2_per_capita - lag(avg_consumption_co2_per_capita)) %>% 
  select(change) %>% 
  drop_na()

# Interactive Data Visualization

last_65_years_per_capita <- per_capita_consumption %>% 
  filter(year %in% (1956:2021)) %>% 
  drop_na() 

# Add scatterplot to shiny

shinyServer(function(input, output) {
  output$selectCountry <- renderUI({
    selectInput("Country", "Countries Selection", choices = unique(last_65_years_per_capita$country))
  })
  output$selectXVariable  <- renderUI({
    selectizeInput("x", "Select the X variable:", choices = c("GDP", "Year"), selected = "year")
  })
  output$selectYVariable <- renderUI({
    selectizeInput('y', 'Select the Y variable', choices = c("Consumption of co2 per CO₂ capita", "Consumption CO₂ per GDP"), selected = "CO2 Consumption per capita")
  })
  
  scatterplot <- reactive({
    plotCountry <- last_65_years_per_capita %>% 
      filter(country %in% input$Country)
    
    scatter_plot <- ggplot(plotCountry, aes_string(x =input$x, y = input$y)) +
      geom_point() +
      scale_color_grey()
      labs(
        x = input$x,
        y = input$y,
        title = "CO2 Consumption per capita and per GDP through 65 years")
  })
  
  output$co2_scatterplot <- renderPlotly({
    scatterplot()
  })
  output$table1 <- renderTable({
    table1 <- average_capita
  })
  output$table2 <- renderTable({
    table2 <- highest_cosumption_co2_2020
  })
  output$table3 <- renderTable({
    table3 <- change_consumption_20_years
  })
})