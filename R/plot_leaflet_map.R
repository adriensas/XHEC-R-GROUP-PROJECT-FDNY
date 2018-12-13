
plot_leaflet_map <- function(map_data_df, input) {
  if (input$map_info=='fire_box') {
    return(plot_firebox(map_data_df$fire_box))
  }
  if (dim(map_data_df$heatmap)[1]>1) {
    density_map_table <- nyfc_zip %>%
      dplyr::select(ZIPCODE, geometry) %>%
      left_join(map_data_df$heatmap, by=c("ZIPCODE" = "zip_code")) %>%
      dplyr::select(n, geometry, mean_interv_time, mean_nb_units)

    map_density <- tm_shape(density_map_table) +
      tm_fill(col = input$map_info, alpha = 0.5) +
      tm_shape(density_map_table) +
      tm_borders()

    map_density_lf <- tmap_leaflet(map_density)
    return(map_density_lf)
  }
  else {
    return(leaflet())
  }
}
