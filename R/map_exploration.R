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

#plot(nyc_map_fc %>% select(FireDiv))

#Loading the firebox data, in order to merge the intervention data with the map
nyc_map_firebox <- st_read(dsn = "data/FDNY_Box_Locations.kml")
#https://www.google.com/maps/d/u/0/viewer?hl=en&mid=1P57skjWUo0KYfsinVweKLAcnAHA&ll=40.71433439509608%2C-73.88551614404662&z=11


