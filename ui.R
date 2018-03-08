# ui.R: Defines user interface

source("data_processing.R")
require(shiny)

ui <- fluidPage(

  titlePanel(
    h1("Visualization of Pedestrian and Bicycle Traffic in Seattle Against Other Variables")
  ),
  h3("Authors: Sherman Chen, Andrew Nguyen, David Yang"),
  tabsetPanel(type = "tabs",
    tabPanel("Introduction",
      h3("Summary:"),
        p("Our team's data report will present data relating to bicycle and pedestrian traffic around Seattle and how that traffic may be affected by various factors such as location, date, and weather."),
      h3("Motivation:"),
        p("Before starting this project, we were fully aware of the difficulties in transportation due to traffic/road congestion in major cities like Seattle, so we wanted to analyze how alternative forms of transportation, including biking and walking, are affected by various factors. These factors include the day of the week, weather conditions, and road conditions. By analyzing traffic numbers against these factors, we can correlate variations in these factors with bike and pedestrian traffic volumes. We can then use these trends to predict future trends in these alternative forms of transportation in order to potentially introduce new infrastructure to better accommodate these forms of transportation."),
      h3("Limitations:"),
        p("Unfortunately, our team was not able to find data about vehicle traffic that was detailed enough for our use case. Using vehicle traffic would have been ideal, as we could use this data to view the correlations between fluctuations in bike/pedestrian traffic with vehicle traffic. There is also a limited number of bike/pedestrian data collection stations available. However, the number of locations with data collected are adequate for a reasonable analysis, as we found that they are placed in key locations. Ideally, the analysis should take into account major innovations in alternative transportation such as the introduction of bike sharing programs (Ofo, Spin, LimeBike), and the opening of new Light Rail stations, as these would be expected to dramatically affect traffc volumes throughout the city, but unfortunately no data could be found for those features."),
      h3(tags$a(href="https://github.com/nguyea6/INFO-201-Final-Project", "GitHub"))
    ),

    tabPanel("Traffic vs. Weekday Point Map",
      h3("Description:"),
        p("The map below displays a map of Seattle with the location of traffic measuring stations marked with a colored circle. The size of the circle correlates to the traffic volume at that station: the larger the circle, the more traffic there is. Differences in traffic volume over the week can be seen by changing which day data is being shown for and comparing the size of the circles."),
      sidebarLayout(

        sidebarPanel(
          selectInput("day.of.week", label = "Weekday:",
            choices = weekday.list)
        ),

        mainPanel(
          plotOutput('seattle.map', width = "100%")
        )
      ),
      h3("Analysis:"),
        p('Unsurprisingly, the Elliot Bay Trail data point is quite large in comparison to the other data points on the map. This location is on a major commuter pathway and is very close to Downtown Seattle, a major attraction to tourists and residents alike.'),
        p('What could be surprising to someone who isn\'t very acquainted with Seattle, or doesn\'t commute around Seattle, is how large the data point at Fremont Bridge is. Fremont Bridge leads to Google\'s Seattle headquarters, so a large amount of traffic here can be expected.')
    ),

    tabPanel("Traffic vs. Date Graph",
      h3("Description:"),
        p("The graphs below show average traffic volumes at chosen data collection locations by weekday and month. Since some traffic locations received significantly more traffic than other locations, a logarithmic scale was used so that data points with less traffic could be seen more clearly. Data for a specific location can be selected with the dropdown menus provided below."),
    selectInput("location.weekday.select", label = "Location:",
      choices = locations.list, selected = default.location),
    tabPanel("Graph",
      plotOutput('weekday.traffic.graph'),
      h3("Analysis:"),
        h4('Burke Gilman Trail (BGT.North.of.NE.70th)'),
          p('As one would expect there are less traffic volume on all streets during weekends except for street "BGT.North.of.NE.70th". "BGT.North.of.NE.70th" is a trail known as The Burke Gilman Trail, where a lot of people run, walk, and go biking. Typically, any time outside of the work week is used for leisure time and looking at the numbers for the Burke Gilman trail during the weekends indicates that many people spend their leisure time on this trail.'),
        h4('Fremont Bridge Sidewalk'),
          p('The Fremont Bridge is a bridge that is next to Google\'s Seattle office. The graph for Fremont Bridge is very high even during weekends however there is a huge spike in traffic starting on Monday and that traffic stays high until Friday, then there is a huge decrease from Friday to Saturday. Since Google\'s Seattle office is right next to the Fremont Bridge, many Google employees and possibly other smaller companies use The Fremont Bridge to get to their workplace. This graph indicates that there are many commuters that like to enjoy their weekends without crossing The Fremont Bridge. It is possible that they like to travel to a different locations or would prefer to stay home and rest. The same sort of trend can be seen in the 2nd Ave. Cycletrack, located in Downtown Seattle. The 2nd Ave. Cycletrack is close to Belltown, a residential and shopping area, which could explain this trend.'),
        h4('Elliot Bay Trail (Elliott.bay.trail.in.myrtle.Edwards.park)'),
          p('The Elliot Bay Trail has the highest traffic volume because it goes along the waterfront in Downtown Seattle. This area contains many small businesses and tourist attractions, which brings in any type of traffic all day and all year long. The graph consistently holds the highest traffic volume from Sunday through Saturday. This can be good and bad. High traffic can help businesses by bringing in customers, but it can potentially slow down customers and workers to are trying get to their specific destinations'),
        h4('38th Ave NE Greenway, 26th Ave SW Greenway, and NW 58th ST Greenway'),
          p('38th Ave NE Greenway, 26th Ave SW Greenway, and NW 58th ST Greenway all have relatively low traffic numbers compared to The Fremont Bridge and The Elliott Bay Trail because these 3 areas are residential areas. People who travel on these streets are mostly people leaving for work or children leaving for school.'),
      selectInput("location.month.select", label = "Location:",
        choices = locations.list, selected = default.location),
      plotOutput('month.traffic.graph'),
      h3("Analysis:"),
        p('Similar to the volumes for weekday vs weekends, designated pedestrian and bike trails (Burke-Gilman Trail, Elliott Bay Trail, and Fremont Bridge) have a significantly higher traffic volume throughout the year compared to other locations. The main variable considered by the different months is weather and temperature conditions. As seen in all locations on the graph, there is a very strong correlation between months with warmer temperatures/lowered precipitation and traffic volume. On average, the difference between months with lowest traffic volumes were about 50% of months with highest traffic volumes, and this is generally true for all data collection locations.'),
        p(''),
        p('One variation from the normal trend is an influx of pedestrians and cyclists during September and October compared to the summer months. This may be explained by the close proximity of a college to the trail, so volumes would be expected to increase as classes begin, normally in September to October. However, not many fluctuations are present from the overall trend that warmer months correlate to increased traffic volumes in all locations.')
      )
    ),

    tabPanel("Traffic vs. Weather Conditions Graph",
      h3("Description:"),
        p("The graph below displays average monthly traffic volume based on weather conditions. A trend line is included for viewers to better interpolate data points, though this may not be accurate for actually looking at the data points (take the snow line going through the Summer months for instance). Some points may be missing since that month may not have experienced a certain weather condition. Take snow in July for instance. Data for a specific weather condition can be selected using the dropdown menu below."),
      sidebarLayout(

        sidebarPanel(
          selectInput("weather.condition", label = "Weather Condition",
            choices = weather.condition.list, selected = default.weather)
        ),

        mainPanel(
          plotOutput('weather.traffic.graph')
        )

      ),
      h3("Analysis:"),
        p("One would think that more people would prefer getting around in their cars when there's rain, and would ride their bikes and walk when it's sunny. This is indeed the case in the Summer months, but the traffic volume during drizzly weather during the rest of the year surpasses the traffic volume during other conditions by a significant margin. This could be attributed to Seattle's famous wet weather. It appears as though the people of Seattle are so accustomed to rain that they're willing to walk and bike in it.")
    ),
    tabPanel("Conclusion",
      h3("Conclusion:"),
      p("Judging from the Map and Traffic vs. Date visualizations, the areas that could use the most improvement in terms of traffic management are The Fremont Bridge and The Elliot Bay Trail. Both these locations are near key destinations (Google\'s Seattle headquarters and Downtown Seatte respectively), and both these locations see a large volume of traffic on an almost daily basis. Improving these areas might encourage more people to walk or bike to get where they need to go, reducing emmissions and reducing vehicle traffic.")
    ),
    tabPanel("Citations", #https://shiny.rstudio.com/articles/tag-glossary.html
      h3("Citations:"),
      tags$ol(
        tags$li(tags$a(href="https://data.seattle.gov/Transportation/26th-Ave-SW-Greenway-at-SW-Oregon-St/mefu-7eau", "26th Ave SW Greenway at SW Oregon St")),
        tags$li(tags$a(href="https://data.seattle.gov/Transportation/2nd-Ave-Cycle-Track-North-of-Marion-St/avwm-i8ym", "2nd Ave Cycle Track North of Marion St")),
        tags$li(tags$a(href="https://data.seattle.gov/Transportation/39th-Ave-NE-Greenway-at-NE-62nd-St/3h7e-f49s", "39th Ave NE Greenway at NE 62nd St")),
        tags$li(tags$a(href="https://data.seattle.gov/Transportation/Broadway-Cycle-Track-North-Of-E-Union-St/j4vh-b42a", "Broadway Cycle Track North Of E Union St")),
        tags$li(tags$a(href="https://data.seattle.gov/Transportation/Burke-Gilman-Trail-north-of-NE-70th-St-Bike-and-Pe/2z5v-ecg8", "Burke Gilman Trail north of NE 70th St Bike and Ped Counter")),
        tags$li(tags$a(href="https://data.seattle.gov/dataset/City-Of-Seattle-Zoning/2hat-teay", "City Of Seattle Zoning")),
        tags$li("D. Kahle and H. Wickham. ggmap: Spatial Visualization with ggplot2.
        The R Journal, 5(1), 144-161. URL
        http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf"),
        tags$li(tags$a(href="https://data.seattle.gov/Transportation/Elliott-Bay-Trail-in-Myrtle-Edwards-Park/4qej-qvrz", "Elliott Bay Trail in Myrtle Edwards Park")),
        tags$li(tags$a(href="https://data.seattle.gov/Transportation/Fremont-Bridge-Hourly-Bicycle-Counts-by-Month-Octo/65db-xm6k", "Fremont Bridge Hourly Bicycle Counts by Month October 2012 to present")),
        tags$li(tags$a(href="https://data.seattle.gov/Transportation/NW-58th-St-Greenway-at-22nd-Ave-NW-Bike-Counter/47yq-6ugv", "NW 58th St Greenway at 22nd Ave NW Bike Counter")),
        tags$li(tags$a(href="https://github.com/vega/vega-datasets/blob/gh-pages/data/weather.csv", "Weather Data"))
      )
    )
  )
)
