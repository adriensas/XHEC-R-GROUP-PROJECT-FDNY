#' Plot the map containing the infos of each fire box.
#'
#' @param fireboxes_df a df containing  n | mean_interv_time | mean_nb_units for each fire_box
#'
#' @import dplyr leaflet
#'
#' @return Plot of the fire box with corresponding data
#' @export
#' @rdname plot_firebox

plot_firebox <- function(fireboxes_df){
  nyc_map_firebox_full_filtered <- nyc_map_firebox_full
  if (dim(fireboxes_df)[1] > 0) {
    fireboxes <- fireboxes_df %>% pull(fire_box)
    nyc_map_firebox_full_filtered <- nyc_map_firebox_full %>%
      filter(Name %in% fireboxes)

    fct_lvl <- sort(union(levels(nyc_map_firebox_full_filtered$Name), levels(fireboxes_df$fire_box)))
    fireboxes_df <- fireboxes_df %>% mutate(fire_box = factor(fire_box, fct_lvl))

    nyc_map_firebox_full_filtered <- nyc_map_firebox_full_filtered %>%
      mutate(Name = factor(Name, fct_lvl)) %>%
      left_join(fireboxes_df, by = c("Name"="fire_box"))
    if (dim(nyc_map_firebox_full_filtered)[1] > 0) {
      max_n <- max(fireboxes_df$`Number of Intervention`, na.rm = TRUE)
      min_n <- min(fireboxes_df$`Number of Intervention`, na.rm = TRUE)

      max_interv_time <- max(fireboxes_df$`Mean Intervention Duration`, na.rm = TRUE)
      min_interv_time <- min(fireboxes_df$`Mean Intervention Duration`, na.rm = TRUE)

      pal <- colorNumeric(c("green", "red"), nyc_map_firebox_full_filtered$`Mean Intervention Duration`)

      nyc_map_firebox_full_filtered %>%
        mutate(
          lon = st_coordinates(geometry)[,1],
          lat = st_coordinates(geometry)[,2],
          size = 2+70*(`Number of Intervention`-min_n)/max_n
        ) %>%
        leaflet() %>%
        addProviderTiles("CartoDB", group = "CartoDB") %>%
        addLayersControl(baseGroups = c("CartoDB", "Esri")) %>%
        addCircleMarkers(
          opacity = 1,
          lng = ~lon, lat = ~lat,
          popup = ~paste0("<b>",Name,"</b>", "<br/>Int.Dur : ", `Mean Intervention Duration`, "<br/>Nb units : ", `Mean Number of Units`, "<br/>Number : ", `Number of Intervention`),
          radius = ~size,
          color = ~pal(`Mean Intervention Duration`),
          clusterOptions = markerClusterOptions()
        ) %>%
        addLegend("topright", pal = pal, values = ~`Mean Intervention Duration`,
                  title = "Mean Intervention Duration",
                  opacity = 0.5
        )
    } else {
      return(leaflet())
    }
  } else {
    return(leaflet())
  }
}
