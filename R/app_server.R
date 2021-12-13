#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # hold all data for this app
  r <- reactiveValues(result_files_name = NULL,
                      result_files_path = NULL,
                      area = NULL,
                      height = NULL,
                      rt = NULL,
                      width = NULL,
                      sym = NULL,
                      FWHM = NULL)
  
  # files section
  mod_files_server(id = "result_files",
                   r = r)
  
  # about section
  mod_about_server(id = "about")
}
