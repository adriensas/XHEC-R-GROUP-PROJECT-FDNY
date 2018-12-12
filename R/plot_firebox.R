#install.packages("sf")
#install.packages("raster")
#install.packages("rgdal")
#install.packages("tmap")
#install.packages("leaflet")
#install.packages("htmltools")
library("sf")
library("raster")
library("tidyverse")
library("rgdal")
library("fireboxesml2")
library("stringr")
library("tmap")
library("leaflet")
library("htmltools")

nyfc <- st_read(dsn = "data/nyfc",
                layer = "nyfc",
                quiet = TRUE)

nyfc_firebox <- read.csv("data/firebofireboxes.csv")

plot_firebox <- function(fireboxes){
  if (str_sub(fireboxes,1,1) %in% c("B", "M", "Q", "R", "fireboxes") && str_length(fireboxes) == 5){
    nyfc_firebox %>% 
      filter(Name %in% fireboxes) %>%
      leaflet() %>%
      addProviderTiles("CartoDB", group = "CartoDB") %>%
      addProviderTiles("Esri", group = "Esri") %>%
      addLayersControl(baseGroups = c("CartoDB", "Esri")) %>% 
      addCircleMarkers(lng = ~lon, lat = ~lat, label = ~paste0("<b>", htmlEscape(Name), "</b>", "<br/>", "num of interventions"), 
        radius = 2, color = "red", clusterOptions = markerClusterOptions())
  }
  else {
    "Please enter a correct firebox number."
  }
}
#Number of intervention to be changed in : get_inteventions_per_bofireboxes(fireboxes)
#Intervention duration time : get_intervention_duration(fireboxes)
#get_deployment_time(fireboxes)
#get_nb_units(fireboxes)