#install.packages("sf")
#install.packages("raster")
#install.packages("rgdal")
#install.packages("tmap")
#install.packages("leaflet")
library("sf")
library("raster")
library("tidyverse")
library("rgdal")
library("xml2")
library("stringr")
library("tmap")
library("leaflet")

nyfc <- st_read(dsn = "data/nyfc",
                layer = "nyfc",
                quiet = TRUE)

nyfc_firebox <- read.csv("data/firebox.csv")

plot_firebox <- function(x){
  if (str_sub(x,1,1) %in% c("B", "M", "Q", "R", "X") && str_length(x) == 5){
    nyfc_firebox %>% 
      filter(Name %in% x) %>%
      leaflet() %>%
      addProviderTiles("CartoDB") %>%
      addCircleMarkers(lng = ~lon, lat = ~lat, label = ~paste0("<b>", Name, "</b>", "<br/>", "num of interventions"), 
        radius = 2, color = "red")
  }
  else {
    "Please enter a correct firebox number."
  }
}

