
plot_leaflet_map <- function(map_data_df, input) {
  if(dim(map_data_df)[1]>1) {
    density_map_table <- nyfc_zip %>%
      dplyr::select(ZIPCODE, geometry) %>%
      left_join(map_data_df, by=c("ZIPCODE" = "zip_code")) %>%
      dplyr::select(n, geometry)

    map_density <- tm_shape(density_map_table) +
      tm_fill(col = input$map_info, alpha = 0.5, convert2density=TRUE) +
      tm_shape(density_map_table) +
      tm_borders()

    map_density_lf <- tmap_leaflet(map_density)

    return(map_density_lf)
    #if(length(input$fireboxSelect)>0) {
  #
    #}
  }
  else {
    return(leaflet())
  }
}
