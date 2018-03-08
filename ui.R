# ui.R: Defines user interface

source("data_processing.R")

require(shiny)

ui <- fluidPage(

  titlePanel(
    h1("Visualization of Traffic in Seattle Against Other Variables")
  ),

  h2("Authors:"),
  h3("Sherman Chen, Andrew Nguyen, David Yang"),
  tabsetPanel(type = "tabs",
    tabPanel("Introduction",
      h3("Summary:"),
      p("Our team's data report will attempt to present data relating to bicycle and pedestrian traffic around Seattle and how that traffic may be affected by various factors such as day of the week, season, and weather."),
      h3("Motivation:"),
      pre("Motivation goes here"),
      h3("Limitations:"),
      pre("Limitations go here.")
    ),

    tabPanel("Map",
      pre("Heat map goes here"),
      plotOutput('seattle.map'),
      sliderInput("animation", "Looping Animation:",
        min = 1, max = 2000,
        value = 1, step = 100,
        animate =
          animationOptions(interval = 300, loop = TRUE)
      )
    ),

    tabPanel("Traffic Over Time Graph",
      pre("Graph of traffic vols per street vs date goes here"),
      plotOutput('weekday.traffic.graph', width = "100%"),
      plotOutput('month.traffic.graph'),
      #plotOutput('quarter.traffic.graph'),
      h3("Analysis:"),
      p("")
    ),

    tabPanel("Traffic Compared to Weather Graph",
      pre("traffic vs weather graph with filters goes here"),
      sidebarLayout(
        sidebarPanel(
          selectInput("weather.stat", label = "Weather Statistic", choices = weather.stat.list, selected = default.stat),
          textInput("min.stat", label = "Minimum", value = stat.range[1]),
          textInput("max.stat", label = "Maximum", value = stat.range[2]),
          selectInput("weather.condition", label = "Weather Condition", choices = weather.condition.list, selected = default.weather)
        ),
        mainPanel(
          #plotOutput('weather.traffic.graph')
        )
      )
    ),

    tabPanel("Citations", #https://shiny.rstudio.com/articles/tag-glossary.html
      #ggmaps
      tags$blockquote("D. Kahle and H. Wickham. ggmap: Spatial Visualization with ggplot2.
        The R Journal, 5(1), 144-161. URL
        http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf",
        cite = "D. Kahle and H. Wickham")
    )
  )
)
