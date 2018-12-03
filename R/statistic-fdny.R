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
  filter_fdny(df, input)

  #create list of each element we want
  elements1 <- list(get_deployment_time(df), get_inteventions_per_box(df), get_nb_units(df))

  #extract col from each element of the list
  elements2 <- map(elements1, "col") %>%
    set_names(c("dep_time", "interv_per_box", "nb_units"))


  stat_df <- map_dfr(elements2, build_stat_df, .id = "statistic")

  return(stat_df)
}
