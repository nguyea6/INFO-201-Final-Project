# server.R: Calculates and returns output based on input

source("data_processing.R")
source("map_plot_processing.R")

require(shiny)
require(dplyr)

server <- function(input, output) {

  #FilterWeatherTraffic <- function(x.var, x.min, x.max, filtered.weather) {

  filtered.data <- reactive({
    if(input$weather.condition == "All") {
      return(weather.traffic.summary)
    } else {
     weather.traffic.summary %>%
      filter(weather == input$weather.condition) %>%
      return()
    }
  })

  output$seattle.map <- renderPlot({
    seattle.street.map
  })

  output$weekday.traffic.graph <- renderPlot({
    weekday.traffic.plot
  })

  output$month.traffic.graph <- renderPlot({
    month.traffic.plot
  })

  output$quarter.traffic.graph <- renderPlot({
    quarter.traffic.plot
  })

  output$weather.traffic.graph <- renderPlot({
    PlotAvgTrafficByWeather(filtered.data())
  })

}
