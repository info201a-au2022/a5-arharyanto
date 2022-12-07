# Load libraries so they are available
library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(shinythemes)

# Use source() to execute the `app_ui.R` and `app_server.R` files. These will
# define the UI value and server function respectively.

source("app_server.R")
source("app_ui.R")

# You will need to fill in the `app_ui.R` file to create the layout.
# Run the app through this file.

# Create a new `shinyApp()` using the loaded `ui` and `server` variables
shinyApp(ui = ui, server = server)