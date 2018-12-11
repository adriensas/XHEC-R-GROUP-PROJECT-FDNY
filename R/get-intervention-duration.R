#' Give the statistic dataframe
#'
#' @param df main data frame
#' @param input shiny /list/ inputs
#'
#' @return data frame filtered and data frame with corresponding statistics
#' @import dplyr
#' @export
#' @rdname statistic-fdny
#'

get_intervention_duration <- function(df) {
  intervention_duration <- df %>%
    mutate(col = as.numeric(dep_time) - as.numeric(arr_time)) %>%
   dplyr::select(col)

  return(intervention_duration)
}
