require(ggplot2)
require(ggmap)
require(rgdal)
require(dplyr)
require(scales)

# https://data.seattle.gov/dataset/City-Of-Seattle-Zoning/2hat-teay
# https://gist.github.com/lmullen/8375785
seattle.shape.data <-
  readOGR("data/City_of_Seattle_Zoning/WGS84/", "City_of_Seattle_Zoning") %>%
  fortify()

PlotSeattleTraffic <- function(data) {
  # Returns a plot of the City of Seattle with streets outlined and data points
  # from the given data plotted as points.
  #
  # Args:
  #   data: A data frame. Should include long, lat, location.name and
  #   avg.traffic.vol.
  seattle.street.map <- ggplot() +
    geom_path(
      data = seattle.shape.data,
      aes(
        x = long,
        y = lat,
        group = group
      ),
      color = "dark gray"
    ) +
    coord_map() +
    geom_point(
      data = data,
      mapping = aes(
        x = long,
        y = lat,
        color = location.name,
        size = avg.traffic.vol
      ),
    ) +
    labs(
      title = "Map of Seattle with Key Traffic Locations",
      x = "Longitude",
      y = "Latitude"
  )
  return(seattle.street.map)
}

PlotAvgTrafficByFactor <- function(data, factor) {
  # Returns a plot of average traffic volume on a log10 scale versus a given
  # factor.
  #
  # Args:
  #   data: A data frame. Should include location.name, avg.traffic.vol, and
  #     a column that corresponds to the given factor.
  #   factor: A factor for which the plot is to be plotted against, such as
  #     month or weekday. Should correspond to a column in the data frame.
  plot.out <- ggplot(
    data = data,
    aes(
      x = get(factor),
      y = avg.traffic.vol,
      group = location.name
    )
  ) +
  #http://ggplot2.tidyverse.org/reference/scale_continuous.html
  #https://stackoverflow.com/a/15734133
  scale_y_log10(breaks = pretty_breaks(n = 20)) +
  geom_line(
    linetype = "solid",
    color = "dark gray",
    size = 0.5
  ) +
  geom_point(
    mapping = aes(
      color = location.name
    )
  ) +
  labs(
    title = paste("Average Traffic Volume by", factor),
    x = factor,
    y = "Traffic Volume (people/bikes) (log10 scale)"
  )
  return(plot.out)
}

# weekday.traffic.plot <-
#   PlotAvgTrafficByFactor(avg.traffic.ped.bicycle.by.weekday, "Weekday")
# month.traffic.plot <-
#   PlotAvgTrafficByFactor(avg.traffic.ped.bicycle.by.month, "Month")
# quarter.traffic.plot <-
#   PlotAvgTrafficByFactor(avg.traffic.ped.bicycle.by.quarter, "Quarter")
# day.traffic.plot <-
#   PlotAvgTrafficByFactor(avg.traffic.ped.bicycle.by.day, "Date")

PlotAvgTrafficByWeather <- function(data) {
  # Returns a plot with traffic volume plotted against weather conditions.
  #
  # Args:
  #   data: A data frame. Should include Month, avg.traffic.vol, and a weather
  #     grouping column.
  weather.traffic.plot <- ggplot(
    data = data,
    aes(
      x = Month,
      y = avg.traffic.vol,
      group = weather
    )
  ) +
  #https://janhove.github.io/reporting/2015/11/17/scatterplot-trendline
  geom_smooth(
    se = FALSE,
    size = 1,
    mapping = aes(
      color = weather
    )
  ) +
  geom_line(
    linetype = "dashed",
    color = "dark gray",
    size = 0.5
  ) +
  geom_point(
    mapping = aes(
      color = weather
    ),
  ) +
  labs(
    title = "Average Monthly Traffic Volume By Weather Condition",
    x = "Month",
    y = "Traffic Volume (people/bikes)"
  )
  return(weather.traffic.plot)
}
