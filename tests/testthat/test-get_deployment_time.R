context("test-get_deployment_time")

delta_t = c(30, 23*60*60 + 30*60)

test_data <- data.frame(
  inc_time = c(as.POSIXct(1417343844, origin='1970-01-01'), as.POSIXct(1417023844, origin='1970-01-01')),
  arr_time = c(as.POSIXct(1417343844, origin='1970-01-01'), as.POSIXct(1417023844, origin='1970-01-01')) + delta_t
)

expected_result <- data.frame(
  col = delta_t
)

test_that("We obtain the correct output", {
  expect_equal(
    get_deployment_time(test_data),
    expected_result
  )
})
