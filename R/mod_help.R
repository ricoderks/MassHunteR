#' help UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_help_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        column = 12,
        HTML("Work in progress....")
      )
    )
  )
}

#' help Server Functions
#'
#' @noRd 
mod_help_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
  })
}
