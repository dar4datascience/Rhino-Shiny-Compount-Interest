# Function to calculate compound interest based on input parameters
#' @export
calculate_compound_interest <- function(years, initial_investment, interest_rate, monthly_deposit) {
  # Convert interest rate to decimal
  i <- interest_rate / 100
  # Initial investment
  PV <- initial_investment
  # Number of years
  t <- years
  # Number of compounding periods per year
  n <- 12
  # Monthly deposit
  MD <- monthly_deposit

  # Initialize vector to store balance
  Balance_vector <- c()
  # Loop through each year and calculate balance
  for (y in 1:t) {
    # Calculate balance using compound interest formula
    Balance_partial <- PV * ((1 + i/n)^(n*y)) + MD * (((1 + i/n)^(n*y) - 1) / (i/n))
    # Append calculated balance to vector
    Balance_vector <- append(Balance_vector, Balance_partial)
  }
  # Round balance vector to two decimal places
  Balance_vector <- round(Balance_vector, 2)
  # Include initial investment in balance vector
  Balance_vector <- c(PV, Balance_vector)

  # Create vector to store deposits for each year
  Deposit_vector <- rep(n * MD, t)
  # Include initial investment in deposit vector
  Deposit_vector <- c(PV, Deposit_vector)

  # Create vector for years
  year_vector <- 0:t

  # Create data frame to store results
  compound_df <- data.frame(
    Year = year_vector,
    Deposits = Deposit_vector,
    Interest = round(Balance_vector - Deposit_vector, 2),
    `Total Deposits` = cumsum(Deposit_vector),
    `Total Interest` = round(Balance_vector - cumsum(Deposit_vector), 2),
    Balance = Balance_vector
  )

  return(compound_df)
}

# Example usage:
# compound_df <- calculate_compound_interest(input$years, input$PV, input$i, input$MD)
