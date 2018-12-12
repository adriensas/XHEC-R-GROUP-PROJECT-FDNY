
compute_map_df <- function(filtered_df) {
  if(dim(filtered_df)[1]>1) {
    return(
      filtered_df %>%
        group_by(zip_code) %>%
        summarise(
          n=n(),
          mean_interv_time = as.integer(mean(as.numeric(dep_time) - as.numeric(arr_time), na.rm = TRUE)),
          mean_nb_units = as.integer(mean(units, na.rm = TRUE))
        )
    )
  } else {
    return(data.frame())
  }
}
