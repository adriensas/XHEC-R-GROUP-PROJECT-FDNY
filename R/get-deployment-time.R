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
  deployment_time <- df %>%
    mutate(col = as.numeric(ARRIVAL_DATE_TIME) - as.numeric(INCIDENT_DATE_TIME)) %>%
    select(col)

 return(deployment_time)

}
