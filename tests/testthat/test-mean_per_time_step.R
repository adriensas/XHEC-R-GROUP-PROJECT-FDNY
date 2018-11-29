context("test-mean_per_time_step")

input_df <- data.frame(
  INCIDENT_DATE_TIME = as.POSIXct(sapply(1:10, function(x) 1543425183+x*900), origin='1970-01-01'),
  TEST = c(1,4,3,5,8,0,3,19,2,2)
)

expected_df <- data.frame(
  INCIDENT_DATE_TIME = as.POSIXct(sapply(1:6, function(x) 1543428000+x*1800), origin='1970-01-01'),
  TEST = c(1,3.5,6.5,2.5,10.5,2)
)

test_that("The result is as expected", {
  output_df <- mean_per_time_step(input_df, 1800, 'TEST')
  expect_identical(output_df, expected_df)
})
