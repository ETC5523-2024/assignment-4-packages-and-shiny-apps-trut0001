#' Launch the Shiny App
#'
#' This function launches the Shiny app for exploring how US federal taxes are distributed.
#'
#' @return A Shiny app object.
#' @examples
#' if (interactive()) {
#'   usfederaltaxexplorer::run_app()
#' }
#' @export
run_app <- function() {
  shiny::runApp(system.file("shinyapp", "app.R", package = "usfederaltaxexplorer"))
}
