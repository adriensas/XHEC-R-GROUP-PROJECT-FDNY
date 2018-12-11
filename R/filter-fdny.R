#' Apply the filter to the main data frame
#'
#' @param df main data frame
#' @param input shiny /list/ inputs
#'
#' @return subset of the param data frame filtered following the input
#'
#' @export
#' @rdname filter-fdny
#'

filter_fdny <- function(df, input) {
  if(length(input$time_interval) == 0) {
    stop("A date  interval must be specified !")
  }
  filtered_df <- df %>%
    filter(inc_time >= input$time_interval[1], inc_time <= input$time_interval[2])
  if(length(input$zip_code) > 0) {
    filtered_df <- filtered_df %>%
      filter(as.character(zip_code) %in% input$zip_code)
  }
  if(length(input$type) > 0) {
    filtered_df <- filtered_df %>%
      filter(inc_type %in% input$type)
  }
  if(length(input$magnitude) > 0) {
    filtered_df <- filtered_df %>%
      filter(inc_type %in% input$magnitude)
  }

  return(filtered_df)
}
