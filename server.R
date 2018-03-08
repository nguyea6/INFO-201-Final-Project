# server.R: Calculates and returns output based on input

source("traffic_data_processing.R")
source("map_plot_processing.R")

require(shiny)
require(dplyr)

server <- function(input, output) {

  output$seattle.map <- renderPlot({
    seattle.street.map
  })

  output$weekday.traffic.graph <- renderPlot({
    weekday.traffic.plot
  })

}
