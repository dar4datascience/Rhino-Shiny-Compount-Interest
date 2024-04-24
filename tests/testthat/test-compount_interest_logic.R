box::use(
  testthat[expect_equal, expect_is, expect_true, test_that],
)

box::use(
  app/logic/compount_interest_logic[calculate_compound_interest],
)

# Define a test case for the calculate_compound_interest function
test_that("calculate_compound_interest calculates compound interest correctly", {
  # Define input parameters
  years <- 20
  initial_investment <- 5000
  interest_rate <- 5
  monthly_deposit <- 500

  # Calculate compound interest using the function
  compound_df <- calculate_compound_interest(years, initial_investment, interest_rate, monthly_deposit)

  # Check if the result is a data frame
  expect_is(compound_df, "data.frame")

  # Check if the number of rows in the result is equal to years + 1
  expect_equal(nrow(compound_df), years + 1)

  # Check if the columns are present in the result
  expect_true("Year" %in% colnames(compound_df))
  expect_true("Deposits" %in% colnames(compound_df))
  expect_true("Interest" %in% colnames(compound_df))
  expect_true("Total.Deposits" %in% colnames(compound_df))
  expect_true("Total.Interest" %in% colnames(compound_df))
  expect_true("Balance" %in% colnames(compound_df))

  # Check if the first row contains the correct initial values
  expect_equal(compound_df[1, "Year"], 0)
  expect_equal(compound_df[1, "Deposits"], initial_investment)
  expect_equal(compound_df[1, "Interest"], 0)
  expect_equal(compound_df[1, "Total.Deposits"], initial_investment)
  expect_equal(compound_df[1, "Total.Interest"], 0)
  expect_equal(compound_df[1, "Balance"], initial_investment)


})
