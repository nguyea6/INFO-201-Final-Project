# server.R: Calculates and returns output based on input

source("data_processing.R")
source("map_plot_processing.R")

require(shiny)
require(dplyr)

server <- function(input, output, session) {

  #FilterWeatherTraffic <- function(x.var, x.min, x.max, filtered.weather) {

  filtered.data <- reactive({
    if (input$weather.condition == "All") {
      FilterWeatherTraffic(input$weather.stat, input$min.stat, input$max.stat) %>%
        return()
    } else {
      FilterWeatherTraffic(input$weather.stat, input$min.stat, input$max.stat, input$weather.condition) %>%
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
    PlotAvgTrafficByFactorWithWeather(filtered.data(), input$weather.stat)
  })

  observe({ #https://stackoverflow.com/a/20160256
    updateTextInput(session, 'min.stat',
      value = FindStatRange(filtered.data(), input$weather.stat)[1])
    updateTextInput(session, 'max.stat',
      value = FindStatRange(filtered.data(), input$weather.stat)[2])
  })
}
