#install.packages("sf")
#install.packages("raster")
#install.packages("rgdal")
library("sf")
library("raster")
library("tidyverse")
library("rgdal")
library("xml2")

nyc_map_fc <- st_read(dsn = "data/nyfc",
                      layer = "nyfc",
                      quiet = TRUE)

nyc_map_fc <- nyc_map_fc %>% 
  mutate(FireDiv = factor(FireDiv),
         FireBN = factor(FireBN))

nyc_map_firebox <- st_read(dsn = "data/FDNY_Box_Locations.kml")

test <- read_xml("data/FDNY_Box_Locations.kml")
test <- read_xml("D://henri/Documents/2018 Polytechnique annee 3/Data Science for Business/RProject/XHEC-R-GROUP-PROJECT-FDNY/data/FDNY_Box_Locations.kml")

idx <- 0
xml_find_all(test, ".//Folder/name") %>%
  walk(~{
    idx <<- idx + 1
    xml_text(.x) <- sprintf("%s-%s", idx, xml_text(.x))
  })

write_xml(test, "D://henri/Documents/2018 Polytechnique annee 3/Data Science for Business/RProject/XHEC-R-GROUP-PROJECT-FDNY/data/FDNY_Box_Locations_2.kml")

test2 <- read_xml("D://henri/Documents/2018 Polytechnique annee 3/Data Science for Business/RProject/XHEC-R-GROUP-PROJECT-FDNY/data/FDNY_Box_Locations_2.kml")


#https://www.google.com/maps/d/u/0/viewer?hl=en&mid=1P57skjWUo0KYfsinVweKLAcnAHA&ll=40.71433439509608%2C-73.88551614404662&z=11