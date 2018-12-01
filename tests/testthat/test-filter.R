context("test-filter")

library(dplyr)

load("../../data-raw/data.RData")

input <- list()
input$ZIP_CODE = "10451"
input$TIME_INTERVAL = c(1417343844, 1432982244)
filtered.data <- filter_fdny(data.use, input)

test_that("It gives a subset of the full df :", {
  expect_equal(filtered.data %>% arrange(IM_INCIDENT_KEY) %>% head(dim(data.use)[1]),
               data.use
              )
})

test_that("ZIP_CODE is fitered as expected :", {
  dim.error <- filtered.data %>% filter(ZIP_CODE != input$ZIP_CODE) %>% dim()
  expect_equal(dim.error, 0)
})

test_that("DATE is fitered as expected :", {
  dim.error <- filtered.data %>%
    filter(
            as.numeric(INCIDENT_DATE_TIME) < input$TIME_INTERVAL[1],
            as.numeric(INCIDENT_DATE_TIME) > input$TIME_INTERVAL[2]
           )
  expect_equal(dim.error, 0)
})
