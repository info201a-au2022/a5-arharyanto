# ui.R
library(shiny)
library(plotly)
library(dplyr)
library(shinythemes)
library(ggplot2)

# Tab Panel for Introduction
intro_panel <- tabPanel(
  "Introduction",
  titlePanel(strong("CO2 Consumption")),
  mainPanel(
    h3(strong("Variables")),
    h4(strong("consumption_co2_per_capita")),
    p("Annual consumption-based emissions of carbon dioxide (CO₂), measured in tonnes per person. Consumption-based emissions are national or regional emissions which have been adjusted for trade (i.e. territorial/production emissions minus emissions embedded in exports, plus emissions embedded in imports). If a country's consumption-based emissions are higher than its production emissions it is a net importer of carbon dioxide. Consumption-based CO₂ emissions have been converted by Our World in Data from tonnes of carbon to tonnes of CO₂ using a conversion factor of 3.664.")
  )
  
)

# Tab Panel for Page 2
Visualization <- tabPanel(
  "Interactive Scatterplot",
  titlePanel("Scatterplot"),
  sidebarLayout(
    sidebarPanel(
      uiOutput("selectCountry"),
      uiOutput("selectXVariable"),
      uiOutput("selectYVariable")
    ),
    mainPanel(
      
    )
  )
)

ui <- navbarPage(
  "CO2 Consumption",
  intro_panel,
  Visualization
  )

shinyUI(fluidPage(
  theme = shinytheme("darkly"),
  ui
))
