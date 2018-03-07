# data_processing.R: Contains common variables and functions

traffic.greenway <- read.csv("data/bicycle/NW_58th_St_Greenway_at_22nd_Ave_NW_Bike_Counter.csv", stringsAsFactors = FALSE) %>%
  select("Date", "NW.58th.St.Greenway.st.22nd.Ave.NW.Total")

traffic.fremont.bridge <- read.csv("data/bicycle/Fremont_Bridge_Hourly_Bicycle_Counts_by_Month_October_2012_to_present.csv", stringsAsFactors = FALSE) %>%
  mutate(Fremont.Bridge.Sidewalk = Fremont.Bridge.West.Sidewalk + Fremont.Bridge.East.Sidewalk) %>%
  select("Date", "Fremont.Bridge.Sidewalk")

traffic.elliot.bay.trail <- read.csv("data/bicycle/Elliott_Bay_Trail_in_Myrtle_Edwards_Park.csv", stringsAsFactors = FALSE) %>%
  select("Date", "Elliott.Bay.Trail.in.Myrtle.Edwards.Park.Total")
traffic.burke.gilman.trail <- read.csv("data/bicycle/Burke_Gilman_Trail_north_of_NE_70th_St_Bike_and_Ped_Counter.csv", stringsAsFactors = FALSE) %>%
  select("Date", "BGT.North.of.NE.70th.Total")
traffic.broadway <- read.csv("data/bicycle/Broadway_Cycle_Track_North_Of_E_Union_St.csv", stringsAsFactors = FALSE) %>%
  select("Date", "Broadway.Cycle.Track.North.Of.E.Union.St.Total")
traffic.39th.ave <- read.csv("data/bicycle/39th_Ave_NE_Greenway_at_NE_62nd_St.csv", stringsAsFactors = FALSE) %>%
  select("Date", "X39th.Ave.NE.Greenway.at.NE.62nd.St.Total")
traffic.26th.ave <- read.csv("data/bicycle/26th_Ave_SW_Greenway_at_SW_Oregon_St.csv", stringsAsFactors = FALSE) %>%
  select("Date", "X26th.Ave.SW.Greenway.at.SW.Oregon.St.Total")
traffic.2nd.ave <- read.csv("data/bicycle/2nd_Ave_Cycle_Track_North_of_Marion_St.csv", stringsAsFactors = FALSE) %>%
  select("Date", "X2nd.Ave.Cycletrack")

traffic.ped.bicycle <-
  full_join(traffic.greenway, traffic.fremont.bridge, by = "Date") %>%
  full_join(traffic.elliot.bay.trail, by = "Date") %>%
  full_join(traffic.burke.gilman.trail, by = "Date") %>%
  full_join(traffic.broadway, by = "Date") %>%
  full_join(traffic.39th.ave, by = "Date") %>%
  full_join(traffic.26th.ave, by = "Date") %>%
  full_join(traffic.2nd.ave, by = "Date") %>%
  separate(Date, into = c("Date", "Time", "AMPM"), sep = " ") %>%
  mutate(Time = paste(Time, AMPM)) %>%
  select("Date", "Time",
    "NW.58th.St.Greenway.st.22nd.Ave.NW.Total",
    "Fremont.Bridge.Sidewalk",
    "Elliott.Bay.Trail.in.Myrtle.Edwards.Park.Total",
    "BGT.North.of.NE.70th.Total",
    "Broadway.Cycle.Track.North.Of.E.Union.St.Total",
    "X39th.Ave.NE.Greenway.at.NE.62nd.St.Total",
    "X26th.Ave.SW.Greenway.at.SW.Oregon.St.Total",
    "X2nd.Ave.Cycletrack"
  )
