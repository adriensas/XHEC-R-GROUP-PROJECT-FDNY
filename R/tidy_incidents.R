#' Data frame containing the New York FDNY incidents data over 5 years
#'
#' @format A data frame with 2277779 rows and 10 variables:
#' \describe{
#'   \item{id}{id of the incidents}
#'   \item{fire_box}{fire box}
#'   \item{inc_type}{type of incidents}
#'   \item{inc_time}{time at which the icident is detected/reported}
#'   \item{arr_time}{arrival time of the first unit}
#'   \item{dep_time}{departure time of the last unit}
#'   \item{units}{number of units deployed}
#'   \item{inc_level}{level of alert}
#'   \item{zip_code}{zip code as a factor}
#'   \item{borough}{borough as a factor}
#' }
#' @source \url{https://opendata.cityofnewyork.us/}
"tidy_incidents"
