#' Extract the number of units from a data frame with the same columns as tidy_incidents data.
#'
#' @param map_data_df list of dataframe `heatmap` containing n, mean_interv_time, mean_nb_units per zip code. A list of dataframe `fire_box` containing n, mean_interv_time, mean_nb_units per fire box.
#' @param input input from the shiny app.
#'
#' @return plot a leaflet heatmap for the map_data_df
#' @import dplyr tmap leaflet
#' @export
#' @rdname plot_leaflet_map
#'

plot_leaflet_map <- function(map_data_df, input) {
  if (length(map_data_df)>0) {
    if (input$map_info=='Fire Box Map') {
      return(plot_firebox(map_data_df$fire_box))
    }
    if (length(map_data_df$heatmap)>1) {
      fct_lvl <- sort(union(levels(nyfc_zip$ZIPCODE), levels(map_data_df$heatmap$zip_code)))
      density_map_table <- nyfc_zip %>%
        mutate(ZIPCODE = factor(ZIPCODE, levels = fct_lvl)) %>%
        select(ZIPCODE, geometry) %>%
        left_join(
          map_data_df$heatmap %>% mutate(zip_code = factor(zip_code, levels = fct_lvl)),
          by=c("ZIPCODE" = "zip_code")
        ) %>%
        select(`Number of Intervention`, geometry, `Mean Intervention Duration`, `Mean Number of Units`)

      map_density <- tm_shape(density_map_table) +
        tm_fill(col = input$map_info, alpha = 0.5) +
        tm_shape(density_map_table) +
        tm_borders()

      map_density_lf <- tmap_leaflet(map_density) %>% 
        addProviderTiles("CartoDB", group = "CartoDB") %>%
        addLayersControl(baseGroups = c("CartoDB", "Esri"))
      return(map_density_lf)
    }
    else {
      return(leaflet())
    }
  }
  else {
    return(leaflet())
  }
}
