#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # hold all data for this app
  r <- reactiveValues(merge_data = NULL)
  
  # about section
  mod_about_server(id = "about")
}
