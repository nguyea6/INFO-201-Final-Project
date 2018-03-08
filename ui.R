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
      pre("Before starting this project, we became fully aware of the difficulties in transportation due 
          to traffic/road congestion in major cities like Seattle, so we wanted to analyze how alternatitive
          forms of transportation including biking and walking are affected by various factors. These include
          days of the week, weather and road conditions, and we can correlate variations in these factors
          with bike and pedestrian traffic volumes. We can then use these trends to predict future trends
          in these alternative forms of transportation in order to potentially introduce new infrastructure 
          to accommodate these forms of transportation."),
      h3("Limitations:"),
      pre("Limitations in")
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
