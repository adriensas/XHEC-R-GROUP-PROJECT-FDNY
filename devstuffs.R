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
usethis::use_test("get_inteventions_per_box")
usethis::use_test("get_nb_units")
usethis::use_test("statistic_fdny")

usethis::use_vignette('test')

devtools::check()

devtools::load_all()

load("../data/incidents.RData")
devtools::use_data(tidy_incidents, tidy_incidents)

nyfc_zip <- st_read(dsn = "data/ZIP_CODE_040114",
                    layer = "ZIP_CODE_040114",
                    quiet = TRUE)
devtools::use_data(nyfc_zip, nyfc_zip)
