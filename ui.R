# ui.R: Defines user interface

source("data_processing.R")
require(shiny)

ui <- fluidPage(

  titlePanel(
    h1("Visualization of Traffic in Seattle Against Other Variables")
  ),
  h3("Authors: Sherman Chen, Andrew Nguyen, David Yang"),
  tabsetPanel(type = "tabs",
    tabPanel("Introduction",
      h3("Summary:"),
        p("Our team's data report will present data relating to bicycle and pedestrian traffic around Seattle and how that traffic may be affected by various factors such as location, date, and weather."),
      h3("Motivation:"),
        p("Before starting this project, we were fully aware of the difficulties in transportation due to traffic/road congestion in major cities like Seattle, so we wanted to analyze how alternative forms of transportation, including biking and walking, are affected by various factors. These factors include the day of the week, weather conditions, and road conditions. By analyzing traffic numbers against these factors, we can correlate variations in these factors with bike and pedestrian traffic volumes. We can then use these trends to predict future trends in these alternative forms of transportation in order to potentially introduce new infrastructure to better accommodate these forms of transportation."),
      h3("Limitations:"),
        p("Unfortunately, our team was not able to find data about vehicle traffic that was detailed enough for our use case. Using vehicle traffic would have been ideal, as we could use this data to view the correlations between fluctuations in bike/pedestrian traffic with vehicle traffic. There is also a limited number of bike/pedestrian data collection stations available. However, the number of locations with data collected are adequate for a reasonable analysis, as we found that they are placed in key locations. Ideally, the analysis should take into account major innovations in alternative transportation such as the introduction of bike sharing programs (Ofo, Spin, LimeBike), and the opening of new Light Rail stations, as these would be expected to dramatically affect traffc volumes throughout the city, but unfortunately no data could be found for those features.")
    ),

    tabPanel("Traffic vs. Weekday Point Map",
      h3("Description:"),
        p("The map below displays a map of Seattle with the location of traffic measuring stations marked with a colored circle. The size of the circle correlates to the traffic volume at that station: the larger the circle, the more traffic there is. Differences in traffic volume over the week can be seen by changing which day data is being shown for and comparing the size of the circles."),
      sidebarLayout(

        sidebarPanel(
          selectInput("day.of.week", label = "Weekday:", choices = weekday.list)
        ),

        mainPanel(
          plotOutput('seattle.map', width = "100%")
        )
      )
    ),

    tabPanel("Traffic vs. Date Graph",
      h3("Description:"),
        p("The graphs below show average traffic volumes at chosen data collection locations by weekday and month. Since some traffic locations received significantly more traffic than other locations, a logarithmic scale was used so that data points with less traffic could be seen more clearly."),
      plotOutput('weekday.traffic.graph', width = "100%"),
      plotOutput('month.traffic.graph', width = "100%"),
      h3("Analysis:"),
        p('Similar to the volumes for weekday vs weekends, designated pedestrian and bike trails (Burke-Gilman Trail, Elliott Bay Trail, and Fremont Bridge) have a significantly higher traffic volume throughout the year compared to other locations. The main variable considered by the different months is weather and temperature conditions. As seen in all locations on the graph, there is a very strong correlation between months with warmer temperatures/lowered precipitation and traffic volume. On average, the difference between months with lowest traffic volumes were about 50% of months with highest traffic volumes, and this is generally true for all data collection locations.'),
        p(''),
        p('One variation from the normal trend is an influx of pedestrians and cyclists during September and October compared to the summer months. This may be explained by the close proximity of a college to the trail, so volumes would be expected to increase as classes begin, normally in September to October. However, not many fluctuations are present from the overall trend that warmer months correlate to increased traffic volumes in all locations.')
    ),

    tabPanel("Traffic vs. Weather Conditions Graph",
      sidebarLayout(

        sidebarPanel(
          selectInput("weather.condition", label = "Weather Condition", choices = weather.condition.list, selected = default.weather)
        ),

        mainPanel(
          plotOutput('weather.traffic.graph')
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
