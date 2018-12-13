#' Extract the intervention duration from a data frame with the same columns as tidy_incidents data.
#'
#' @param df data frame from which we want to extract the intervention duration
#'
#' @return data frame with a column named `col` containing all the intervention duration.
#' @import dplyr
#' @export
#' @rdname get_intervention_duration
#'

get_intervention_duration <- function(df) {
  intervention_duration <- df %>%
    mutate(col = as.numeric(dep_time) - as.numeric(arr_time)) %>%
   dplyr::select(col)

  return(intervention_duration)
}
