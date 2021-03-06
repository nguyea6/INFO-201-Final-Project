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
    #https://stackoverflow.com/a/9216316
    Weekday = weekdays(as.Date(as.character(Date), format = "%m/%d/%Y")),
    Month = months(as.Date(as.character(Date), format = "%m/%d/%Y")),
    Quarter = quarters(as.Date(as.character(Date), format = "%m/%d/%Y"))
  ) %>%
  select("Date", "Weekday", "Month", "Quarter", "Time", "location.name", "lat",
    "long", "traffic.vol")

weekday.list <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
  "Friday", "Saturday")
month.list <- c("January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December")
locations.list <- c(
  "NW.58th.St.Greenway.st.22nd.Ave.NW.Total",
  "Fremont.Bridge.Sidewalk",
  "Elliott.Bay.Trail.in.Myrtle.Edwards.Park.Total",
  "BGT.North.of.NE.70th.Total",
  "Broadway.Cycle.Track.North.Of.E.Union.St.Total",
  "X39th.Ave.NE.Greenway.at.NE.62nd.St.Total",
  "X26th.Ave.SW.Greenway.at.SW.Oregon.St.Total",
  "X2nd.Ave.Cycletrack",
  "All"
)
  default.location = "All"

GetAvgTrafficVolByCol <- function(data.frame.in, col.name) {
  # Returns a data frame that summarizes the average traffic volume in groups
  # defined by a given column name.
  #
  # Args:
  #   data.frame.in: A data frame
  #   col.name: The name of a column in the data frame for which the data is to
  #     be grouped by.
  #
  # Returns:
  #   A data frame with average traffic volumes per the given column name, such
  #   as average traffic per month or per weekday.
  data.frame.out <- data.frame.in %>%
    drop_na() %>%
    group_by(!!rlang::sym(col.name), location.name) %>%
    summarize(
      lat = first(lat),
      long = first(long),
      avg.traffic.vol = mean(traffic.vol)
    )
    if(col.name == "Weekday") {
      #https://sebastiansauer.github.io/ordering-bars/
      data.frame.out$Weekday <- factor(
        data.frame.out$Weekday,
        levels = weekday.list
      )
    } else if (col.name == "Month") {
      data.frame.out$Month <- factor(
        data.frame.out$Month,
        levels = month.list
      )
    }
  return(data.frame.out)
}

avg.traffic.ped.bicycle.by.weekday <-
  GetAvgTrafficVolByCol(traffic.ped.bicycle, "Weekday")
avg.traffic.ped.bicycle.by.time <-
  GetAvgTrafficVolByCol(traffic.ped.bicycle, "Time") %>%
    arrange(Time)
avg.traffic.ped.bicycle.by.month <-
  GetAvgTrafficVolByCol(traffic.ped.bicycle, "Month")
avg.traffic.ped.bicycle.by.quarter <-
  GetAvgTrafficVolByCol(traffic.ped.bicycle, "Quarter")
avg.traffic.ped.bicycle.by.day <-
  GetAvgTrafficVolByCol(traffic.ped.bicycle, "Date")

#https://github.com/vega/vega-datasets/blob/gh-pages/data/weather.csv
seattle.weather <- read.csv("data/weather.csv", stringsAsFactors=FALSE) %>%
  filter(location == "Seattle") %>%
  separate(date, into = c("Date", "Time"), sep = " ") %>%
  mutate(
    Date = format(as.Date(as.character(Date)), "%m/%d/%Y"),
    temp_avg = (temp_max - temp_min) / 2
  ) %>%
  select("Date", "precipitation", "temp_max", "temp_min", "temp_avg", "wind",
    "weather")

traffic.with.weather <- traffic.ped.bicycle %>%
  inner_join(seattle.weather, by = "Date")
  traffic.with.weather$Month <- factor(
    traffic.with.weather$Month,
    levels = month.list
  )

weather.traffic.summary <- traffic.with.weather %>%
  drop_na() %>%
  group_by(Month, weather) %>%
  summarize(
    avg.traffic.vol = mean(traffic.vol),
    lat = first(lat),
    long = first(long)
  )

weather.condition.list <- c(unique(seattle.weather$weather), "All")
  default.weather = "All"
