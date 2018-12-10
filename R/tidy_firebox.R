#install.packages("sf")
#install.packages("raster")
#install.packages("rgdal")
library("sf")
library("raster")
library("tidyverse")
library("rgdal")
library("xml2")

#Loading and merging the firebox data
#https://www.google.com/maps/d/u/0/viewer?hl=en&mid=1P57skjWUo0KYfsinVweKLAcnAHA&ll=40.71433439509608%2C-73.88551614404662&z=11
layer1 = st_read(dsn = "data-raw/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_1.csv")
layer2 = st_read(dsn = "data-raw/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_2.csv")
layer3 = st_read(dsn = "data-raw/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_3.csv")
layer4 = st_read(dsn = "data-raw/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_4.csv")
layer5 = st_read(dsn = "data-raw/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_5.csv")
layer6 = st_read(dsn = "data-raw/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_6.csv")
layer7 = st_read(dsn = "data-raw/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_7.csv")
layer8 = st_read(dsn = "data-raw/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_8.csv")
layer9 = st_read(dsn = "data-raw/FDNY_Box_Locations.kml",
                 layer = "Fire_Boxes_9.csv")
nyc_map_firebox_full <- rbind(layer1, layer2, layer3, layer4, layer5, layer6, layer7, layer8, layer9)

#Tidying the data
nyc_map_firebox_full <- nyc_map_firebox_full %>% 
  mutate(Name = factor(Name))

#nyc_map_firebox_full <- nyc_map_firebox_full %>% 
#  mutate(Borough = case_when(
#           substr(Name, 1, 1) == "Q" ~ "5 - Queens",
#           substr(Name, 1, 1) == "M" ~ "1 - Manhattan",
#           substr(Name, 1, 1) == "B" ~ "4 - Brooklyn",
#           substr(Name, 1, 1) == "X" ~ "2 - Bronx",
#           substr(Name, 1, 1) == "R" ~ "3 - Staten Island",
#           TRUE ~ "AAA"),
#         Name = substr(Name,2,5),
#         Name = factor(Name))

#Ploting the data
plot(nyc_map_firebox_full %>% select(Name))

#Saving the new dataset
st_write(nyc_map_firebox_full, "data/firebox.kml", "Fire_Boxes.csv")