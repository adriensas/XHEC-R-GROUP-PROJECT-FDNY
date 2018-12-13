#' Apply the filter to the main data frame
#'
#' @param df main data frame
#' @param input shiny /list/ inputs
#'
#' @return subset of the param data frame filtered following the input
#' @import dplyr
#' @export
#' @rdname filter-fdny
#'

filter_fdny <- function(df, input) {
  if(length(input$time_interval) == 0) {
    stop("A date  interval must be specified !")
  }
  filtered_df <- df
  if(input$time_interval[2]-input$time_interval[1] > 0) {
    filtered_df <- filtered_df %>%
      filter(inc_time >= input$time_interval[1], inc_time <= input$time_interval[2])
  }
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
      filter(inc_level %in% input$magnitude)
  }
  if(length(input$district) > 0) {
    filtered_df <- filtered_df %>%
      filter(borough %in% input$district)
  }
  if(length(input$time_period) > 0) {
    filtered_df <- filtered_df %>%
      filter(as.numeric(format(as.POSIXct(filtered_df$inc_time, format="%Y-%m-%d %H:%M:%S"),
                               format="%H")) >= input$time_period[1],
             as.numeric(format(as.POSIXct(filtered_df$inc_time, format="%Y-%m-%d %H:%M:%S"),
                               format="%H")) <= input$time_period[2])
  }
  if(length(input$fireboxSelect) > 0) {
    filtered_df <- filtered_df %>%
      filter(fire_box %in% input$fireboxSelect)
  }

  return(filtered_df)
}
