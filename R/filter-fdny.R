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

  filtered_df <- df %>%
    filter(INCIDENT_DATE_TIME >= input$time_interval[1], INCIDENT_DATE_TIME <= input$time_interval[2]) %>%
    filter(ZIP_CODE %in% input$zip_code) %>%
    filter(INCIDENT_TYPE_DESC %in% input$type) %>%
    filter(HIGHEST_LEVEL_DESC %in% input$magnitude)

  return(filtered_df)
}
