
firebox_layer <- function(fireboxes){
  nyfc_firebox <- nyc_map_firebox_full
  #if (str_sub(fireboxes,1,1) %in% c("B", "M", "Q", "R", "X") && str_length(fireboxes) == 5){
    nyfc_firebox %>%
      filter(Name %in% fireboxes) %>%
      leaflet() %>%
      addProviderTiles("CartoDB") %>%
      addMarkers()
  #}
  #else {
  #  "Please enter a correct firebox number."
  #}
}
