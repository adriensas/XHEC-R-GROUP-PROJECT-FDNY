#' Give the statistic dataframe
#'
#' @param df main data frame
#' @param input shiny /list/ inputs
#'
#' @return data frame filtered and data frame with corresponding statistics
#'
#' @export
#' @rdname statistic-fdny
#'

statistic_fdny <- function(df, input){

  #call filter function to go from raw data to filtered data
  filtered_df <- filter_fdny(df, input)

  #create list of each element we want
  elements1 <- list(
    get_deployment_time(filtered_df),
    get_inteventions_per_box(filtered_df),
    get_nb_units(filtered_df),
    get_intervention_duration(filtered_df)
  )

  #extract col from each element of the list
  elements2 <- map(elements1, "col") %>%
    set_names(c("dep_time", "interv_per_box", "nb_units", "interv_duration"))


  stat_df <- map_dfr(elements2, build_stat_df, .id = "statistic")

  n_per_type <- filtered_df %>% group_by(INCIDENT_TYPE_DESC) %>% summarize(n = n())

  output <- list()
  output$filtered_df <- filtered_df
  output$statistic_df <- stat_df
  output$number_intervention_per_type <- n_per_type
  return(output)
}
