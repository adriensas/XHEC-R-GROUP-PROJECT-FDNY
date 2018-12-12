nyfc_firebofireboxes <- read.csv("data/firebofireboxes.csv")

plot_firebofireboxes <- function(fireboxes){
  if (str_sub(fireboxes,1,1) %in% c("B", "M", "Q", "R", "fireboxes") && str_length(fireboxes) == 5){
    nyfc_firebofireboxes %>% 
      filter(Name %in% fireboxes) %>%
      leaflet() %>%
      addProviderTiles("CartoDB") %>%
      addCircleMarkers(lng = ~lon, lat = ~lat, label = ~paste0("<b>", Name, "</b>", "<br/>", "num of interventions"), 
        radius = 2, color = "red")
  }
  else {
    "Please enter a correct firebofireboxes number."
  }
}
