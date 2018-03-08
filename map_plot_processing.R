require(ggplot2)
require(ggmap)
require(rgdal)
require(dplyr)
require(scales)

source("traffic_data_processing.R")

# https://data.seattle.gov/dataset/City-Of-Seattle-Zoning/2hat-teay
# https://gist.github.com/lmullen/8375785
seattle.shape.data <- readOGR("data/City_of_Seattle_Zoning/WGS84/", "City_of_Seattle_Zoning") %>%
  fortify()

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
  coord_map()



PlotAvgTrafficByFactor <- function(data, factor) {
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
    y = "Traffic Volume (log10 scale)"
  )
  return(plot.out)
}

weekday.traffic.plot <- PlotAvgTrafficByFactor(avg.traffic.ped.bicycle.by.weekday, "Weekday")

# weekday.traffic.plot <- ggplot(
#   data = avg.traffic.ped.bicycle.by.weekday,
#   aes(
#     x = Weekday,
#     y = avg.traffic.vol,
#     group = location.name
#   )
# ) +
#   #http://ggplot2.tidyverse.org/reference/scale_continuous.html
#   #https://stackoverflow.com/a/15734133
#   scale_y_log10(breaks = pretty_breaks(n = 20)) +
#   geom_line(
#     linetype = "solid",
#     color = "dark gray",
#     size = 0.5
#   ) +
#   geom_point(
#     mapping = aes(
#       color = location.name
#     )
#   ) +
#   labs(
#     title = "Average Traffic Volume by Weekday",
#     x = "Day of the Week",
#     y = "Traffic Volume (log10 scale)"
#   )

month.traffic.plot <- PlotAvgTrafficByFactor(avg.traffic.ped.bicycle.by.month, "Month")
#
# month.traffic.plot <- ggplot(
#   data = avg.traffic.ped.bicycle.by.month,
#   aes(
#     x = Month,
#     y = avg.traffic.vol,
#     group = location.name
#   )
# ) +
#   scale_y_log10(breaks = pretty_breaks(n = 20)) +
#   geom_line(
#     linetype = "solid",
#     color = "dark gray",
#     size = 0.5
#   ) +
#   geom_point(
#     mapping = aes(
#       color = location.name
#     )
#   ) +
#   labs(
#     title = "Average Traffic Volume by Month",
#     x = "Month",
#     y = "Traffic Volume (log10 scale)"
#   )
