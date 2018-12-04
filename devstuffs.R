library(devtools)
library(roxygen2)
library(usethis)
library(testthat)
library(knitr)

install.packages("testthat")

# Create the tests
usethis::use_test("filter")
usethis::use_test("get_deployment_time")
usethis::use_test("get_intervention_duration")

devtools::check()
