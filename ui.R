# ui.R: Defines user interface

source("data_processing.R")

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
      h3("Inspiration:"),
      pre("Inspiration goes here"),
      h3("Limitations:"),
      pre("Limitations go here.")
    ),
    
    tabPanel("Map",
      pre("Map goes here")
    ),
    
    tabPanel("Analysis",
      pre("Analysis goes here")
    )
  )
)
