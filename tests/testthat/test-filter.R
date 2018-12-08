context("test-filter")

library(dplyr)

data.test <- readRDS("../../data/fdny-data.rds")

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
    select("IM_INCIDENT_KEY") %>%
    unique() %>%
    pull()
  expect_equal(
    filtered.data,
    data.test %>% filter(IM_INCIDENT_KEY %in% filtered_key)
  )
})

test_that("ZIP_CODE is fitered as expected :", {
  dim.error <- filtered.data %>% filter(!(ZIP_CODE %in% input$zip_code)) %>% dim()
  expect_equal(dim.error[1], 0)
})

test_that("DATE is fitered as expected :", {
  dim.error <- filtered.data %>%
    filter(
     INCIDENT_DATE_TIME < input$time_interval[1],
     INCIDENT_DATE_TIME > input$time_interval[2]
    ) %>% dim()
  expect_equal(dim.error[1], 0)
})
