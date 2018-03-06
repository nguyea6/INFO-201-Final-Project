# server.R: Calculates and returns output based on input

source("data_processing.R")

server <- function(input, output) {

}


install.packages("plotly")
library(ggplot2)
library(plotly)

ggplot(x, aes(x = "X26th.Ave.SW.Greenway.at.SW.Oregon.St.Total",
                              y = "Date")) +
  geom_point(aes(fill = "Time"))

ggplot() + 