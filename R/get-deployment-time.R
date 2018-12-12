#' Give the statistic dataframe
#'
#' @param df main data frame
#' @param input shiny /list/ inputs
#'
#' @return data frame filtered and data frame with corresponding statistics
#' @import dplyr
#' @export
#' @rdname statistic-fdny
#'

#take a data frame as input and return a 1 column data frame of the deployment time for each intervention
get_deployment_time <- function(df) {

  #compute column for deployment time
  deployment_time <- df %>%
    mutate(col = as.numeric(arr_time) - as.numeric(inc_time)) %>%
   dplyr::select(col)

 return(deployment_time)

}
