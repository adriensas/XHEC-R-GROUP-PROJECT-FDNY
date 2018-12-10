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

#Loading the firebox data, in order to merge the intervention data with the map
nyc_map_firebox <- st_read(dsn = "data/FDNY_Box_Locations.kml")
#https://www.google.com/maps/d/u/0/viewer?hl=en&mid=1P57skjWUo0KYfsinVweKLAcnAHA&ll=40.71433439509608%2C-73.88551614404662&z=11



layer1 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_1.csv")

layer2 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_2.csv")

layer3 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_3.csv")

layer4 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_4.csv")

layer5 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_5.csv")

layer6 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_6.csv")

layer7 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_7.csv")

layer8 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_8.csv")

layer9 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_9.csv")

nyc_map_firebox_full <- rbind(layer1, layer2, layer3, layer4, layer5, layer6, layer7, layer8, layer9)

nyc_map_firebox_full <- nyc_map_firebox_full %>% 
  mutate(Name = factor(Name),
         Borough = case_when(
           substr(Name, 1, 1) == "Q" ~ "Queens",
           substr(Name, 1, 1) == "M" ~ "Manhattan",
           substr(Name, 1, 1) == "B" ~ "Brooklyn",
           substr(Name, 1, 1) == "X" ~ "Bronx",
           substr(Name, 1, 1) == "R" ~ "Staten Island",
           TRUE ~ "AAA")

plot(nyc_map_firebox_full %>% select(Name)) #We need to have the same firebox codes in the original dataset (ie have the letter indicating the borough)


#Clean solution
layer_open <- function(i){
  st_read(dsn = "data/FDNY_Box_Locations.kml",
          layer = glue::glue("Fire_Boxes_", i, ".csv"))
}

nyc_map_firebox <- rbind(lapply(X = 1:9, layer_open))

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
=======
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

#Loading the firebox data, in order to merge the intervention data with the map
nyc_map_firebox <- st_read(dsn = "data/FDNY_Box_Locations.kml")
#https://www.google.com/maps/d/u/0/viewer?hl=en&mid=1P57skjWUo0KYfsinVweKLAcnAHA&ll=40.71433439509608%2C-73.88551614404662&z=11



layer1 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_1.csv")

layer2 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_2.csv")

layer3 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_3.csv")

layer4 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_4.csv")

layer5 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_5.csv")

layer6 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_6.csv")

layer7 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_7.csv")

layer8 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_8.csv")

layer9 = st_read(dsn = "data/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_9.csv")

nyc_map_firebox_full <- rbind(layer1, layer2, layer3, layer4, layer5, layer6, layer7, layer8, layer9)

nyc_map_firebox_full <- nyc_map_firebox_full %>% 
  mutate(Name = factor(Name))

plot(nyc_map_firebox_full %>% select(Name))



#Clean solution
layer_open <- function(i){
  st_read(dsn = "data/FDNY_Box_Locations.kml",
          layer = glue::glue("Fire_Boxes_", i, ".csv"))
}

nyc_map_firebox <- rbind(lapply(X = 1:9, layer_open))

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
  
  
<<<<<<< HEAD
=======
  
>>>>>>> 54058bf148069aba391d4097d758b429a04df51d
>>>>>>> 1dbbc0bb69c9e67c5df883444dc871fd292d3019
