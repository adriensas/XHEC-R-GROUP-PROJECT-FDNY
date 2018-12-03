context("test-filter")

library(dplyr)

data.test <- readRDS("../../data/fdny-data.rds")

input <- list()
input$zip_code = c("10451")
input$time_interval = c(
    as.POSIXct(1417343844, origin='1970-01-01'),
    as.POSIXct(1417343844, origin='1970-01-01')
  )
filtered.data <- filter_fdny(data.test, input)

test_that("It gives a subset of the full df :", {
  filtered.data %>%
    select(IM_INCIDENT_KEY) %>%
    unique(IM_INCIDENT_KEY) %>%
    pull()
  print(filtered.data)
  expect_equal(
    filtered.data %>% arrange(IM_INCIDENT_KEY) %>% head(dim(data.use)[1]),
    data.test
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
