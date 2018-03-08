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
      h3("Analysis:"),
      h5("Burke Gilman Trail (BGT.North.of.NE.70th)"),
      p("This line graph above shows average traffic volume by weekdays and weekends. 
        On the X-axis it contains 'Weekday', on the Y-axis it contains 'Traffic Volume (log10)',
        and the line graph is grouped by 8 street names. As one would expect there are
        less traffic volume on all streets during weekends except for street
        "BGT.North.of.NE.70th".  "BGT.North.of.NE.70th" is a trail known as
        "Burke Gilman Trail" where a lot of people use it to ride bikes, run, and walk
        therefore its average traffic volume is much higher than other streets. 
        Typically work days are Monday through Friday and any time outside of this was 
        used for leisure time and Burke Gilman trail during the weekends indicate that 
        many people spend their leisure time traveling through this trail,
        possibly as recreational purpose."),
      h5("Fremont Bridge Sidewalk"),
      p(""Fremont Bridge Sidewalk" is a bridge that is next to Google Seattle office.
        The graph for "Fremont Bridge is already high even during weekends however there
        is a huge spike starting of Monday and stays high volume till Friday then huge
        decrease from Friday to Saturday. Since Google Seattle office is right next to the 
        "Fremont Bridge" many Google employees and possibly other smaller companies use 
        "Fremont Bridge" to get to their work location. This graph indicates that there are 
        more commuters that likes to spend their leisure hours not going to work without crossing
        the "Fremont Bridge", it is possible they like to travel to a different location or like
        to stay home and rest. Then there is "2nd ave Cycletrack", located in downtown, 
        like "Fremont Bridge" graph except at a lower magnitude because "2nd ave Cycletrack"
        is close to Belltown, a residential area. "),
      h5("Elliot Bay Trail (Elliott.bay.trail.in.myrtle.Edwards.park)"),
      p(""Elliot Bay Trail" has the highest traffic volume because it goes 
        through waterfront in Seattle downtown. This area contains many small 
        businesses and tourist attraction, which brings in any type of traffic 
        all day and year long. The graph holds highest traffic volume constantly
        from Sunday through Saturday, this can be good and bad because due to high 
        traffic businesses which likely brings in consistently high revenues, however
        vice versa it can potentially slow down consumers and workers to get to their specific locations."),
      h5("38th Ave NE Greenway-26th Ave SW Greenway-NW 58th ST Greenway"),
      p(""38th Ave NE Greenway", "26th Ave SW Greenway", and "NW 58th ST Greenway" are 
        relatively low compared to "Fremont Bridge" and "Elliott Bay Trail" because these 
        3 areas are residential areas. People who travel in these streets are mostly 
        people leaving for work, kids "),
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
