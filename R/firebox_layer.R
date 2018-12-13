#library("htmltools")

plot_firebox <- function(fireboxes_df){
  nyc_map_firebox_full_filtered <- nyc_map_firebox_full
  if (dim(fireboxes_df)[1] > 0) {
    fireboxes <- fireboxes_df %>% pull(fire_box)
    nyc_map_firebox_full_filtered <- nyc_map_firebox_full %>%
      filter(Name %in% fireboxes)

    nyc_map_firebox_full_filtered <- nyc_map_firebox_full_filtered %>%
      left_join(fireboxes_df, by = c("Name"="fire_box"))

    max_n <- max(fireboxes_df$n, na.rm = TRUE)
    min_n <- min(fireboxes_df$n, na.rm = TRUE)

    max_interv_time <- max(fireboxes_df$mean_interv_time, na.rm = TRUE)
    min_interv_time <- min(fireboxes_df$mean_interv_time, na.rm = TRUE)

    pal <- colorQuantile("Reds", nyc_map_firebox_full_filtered$mean_interv_time, n = 7)

    nyc_map_firebox_full_filtered %>%
      mutate(
        lon = st_coordinates(geometry)[,1],
        lat = st_coordinates(geometry)[,2],
        size = 2+70*(n-min_n)/max_n
      ) %>%
      leaflet() %>%
      addProviderTiles("CartoDB", group = "CartoDB") %>%
      addLayersControl(baseGroups = c("CartoDB", "Esri")) %>%
      addCircleMarkers(
        opacity = 1,
        lng = ~lon, lat = ~lat,
        popup = ~paste0("<b>",Name,"</b>", "<br/>Int.Dur : ", mean_interv_time, "<br/>Nb units : ", mean_nb_units, "<br/>Number : ", n),
        radius = ~size,
        color = ~pal(mean_interv_time),
        clusterOptions = markerClusterOptions()
      )
  } else {
    return("No statistics to display.")
  }
}
#radius = 2+5*(n-min_n)/max_n,
#Number of intervention to be changed in : get_inteventions_per_bofireboxes(fireboxes)
#Intervention duration time : get_intervention_duration(fireboxes)
#get_deployment_time(fireboxes)
#get_nb_units(fireboxes)
