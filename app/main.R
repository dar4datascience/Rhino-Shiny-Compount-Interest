box::use(
  shiny[bootstrapPage, div, moduleServer, NS, renderUI, tags, uiOutput],
  bslib[bs_theme,
        page_sidebar],
  sass[font_google],
  ggplot2[theme_set,
          theme_bw],
)

box::use(
  app/view/sidebar_inputs
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
    "Building"
  )


}

# Enable thematic
thematic::thematic_shiny(font = "auto")

# Change ggplot2's default "gray" theme
theme_set(theme_bw(base_size = 16))

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {


    # Return data from sidebar_inputs module
    sidebar_inputs$server("sidebar")

  })
}
