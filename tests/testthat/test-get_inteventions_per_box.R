context("test-get_inteventions_per_box")

test_data1 <- data.frame(
  fire_box = c(1, 1, 1, 2, 3, 4, 3),
  inc_time = c(
    as.POSIXct('2010/05/19 12:09:09'),
    as.POSIXct('2010/05/19 12:10:09'),
    as.POSIXct('2010/05/19 12:12:09'),
    as.POSIXct('2010/05/19 12:20:09'),
    as.POSIXct('2010/05/19 13:12:09'),
    as.POSIXct('2010/05/19 22:12:09'),
    as.POSIXct('2010/05/23 23:12:09')
  )
)

# The last date is different but should give the same result
test_data2 <- data.frame(
  fire_box = c(1, 1, 1, 2, 3, 4, 3),
  inc_time = c(
    as.POSIXct('2010/05/19 12:09:09'),
    as.POSIXct('2010/05/19 12:10:09'),
    as.POSIXct('2010/05/19 12:12:09'),
    as.POSIXct('2010/05/19 12:20:09'),
    as.POSIXct('2010/05/19 13:12:09'),
    as.POSIXct('2010/05/19 22:12:09'),
    as.POSIXct('2010/05/23 00:01:09')
  )
)

expected_data <- data.frame(
  col = c(3/5, 1/5, 2/5, 1/5)
)

test_that("Check that we obtain the expected result (1) : ", {
  expect_equal(
    get_inteventions_per_box(test_data1),
    expected_data
  )
})


test_that("Check that we obtain the expected result (2) : ", {
  expect_equal(
    get_inteventions_per_box(test_data2),
    expected_data
  )
})
