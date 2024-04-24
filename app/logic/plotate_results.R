box::use(
  highcharter[highchart,
              hc_chart,
              hc_xAxis,
              hc_plotOptions,
              hc_series],
  DT[datatable],
)

#' @export
plot_compount_interest <- function(result_of_simulation){

  # Define the plot
  highchart(result_of_simulation) %>%
    hc_chart(type = "column") %>%
    hc_xAxis(title = list(text = "Years")) %>%
    hc_plotOptions(column = list(
      dataLabels = list(enabled = FALSE),
      stacking = "normal",
      enableMouseTracking = TRUE)
    ) %>%
    hc_series(
      list(name = "Total Interest", data = result_of_simulation[['compound_df']]$`Total Interest`, color = "green"),
      list(name = "Total Deposits", data = result_of_simulation[['compound_df']]$`Total Deposits`, color = "blue")
    )
}


#' @export
table_results_of_simulation <- function(result_of_simulation){

  compound_df_table <-
    datatable(
      result_of_simulation,
      rownames = FALSE,
      options = list(
        scrollY = '450px',
        pageLength = nrow(result_of_simulation),
        dom = 't',
        ordering = FALSE
      )
    ) |>
      formatRound(c("Deposits", "Interest", "Total.Deposits", "Total.Interest", "Balance"), digits = 2)


  return(compound_df_table)

}
