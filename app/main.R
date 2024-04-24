box::use(
  shiny[bootstrapPage, div, moduleServer, NS, renderUI, tags, reactiveValues],
  bslib[bs_theme,
        page_sidebar],
  sass[font_google],
  ggplot2[theme_set,
          theme_bw],
)

box::use(
  app/view/sidebar_inputs,
  app/view/analyze_results,
)
#' @export
ui <- function(id) {
  ns <- NS(id)
  page_sidebar(
    title = "Shiny Compound Interest Calculator 🧮",
    sidebar = sidebar_inputs$ui(ns("sidebar")),
    theme = bs_theme(
      bootswatch = "darkly",
      base_font = font_google("Poppins"),
      # Make purple grape the color of navbar
      navbar_bg = "#6a287e",
    ),
    analyze_results$ui(ns("analyze_results"))
  )


}

# Enable thematic
thematic::thematic_shiny(font = "auto")

# Change ggplot2's default "gray" theme
theme_set(theme_bw(base_size = 16))

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    result_of_simulation <- reactiveValues(data = NULL)


    # Return data from sidebar_inputs module
    sidebar_inputs$server("sidebar", result_of_simulation)
    # Return data from analyze_results module
    analyze_results$server("analyze_results", result_of_simulation)

  })
}
