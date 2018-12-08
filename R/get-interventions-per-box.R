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
  nb_days <- 1 + as.numeric(trunc(max(df$INCIDENT_DATE_TIME), units = "days") - trunc(min(df$INCIDENT_DATE_TIME), units = "days"))

  interventions_per_box <- df %>%
    group_by(FIRE_BOX) %>%
    summarise(col = n()/nb_days) %>%
    select(col)

  return(interventions_per_box)
}
