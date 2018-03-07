library("rgdal")
#library("maptools")
library("ggplot2")
library("ggmap")
#library("plyr")

#  utah = readOGR(dsn="/home/andrew/Documents/INFO 201/INFO-201-Final-Project/data/Seattle City Limits/WGS84/")
#   utah@data$id = rownames(utah@data)
#   utah.points = fortify(utah, region="id")
#   utah.df = join(utah.points, utah@data, by="id")

seattle.shape <- readOGR("/home/andrew/Documents/INFO 201/INFO-201-Final-Project/data/City_of_Seattle_Zoning/WGS84/", "City_of_Seattle_Zoning")
#seattle.shape <- readOGR("/home/andrew/Documents/INFO 201/INFO-201-Final-Project/data/Street_Network_Database/WGS84/", "Street_Network_Database.StName")
#seattle.shape <- readOGR("/home/andrew/Documents/INFO 201/INFO-201-Final-Project/data/Shorelines/WGS84/", "Shorelines")
seattle.df <- fortify(seattle.shape)
  
  map <- ggplot() +
    geom_path(
      data = seattle.df,
      aes(
        x = long,
        y = lat,
        group = group
        #fill = "white"
      ),
      color = "gray"
    ) +
    coord_map() 
    
    print(map)
