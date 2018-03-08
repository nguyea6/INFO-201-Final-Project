# server.R: Calculates and returns output based on input

source("data_processing.R")
source("map_plot_processing.R")

require(shiny)
require(dplyr)

server <- function(input, output) {

  filtered.weekday.traffic.data <- reactive({
    avg.traffic.ped.bicycle.by.weekday %>%
      filter(Weekday == input$day.of.week) %>%
      return()
  })

  filtered.location.weekday.traffic.data <- reactive({
    if(input$location.weekday.select == "All") {
      return(avg.traffic.ped.bicycle.by.weekday)
    } else {
     avg.traffic.ped.bicycle.by.weekday %>%
      filter(location.name == input$location.weekday.select) %>%
      return()
    }
  })

  filtered.location.month.traffic.data <- reactive({
    if(input$location.month.select == "All") {
      return(avg.traffic.ped.bicycle.by.month)
    } else {
     avg.traffic.ped.bicycle.by.month %>%
      filter(location.name == input$location.month.select) %>%
      return()
    }
  })

  filtered.weather.traffic.data <- reactive({
    if(input$weather.condition == "All") {
      return(weather.traffic.summary)
    } else {
     weather.traffic.summary %>%
      filter(weather == input$weather.condition) %>%
      return()
    }
  })

  output$seattle.map <- renderPlot({
    PlotSeattleTraffic(filtered.weekday.traffic.data())
  })

  output$weekday.traffic.graph <- renderPlot({
    PlotAvgTrafficByFactor(filtered.location.weekday.traffic.data(), "Weekday")

  })

  output$month.traffic.graph <- renderPlot({
    PlotAvgTrafficByFactor(filtered.location.month.traffic.data(), "Month")
  })

  output$quarter.traffic.graph <- renderPlot({
    quarter.traffic.plot
  })

  output$weather.traffic.graph <- renderPlot({
    PlotAvgTrafficByWeather(filtered.weather.traffic.data())
  })

}

