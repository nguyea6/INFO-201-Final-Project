require(ggplot2)
require(ggmap)
require(rgdal)

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
    color = "light gray"
  ) +
  coord_map()

