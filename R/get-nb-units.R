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

get_nb_units <- function(df){

  #get number of units
  nb_units <- df %>%
    select(UNITS_ONSCENE) %>%
    rename(col = UNITS_ONSCENE)

  return(nb_units)

}
