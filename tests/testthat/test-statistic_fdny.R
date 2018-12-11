context("test-statistic_fdny")

library(dplyr)
library(purrr)

load("../../data/incidents.RData")

data.test <- tidy_incidents

input <- list()
input$zip_code = c("10451")
input$time_interval = c(
  as.POSIXct(1417343844, origin='1970-01-01'),
  as.POSIXct(1427343844, origin='1970-01-01')
)
output_statistic <- statistic_fdny(data.test, input)

test_that("We indeed have 3 data.frame as a result, with the correct names", {
  expect_equal(
    'data.frame' %in% class(output_statistic$filtered_df) &
    'data.frame' %in% class(output_statistic$statistic_df) &
    'data.frame' %in% class(output_statistic$number_intervention_per_type),
    TRUE
  )
})

test_that("The statistic df have exactly the correct dimensions", {
  expect_equal(dim(output_statistic$statistic_df), c(4,5))
})
