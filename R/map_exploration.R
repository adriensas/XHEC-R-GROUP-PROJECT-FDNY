<<<<<<< HEAD
#install.packages("sf")
#install.packages("raster")
#install.packages("rgdal")
library("sf")
library("raster")
library("tidyverse")
library("rgdal")
library("xml2")

#Loading a NYC map of the distribution of fire compagnies
nyc_map_fc <- st_read(dsn = "data/nyfc",
                      layer = "nyfc",
                      quiet = TRUE)

#Tidying the data
nyc_map_fc <- nyc_map_fc %>% 
  mutate(FireDiv = factor(FireDiv),
         FireBN = factor(FireBN))

plot(nyc_map_fc %>% select(FireDiv))


#Loading the firebox data
nyc_map_firebox <- st_read(dsn = "data/firebox.kml",
                           layer = "Fire_Boxes.csv")

plot(nyc_map_firebox %>% select(Name))


## Function to plot only a part of the map
PlotFireDiv <- function(filter){ #filter has to be a column name of the data set and level an admissible level
  #if( !(filter %in% colnames(nyc_map_fc)) ) stop("The selected filter is not admissible")
  nyc_map_fc %>% filter(filter == 2)
  #plot(st_geometry(nyc_map_fc %>% filter(filter == level)))
}

Plot <- function(FireDiv){
   plot(st_geometry(nyc_map_fc %>% filter(FireDiv == FireDiv)))
}

Plot2 <- function(filter){
  #plot(st_geometry(nyc_map_fc %>% filter(filter == 2)))
  head(nyc_map_fc %>% filter(as.factor(filter) == 2),20)
}
