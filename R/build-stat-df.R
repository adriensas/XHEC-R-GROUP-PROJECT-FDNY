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


#take a vector as input and return a tibble with the min, mean, median and max of this vector
build_stat_df <- function(x){

  max_no_na <- partial(max, na.rm = TRUE)
  min_no_na <- partial(min, na.rm = TRUE)
  mean_no_na <- partial(mean, na.rm = TRUE)
  var_no_na <- partial(var, na.rm = TRUE)

  tibble(
    min = min_no_na(x),
    mean = mean_no_na(x),
    var = var_no_na(x),
    max = max_no_na(x)
  )
}
