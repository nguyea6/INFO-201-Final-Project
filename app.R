# app.R: Sets working directory and initializes shiny application

# Set working directory
setwd("C:/Users/david/Desktop/Info 201/INFO-201-Final-Project")

# Libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(maps)
library(shiny)
library(rgdal)
library(ggmap)
library(scales)

source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)
