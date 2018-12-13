#' Extract the number of units from a data frame with the same columns as tidy_incidents data.
#'
#' @param df data frame from which we want to extract the number of units
#'
#' @return data frame with a column named `col` containing all the number of units.
#' @import dplyr
#' @export
#' @rdname get_nb_units
#'

get_nb_units <- function(df){

  #get number of units
  nb_units <- df %>%
   dplyr::select(units) %>%
    rename(col = units)

  return(nb_units)

}
