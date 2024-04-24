box::use(
  plotly[plot_ly,
              add_trace,
              layout],
  DT[datatable,
     formatRound],
)

#' @export
plot_compount_interest <- function(result_of_simulation){

  # Create the stacked bar chart using plot_ly
  plot_ly(data = result_of_simulation, type = "bar") |>
    add_trace(x = ~Year, y = ~Total.Interest, name = "Total Interest", marker = list(color = "green")) |>
    add_trace(x = ~Year, y = ~Total.Deposits, name = "Total Deposits", marker = list(color = "blue")) |>
    layout(xaxis = list(title = "Years"),
           yaxis = list(title = "Amount"),
           barmode = "stack")
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
