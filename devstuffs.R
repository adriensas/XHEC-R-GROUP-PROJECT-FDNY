library(devtools)
library(roxygen2)
library(usethis)
library(testthat)
library(knitr)

install.packages("testthat")

usethis::use_test("mean_per_time_step")

devtools::check()
