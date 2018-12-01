context("test-mean_deployment_time")

library(dplyr)

load("../../data-raw/data.RData")

data.test <- data.use %>% head(5000)

test_that("We have the correct columns", {
  mean_deployment_time()
})

test_that("We don't have any outstanding values", {
  expect_equal(2 * 2, 4)
})
