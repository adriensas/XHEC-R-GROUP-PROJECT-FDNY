#' Extract the deployment time from a data frame with the same columns as tidy_incidents data.
#'
#' @param df data frame from which we want to extract the deployment time
#'
#' @return data frame with a column named `col` containing all the deployment time.
#' @import dplyr
#' @export
#' @rdname get_deployment_time
#'

#take a data frame as input and return a 1 column data frame of the deployment time for each intervention
get_deployment_time <- function(df) {

  #compute column for deployment time
  deployment_time <- df %>%
    mutate(col = as.numeric(arr_time) - as.numeric(inc_time)) %>%
   select(col)

 return(deployment_time)

}
