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
      p("The figure above shows average daily traffic volume at chosen data collection locations by month. Similar to the volumes for weekday vs weekends, designated pedestrian and bike trails ("Broad way cycle track", "Elliott bay trail", and "Fremont bridge") have a significantly higher traffic volume throughout the year compared to other locations. The main variable considered by the different months is weather and temperature conditions. As seen in all locations on the graph, there is a very strong correlation between months with warmer temperatures/lowered precipitation and traffic volume. On average, the difference between months with lowest traffic volumes were about 50% of months with highest traffic volumes, and this is generally true for all data collection locations. One erratic variation from the normal trend is an influx of pedestrians and cyclists during September and October compared to the summer months. This may be explained by the close proximity of a college to the trail, so volumes would be expected to increase as classes begin, normally in September to October. However, not many fluctuations are present from the overall trend that warmer months correlate to increased traffic volumes in all locations.")
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
