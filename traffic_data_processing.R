# data_processing.R: Contains common variables and functions

require(dplyr)
require(tidyr)

CleanDataSet <- function(data.frame, col.name, lat, long) {
  # Returns a data frame with the data of the given data
  # frame organized into neat columns to prepare it for
  # joining with other data frames.
  #
  # Args:
  #   data.set: The given data frame.
  #   col.name: The name of the column containing desired information.
  #   lat: A latitude corresponding to the data frame's data.
  #   long: A longitude corresponding to the data frame's data.
  data.frame %>%
    mutate(
      traffic.vol = !!rlang::sym(col.name),
      location.name = col.name,
      lat = lat,
      long = long
    ) %>%
    select("Date", "location.name", "lat", "long", "traffic.vol") %>%
    return()
}

traffic.greenway <-
  read.csv("data/bicycle/NW_58th_St_Greenway_at_22nd_Ave_NW_Bike_Counter.csv",
    stringsAsFactors = FALSE) %>%
  CleanDataSet("NW.58th.St.Greenway.st.22nd.Ave.NW.Total",
    lat = 47.6709191, long = -122.3869181)

traffic.fremont.bridge <-
  read.csv("data/bicycle/Fremont_Bridge_Hourly_Bicycle_Counts_by_Month_October_2012_to_present.csv",
    stringsAsFactors = FALSE) %>%
  mutate(
    Fremont.Bridge.Sidewalk =
      Fremont.Bridge.West.Sidewalk + Fremont.Bridge.East.Sidewalk
  ) %>%
  CleanDataSet("Fremont.Bridge.Sidewalk",
    lat = 47.6475338, long = -122.3519361)

traffic.elliot.bay.trail <-
  read.csv("data/bicycle/Elliott_Bay_Trail_in_Myrtle_Edwards_Park.csv",
    stringsAsFactors = FALSE) %>%
  CleanDataSet("Elliott.Bay.Trail.in.Myrtle.Edwards.Park.Total",
    lat = 47.6080618, long = -122.3447558)

traffic.burke.gilman.trail <-
  read.csv("data/bicycle/Burke_Gilman_Trail_north_of_NE_70th_St_Bike_and_Ped_Counter.csv",
    stringsAsFactors = FALSE) %>%
  CleanDataSet("BGT.North.of.NE.70th.Total",
    lat = 47.6799869, long = -122.2655913)

traffic.broadway <-
  read.csv("data/bicycle/Broadway_Cycle_Track_North_Of_E_Union_St.csv",
    stringsAsFactors = FALSE) %>%
  CleanDataSet("Broadway.Cycle.Track.North.Of.E.Union.St.Total",
    lat = 47.6132426, long = -122.3211899)

traffic.39th.ave <-
  read.csv("data/bicycle/39th_Ave_NE_Greenway_at_NE_62nd_St.csv",
    stringsAsFactors = FALSE) %>%
  CleanDataSet("X39th.Ave.NE.Greenway.at.NE.62nd.St.Total",
    lat = 47.6739715, long = -122.2863352)

traffic.26th.ave <-
  read.csv("data/bicycle/26th_Ave_SW_Greenway_at_SW_Oregon_St.csv",
    stringsAsFactors = FALSE) %>%
  CleanDataSet("X26th.Ave.SW.Greenway.at.SW.Oregon.St.Total",
    lat = 47.562903, long = -122.3676473)

traffic.2nd.ave <-
  read.csv("data/bicycle/2nd_Ave_Cycle_Track_North_of_Marion_St.csv",
    stringsAsFactors = FALSE) %>%
  CleanDataSet("X2nd.Ave.Cycletrack",
    lat = 47.604445, long = -122.3352528)

# locations <- c(
#   "NW.58th.St.Greenway.st.22nd.Ave.NW.Total",
#   "Fremont.Bridge.Sidewalk",
#   "Elliott.Bay.Trail.in.Myrtle.Edwards.Park.Total",
#   "BGT.North.of.NE.70th.Total",
#   "Broadway.Cycle.Track.North.Of.E.Union.St.Total",
#   "X39th.Ave.NE.Greenway.at.NE.62nd.St.Total",
#   "X26th.Ave.SW.Greenway.at.SW.Oregon.St.Total",
#   "X2nd.Ave.Cycletrack"
# )

traffic.ped.bicycle <-
  full_join(traffic.greenway, traffic.fremont.bridge) %>%
  full_join(traffic.elliot.bay.trail) %>%
  full_join(traffic.burke.gilman.trail) %>%
  full_join(traffic.broadway) %>%
  full_join(traffic.39th.ave) %>%
  full_join(traffic.26th.ave) %>%
  full_join(traffic.2nd.ave) %>%
  separate(Date, into = c("Date", "Time", "AMPM"), sep = " ") %>%
  mutate(
    Time = paste(Time, AMPM),
    Weekday = weekdays(as.Date(Date)) #https://stackoverflow.com/a/9216316
  ) %>%
  select("Date", "Weekday", "Time", "location.name", "lat", "long", "traffic.vol")

avg.traffic.ped.bicycle.by.weekday <- traffic.ped.bicycle %>%
  drop_na() %>%
  group_by(Weekday, location.name) %>%
  summarize(
    avg.traffic.vol = mean(traffic.vol),
    lat = first(lat),
    long = first(long)
  ) %>%
  select("Weekday", "location.name", "lat", "long", "avg.traffic.vol")# %>%
#   arrange( #https://stackoverflow.com/a/46129338
#     factor(Weekday, levels = c("Sunday", "Monday", "Tuesday", "Wednesday",
#       "Thursday", "Friday", "Saturday")
#     )
#   )

  #https://sebastiansauer.github.io/ordering-bars/
  avg.traffic.ped.bicycle.by.weekday$Weekday <- factor(
    avg.traffic.ped.bicycle.by.weekday$Weekday,
    levels = c("Sunday", "Monday", "Tuesday", "Wednesday",
      "Thursday", "Friday", "Saturday")
  )
