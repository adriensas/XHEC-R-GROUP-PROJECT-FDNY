#' Give the statistic dataframe
#'
#' @param df main data frame
#' @param input shiny /list/ inputs
#'
#' @return data frame filtered and data frame with corresponding statistics
#'
#' @import dplyr
#' @export
#' @rdname statistic-fdny
#'

get_nb_units <- function(df){

  #get number of units
  nb_units <- df %>%
   dplyr::select(units) %>%
    rename(col = units)

  return(nb_units)

}
