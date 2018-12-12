context("test-get_intervention_duration")

delta_t = c(30, 23*60*60 + 30*60)

test_data <- data.frame(
  arr_time = c(as.POSIXct(1417343844, origin='1970-01-01'), as.POSIXct(1417023844, origin='1970-01-01')),
  dep_time = c(as.POSIXct(1417343844, origin='1970-01-01'), as.POSIXct(1417023844, origin='1970-01-01')) + delta_t
)

expected_result <- data.frame(
  col = delta_t
)

test_that("We obtain the correct output", {
  expect_equal(
    get_intervention_duration(test_data),
    expected_result
  )
})
