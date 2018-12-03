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

statistic_fdny <- function(df, input){
  filter_fdny(df, input)

  #compute column fordeployment time
  #TODO how to return an error if negative in a clean way?
  deployment_time <- df %>%
    mutate(depart_time =
             (as.numeric(substr(INCIDENT_DATE_TIME,12,13))*3600) +
             (as.numeric(substr(INCIDENT_DATE_TIME,15,16))*60) +
             (as.numeric(substr(INCIDENT_DATE_TIME,18,19))),
           arrival_time =
             (as.numeric(substr(ARRIVAL_DATE_TIME,12,13))*3600) +
             (as.numeric(substr(ARRIVAL_DATE_TIME,15,16))*60) +
             (as.numeric(substr(ARRIVAL_DATE_TIME,18,19)))) %>%
    mutate(dep_time = arrival_time - depart_time) %>%
    select(dep_time)

  #number interventions by day and boxes
  nb_days <- as.Date(as.character(substr(tail(mod2$INCIDENT_DATE_TIME, 1), 1, 10)), format="%Y-%m-%d")-
    as.Date(as.character(substr(head(mod2$INCIDENT_DATE_TIME, 1), 1, 10)), format="%Y-%m-%d")

  nb_days <- as.numeric(nb_days)

  inteventions_per_box <- df %>%
    group_by(FIRE_BOX) %>%
    summarise(total = n()/nb_days)

  #get number of units
nb_units <-


  return(df)
}
