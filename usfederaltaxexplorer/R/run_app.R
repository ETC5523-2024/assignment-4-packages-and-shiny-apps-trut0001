#' Launch the Shiny App
#'
#' This function launches the Shiny app included in the package.
#'
#' @return A Shiny app object
#' @export
run_app <- function() {
  shiny::runApp(system.file("shinyapp", "app.R", package = "usfederaltaxexplorer"))
}
