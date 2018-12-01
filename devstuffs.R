library(devtools)
library(roxygen2)
library(usethis)
library(testthat)
library(knitr)

install.packages("testthat")

# Create the tests
usethis::use_test("mean_per_time_step")
usethis::use_test("filter")
usethis::use_test("mean_deployment_time")

devtools::check()
