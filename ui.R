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
      p("Our team's data report will attempt to present data relating to bicycle and pedestrian traffic around Seattle and how that traffic may be affected by various factors such as day of the week, season, and weather."),
      h3("Motivation:"),
      p("Before starting this project, we became fully aware of the difficulties in transportation due 
          to traffic/road congestion in major cities like Seattle, so we wanted to analyze how alternatitive
          forms of transportation including biking and walking are affected by various factors. These include
          days of the week, weather and road conditions, and we can correlate variations in these factors
          with bike and pedestrian traffic volumes. We can then use these trends to predict future trends
          in these alternative forms of transportation in order to potentially introduce new infrastructure 
          to accommodate these forms of transportation."),
      h3("Limitations:"),
      p("Unfortunately, the Washington State Department of Transportation was unable to provide any 
        updated data on car traffic volumes. Using vehicle traffic would have been ideal, as we could 
        use this data to view the correlations between fluctuations in bike/pedestrian traffic with 
        vehicle traffic. There is also a limited number of bike/pedestrian data collection stations available.
        However, the number of locations with data collected are adequate for a reasonable 
        analysis; it is a reasonable sample size. Ideally, the analysis should take into account major
        innovations in alternative transportation such as the introduction of bike sharing programs (
        Ofo, Spin, LimeBike), and the opening of new light rail stations, as these would be expected to
        dramatically affect traffc volumes throughout the city, but unfortunately no data was
        available for those features.")
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

    tabPanel("Graph",
      pre("Graph of traffic vols per street vs date goes here"),
      plotOutput('weekday.traffic.graph'),
      plotOutput('month.traffic.graph'),
      h3("Analysis:"),
      p("")
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
