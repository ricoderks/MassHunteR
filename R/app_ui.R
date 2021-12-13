#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    
    # Your application UI logic 
    navbarPage(
      title = paste0("MassHunteR - Qual | v", utils::packageVersion("MassHunteR")),
      
      # Files
      tabPanel(
        title = "Files",
        mod_files_ui(id = "result_files")
      ), # end Files
      
      # Help
      navbarMenu(
        title = "Help",
        tabPanel(
          title = "Help",
          mod_help_ui(id = "help")
        ),
        "----",
        tabPanel(
          title = "About",
          mod_about_ui(id = "about")
        )
      )
      # end Help
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'MassHunteR'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

