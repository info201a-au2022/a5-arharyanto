# ui.R
library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(shinythemes)

# Tab Panel for Introduction
intro_panel <- tabPanel(
  "Introduction",
  titlePanel(strong("CO2 Consumption")),
  mainPanel(
    h3(strong("Abstract")),
    p("The main purpose of this project is to see the consumption of CO₂ throughout over the past 65 years. Every year the consumption of CO₂ increases, and I am going to research on which country consumes the most CO₂. My main question before starting this research is ‘What actions can we do to reduce this consumption of CO₂?” By doing this research, I hope that it could benefit people who are concern with climate change and what kinds of actions they are doing to reduce these consumptions. It also raises major health issues, hopefully at the end of my research the countries who consumes many CO₂ could be more aware."
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
    h3("Measures of Consumption of CO₂:"),
    p("What is the average value of consumption of CO₂ per capita across all the countries listed?"),
    p(em(4.694)),
    br(),
    p("What country has the highest consumption of CO₂ per capita in 2020?"),
    p(em("Qatar")),
    br(),
    p("How much has the average value of consumption of the CO₂ per capita across all countries changed over the last 20 years?"),
    
    
  
  )
)

# Tab Panel for Page 2
Visualization <- tabPanel(
  "Interactive Scatterplot",
  titlePanel("Scatterplot of Consumption of CO₂"),
  sidebarLayout(
    sidebarPanel(
      uiOutput("selectCountry"),
      uiOutput("selectXVariable"),
      uiOutput("selectYVariable")
    ),
    mainPanel(
      h3("CO₂ Scatterplot"),
      plotlyOutput("co2_scatterplot"),
      h4(strong("Overview")),
      p("This table shows how much CO₂ every country is consuming. Take the U.S. the consumption slowly decreases overtime. This could be a good sign because inhaling CO₂ can cause major health issues.")
      
    ),
    
  ),
  sidebarLayout(
    position = "left",
    sidebarPanel(
      h4(strong("Acknowlegdements")),
      p("I am grateful for this opportunity to research with this dataset. Special thanks to my TA, Yubing Tian for always helping me solve my code. I hope this is helpful to all."
        ),
      
    ),
    mainPanel()
  )
)

ui <- navbarPage(
  "CO2 Consumption",
  intro_panel,
  Visualization
)

shinyUI(fluidPage(
  theme = shinytheme("cyborg"),
  ui
))
