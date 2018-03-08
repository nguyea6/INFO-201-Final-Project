# app.R: Sets working directory and initializes shiny application

# Set working directory
setwd("/home/andrew/Documents/School/INFO 201/Assignments/INFO-201-Final-Project")

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
