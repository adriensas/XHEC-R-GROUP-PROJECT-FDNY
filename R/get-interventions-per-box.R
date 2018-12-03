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

get_inteventions_per_box <- function(df) {

  #number interventions by day and boxes
  nb_days <- as.Date(as.character(substr(tail(df$INCIDENT_DATE_TIME, 1), 1, 10)), format="%Y-%m-%d")-
    as.Date(as.character(substr(head(df$INCIDENT_DATE_TIME, 1), 1, 10)), format="%Y-%m-%d")

  nb_days <- as.numeric(nb_days)

  interventions_per_box <- df %>%
    group_by(FIRE_BOX) %>%
    summarise(col = n()/nb_days) %>%
    select(col)

  return(interventions_per_box)
}
