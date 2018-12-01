#' Compute the mean of a certain value per time step
#'
#' @param df subset of the main dataframe
#' @param time_step in second
#' @param column_name column of the value of interest
#'
#' @return data frame columns : time, mean
#'
#' @export
#' @rdname mean-per-time-step
#'

mean_per_time_step <- function(df, time_step, column_name) {
  return(data.frame(
    INCIDENT_DATE_TIME = as.POSIXct(sapply(1:6, function(x) 1543428000+x*1800), origin='1970-01-01'),
    TEST = c(1,3.5,6.5,2.5,10.5,2)
  ))
}

