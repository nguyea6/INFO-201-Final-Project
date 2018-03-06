# data_processing.R: Contains common variables and functions

# processing the data from the files
Green.way.sw.26th <- read.csv("data/bicycle/26th_Ave_SW_Greenway_at_SW_Oregon_St.csv")
Green.way.ne.39th <- read.csv("data/bicycle/39th_Ave_NE_Greenway_at_NE_62nd_St.csv")
North.marion <- read.csv("data/bicycle/2nd_Ave_Cycle_Track_North_of_Marion_St.csv")
Broadway.cycle <- read.csv("data/bicycle/Broadway_Cycle_Track_North_Of_E_Union_St.csv")
Burke.gilman <- read.csv("data/bicycle/Burke_Gilman_Trail_north_of_NE_70th_St_Bike_and_Ped_Counter.csv")
Elliott.bay.myrtle.edwards <- read.csv("data/bicycle/Elliott_Bay_Trail_in_Myrtle_Edwards_Park.csv")
Fremont.bridge <- read.csv("data/bicycle/Fremont_Bridge_Hourly_Bicycle_Counts_by_Month_October_2012_to_present.csv")
Green.way.nw.58th <- read.csv("data/bicycle/NW_58th_St_Greenway_at_22nd_Ave_NW_Bike_Counter.csv")



# split cloumn date into date and time
Green.way.sw.26th$Time <- format(as.POSIXct(Green.way.sw.26th$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%H:%M:%S")
Green.way.sw.26th$Date <- format(as.POSIXct(Green.way.sw.26th$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%m/%d/%Y")

Green.way.ne.39th$Time <- format(as.POSIXct(Green.way.ne.39th$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%H:%M:%S")
Green.way.ne.39th$Date <- format(as.POSIXct(Green.way.ne.39th$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%m/%d/%Y")

Green.way.nw.58th$Time <- format(as.POSIXct(Green.way.nw.58th$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%H:%M:%S")
Green.way.nw.58th$Date <- format(as.POSIXct(Green.way.nw.58th$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%m/%d/%Y")

North.marion$Time <- format(as.POSIXct(North.marion$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%H:%M:%S")
North.marion$Date <- format(as.POSIXct(North.marion$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%m/%d/%Y")

Broadway.cycle$Time <- format(as.POSIXct(Broadway.cycle$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%H:%M:%S")
Broadway.cycle$Date <- format(as.POSIXct(Broadway.cycle$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%m/%d/%Y")

Burke.gilman$Time <- format(as.POSIXct(Burke.gilman$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%H:%M:%S")
Burke.gilman$Date <- format(as.POSIXct(Burke.gilman$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%m/%d/%Y")

Elliott.bay.myrtle.edwards$Time <- format(as.POSIXct(Elliott.bay.myrtle.edwards$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%H:%M:%S")
Elliott.bay.myrtle.edwards$Date <- format(as.POSIXct(Elliott.bay.myrtle.edwards$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%m/%d/%Y")

Fremont.bridge$Time <- format(as.POSIXct(Fremont.bridge$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%H:%M:%S")
Fremont.bridge$Date <- format(as.POSIXct(Fremont.bridge$Date,format="%m/%d/%Y %H:%M:%S", tz = ""),"%m/%d/%Y")

x <- merge(Green.way.ne.39th, Green.way.nw.58th)