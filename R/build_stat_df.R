#' Take a vector as input and return a tibble with the min, mean, median and max of this vector
#'
#' @param x dataframe with a column `col` containing all the values
#'
#' @return A data frame containing min | mean | var | max
#' @export
#' @rdname build_stat_df
#'

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
