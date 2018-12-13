#' Extract the interventions per box from a data frame with the same columns as tidy_incidents data.
#'
#' @param df data frame from which we want to extract the interventions per box
#'
#' @return data frame with a column named `col` containing all the interventions per box.
#' @import dplyr
#' @export
#' @rdname get_inteventions_per_box
#'

get_inteventions_per_box <- function(df) {

  #number interventions by day and boxes
  nb_days <- 1 + as.numeric(trunc(max(df$inc_time), units = "days") - trunc(min(df$inc_time), units = "days"))

  interventions_per_box <- df %>%
    group_by(fire_box) %>%
    summarise(col = n()/nb_days) %>%
    select(col)

  return(interventions_per_box)
}
