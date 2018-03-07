# app.R: Sets working directory and initializes shiny application

# Set working directory
setwd("")

# Libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(maps)
library(shiny)
library(rgdal)
library(ggmap)

source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)
