#' run the app
#'
#' @export
#'
run_app <- function() {
  appDir <- system.file("FireHelp", package = "MAP535RFDNY")
  if (appDir == "") {
    stop("Could not find . Try re-installing `MAP535RFDNY`.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")
}
