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
    h3(strong("Abstract")),
    p("The main purpose of this project is to see the consumption of CO2 throughout over the past 65 years. Every year the consumption of CO2 increases, and I am going to research on which country consumes the most CO2. My main question before starting this research is ‘What actions can we do to reduce this consumption of CO2?” By doing this research, I hope that it could benefit people who are concern with climate change and what kinds of actions they are doing to reduce these consumptions. It also raises major health issues, hopefully at the end of my research the countries who consumes many CO2 could be more aware."
      ),
    br(),
    h3(strong("Variables Used:")),
    p("Consumption_CO2:",
      br(),
      "Annual consumption-based emissions of carbon dioxide (CO₂), measured in million tonnes. Consumption-based emissions are national or regional emissions which have been adjusted for trade (i.e. territorial/production emissions minus emissions embedded in exports, plus emissions embedded in imports). If a country's consumption-based emissions are higher than its production emissions it is a net importer of carbon dioxide. Data has been converted by Our World in Data from million tonnes of carbon to million tonnes of CO₂ using a conversion factor of 3.664."
      ),
    p("Consumption_CO2_Per_Capita:",
      br(),
      "Annual consumption-based emissions of carbon dioxide (CO₂), measured in tonnes per person. Consumption-based emissions are national or regional emissions which have been adjusted for trade (i.e. territorial/production emissions minus emissions embedded in exports, plus emissions embedded in imports). If a country's consumption-based emissions are higher than its production emissions it is a net importer of carbon dioxide. Consumption-based CO₂ emissions have been converted by Our World in Data from tonnes of carbon to tonnes of CO₂ using a conversion factor of 3.664."
      ),
    p("Consumption_CO2_Per_GDP:",
      br(),
      "Annual consumption-based emissions of carbon dioxide (CO₂), measured in kilograms per dollar of GDP (2011 international-$). Consumption-based emissions are national or regional emissions which have been adjusted for trade (i.e. territorial/production emissions minus emissions embedded in exports, plus emissions embedded in imports). If a country's consumption-based emissions are higher than its production emissions it is a net importer of carbon dioxide. Consumption-based CO₂ emissions have been converted by Our World in Data from tonnes of carbon to tonnes of CO₂ using a conversion factor of 3.664."
      ),
    tags$figure(
      align = "center",
      tags$img(
        src = "intro_page.png",
        width = 650,
        alt = "Climate Change"
      ),
      tags$figcaption("Climate Change")
    ),
  
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
