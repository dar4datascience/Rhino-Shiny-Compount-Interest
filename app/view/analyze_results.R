box::use(shiny[moduleServer, NS, tags, uiOutput],
         DT[dataTableOutput],
         highcharter[renderHighchart,
                     highchartOutput])

box::use(
  app/logic/plotate_results[plot_compount_interest,
                            table_results_of_simulation],
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  tagList(
    ### Table
    dataTableOutput(ns("compound_df_table")),
    ### Plot
    highchartOutput(ns("compound_interest_plot"))
  )
}

#' @export
server <- function(id, result_of_simulation) {
  moduleServer(id, function(input, output, session) {

    output$compound_interest_plot <- renderHighchart({

      plot_compount_interest(result_of_simulation$data)

    })


    output$compound_df_table <- renderDataTable({

      table_results_of_simulation(result_of_simulation$data)

    })


  })
}

