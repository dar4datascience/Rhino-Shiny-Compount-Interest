box::use(
  shiny[sliderInput,
        numericInput,
        actionButton,
        helpText,
        tagList,
        tags,
        HTML,
        strong,
        moduleServer,
        icon,
        NS,
        bindEvent,
        observe],
)

box::use(
  app/logic/compount_interest_logic[calculate_compound_interest],
)

#' @export
ui <- function(id){
  ns <- NS(id)

  label1 = HTML(paste0("Select the number of ", strong("years"),":" ))

  label2 = HTML(paste0("Insert the ", strong("initial investment"),":" ))

  label3 = HTML(paste0("Select the expected ", strong("interest rate"), " in % per year:" ))

  label4 = HTML(paste0("Insert the ", strong("monthly deposit"),":" ))

  tagList(
    tags$style("#years {width:230px}"),

    sliderInput(inputId=ns("years"), label = label1, value = 20, min = 1, max = 80),

    tags$style("#PV {width:230px}"),

    numericInput(inputId=ns("PV"), label = label2, value = 5000, min = 0),

    tags$style("#i {width:230px}"),

    sliderInput(inputId=ns("i"), label = label3, value = 5, min = 1, max = 30),

    tags$style("#MD {width:230px}"),


    numericInput(inputId = ns("MD"), label = label4, value = 500, min = 0),

    tags$style("#Calculate {width:230px}"),
    actionButton(ns("Calculate"), "Calculate", icon("calculator"), style = "color: #fff; background-color: #337ab7; border-color: #2e6da4"),

    helpText(HTML(paste0(strong("All fields are required."), " The calculation is done with monthly contributions at the end of each month based on monthly compound intervals.")))
  )
}

#' @export
server <- function(id, result_of_simulation) {
  moduleServer(id, function(input, output, session) {

    observe({
      result_of_simulation$data <- calculate_compound_interest(input$years, input$PV, input$i, input$MD)
    }) |>
      bindEvent(input$Calculate)

  })
}
