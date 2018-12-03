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

#take a data frame as input and return a 1 column data frame of the deployment time for each intervention
get_deployment_time <- function(df) {

  #compute column for deployment time
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
    mutate(col = case_when(arrival_time > depart_time ~ arrival_time - depart_time,
                           arrival_time < depart_time ~ (86400 - arrival_time) + depart_time)) %>%
    select(col)

 return(deployment_time)

}
