context("test-filter")

library(dplyr)

load("../../data/incidents.RData")

data.test <- tidy_incidents

input <- list()
input$zip_code = c("10451")
input$time_interval = c(
    as.POSIXct(1417343844, origin='1970-01-01'),
    as.POSIXct(1427343844, origin='1970-01-01')
  )
filtered.data <- filter_fdny(data.test, input)

test_that("There is actually elements in the filtered data frame :", {
  expect_equal(dim(filtered.data)[1] > 0, TRUE)
})

test_that("It gives a subset of the full df :", {
  filtered_key <- filtered.data %>%
    select("id") %>%
    unique() %>%
    pull()
  expect_equal(
    filtered.data,
    data.test %>% filter(id %in% filtered_key)
  )
})

test_that("zip_code is fitered as expected :", {
  dim.error <- filtered.data %>% filter(!(zip_code %in% input$zip_code)) %>% dim()
  expect_equal(dim.error[1], 0)
})

test_that("date is fitered as expected :", {
  dim.error <- filtered.data %>%
    filter(
     inc_time < input$time_interval[1],
     inc_time > input$time_interval[2]
    ) %>% dim()
  expect_equal(dim.error[1], 0)
})
