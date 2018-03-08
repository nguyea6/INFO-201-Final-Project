# ui.R: Defines user interface

source("traffic_data_processing.R")

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
      p("Our team's data report will attempt to present data relating to traffic around Seattle and how that traffic may be affected by various factors such as day of the week, season, and weather."),
      h3("Motivation:"),
      pre("Motivation goes here"),
      h3("Limitations:"),
      pre("Limitations go here.")
    ),

    tabPanel("Map",
      pre("Heat map goes here"),
      plotOutput('seattle.map')
    ),

    tabPanel("Graph",
      pre("Graph of traffic vols per street vs date goes here"),
      plotOutput('weekday.traffic.graph')
    ),

    tabPanel("Analysis",
      pre("Analysis goes here")
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
