context("test-get_nb_units")

test_data <- data.frame(
  IM_INCIDENT_KEY = c(1,2,3,4),
  UNITS_ONSCENE = c(2, 3, 4, 2)
)

expected_result <- data.frame(
  col = c(2, 3, 4, 2)
)

test_that("We have the expected result : ", {
  expect_equal(
    get_nb_units(test_data),
    expected_result
  )
})
