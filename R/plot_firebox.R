#install.packages("sf")
#install.packages("raster")
#install.packages("rgdal")
#install.packages("tmap")
library("sf")
library("raster")
library("tidyverse")
library("rgdal")
library("xml2")
library("stringr")
library("tmap")

nyfc <- st_read(dsn = "data/nyfc",
                layer = "nyfc",
                quiet = TRUE)

nyfc_firebox <- st_read(dsn = "data/firebox.kml",
                layer = "Fire_Boxes.csv",
                quiet = TRUE)


plot_firebox <- function(x){
  if (str_sub(x,1,1) %in% c("B", "M", "Q", "R", "X") && str_length(x) == 5){
    tm_shape(nyfc_firebox %>% filter(Name %in% x)) +
      tm_dots() +
      tm_shape(nyfc) +
      tm_borders()
  }
  else {
    "Please enter a correct firebox number."
  }
}