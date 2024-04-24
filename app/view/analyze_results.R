box::use(shiny[moduleServer, NS, tagList, req],
         DT[dataTableOutput,
            renderDataTable],
         plotly[renderPlotly,
                plotlyOutput],
         bslib[nav_panel,
               card_title,
               navset_card_tab],)

box::use(
  app/logic/plotate_results[plot_compount_interest,
                            table_results_of_simulation],
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  navset_card_tab(
    height = 450,
    full_screen = TRUE,
    title = "HTML Widgets",
    nav_panel(
      "Plot",
      card_title("A Plot"),
      ### Plot
      plotlyOutput(ns("compound_interest_plot"))
    ),
    nav_panel(
      "Table",
      card_title("A Table "),
      ### Table
      dataTableOutput(ns("compound_df_table")),
    )
  )


}

#' @export
server <- function(id, result_of_simulation) {
  moduleServer(id, function(input, output, session) {

    output$compound_interest_plot <- renderPlotly({

      req(result_of_simulation$data)

      plot_compount_interest(result_of_simulation$data)

    })


    output$compound_df_table <- renderDataTable({

      req(result_of_simulation$data)

      table_results_of_simulation(result_of_simulation$data)

    })


  })
}

