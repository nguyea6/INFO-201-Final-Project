require(ggplot2)
require(ggmap)
require(rgdal)
require(dplyr)

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

weekday.traffic.plot <- ggplot(
  data = avg.traffic.ped.bicycle.by.weekday,
  aes(
    x = Weekday,
    y = avg.traffic.vol,
    group = location.name
  )
) +
  geom_line(
    linetype = "solid",
    color = "dark gray",
    size = 0.5
  ) +
  geom_point(
    color = "navy",
    size = 2
  )