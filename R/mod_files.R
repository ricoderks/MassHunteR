#' files UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session,r Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_files_ui <- function(id){
  ns <- NS(id)
  tagList(
    inputPanel(
      fileInput(inputId = ns("result_files"),
                label = "Read files",
                multiple = TRUE)
    ),
    hr(),
    mod_download_ui(id = ns("download")),
    navbarPage(
      title = "",
      tabPanel(
        title = "Retention time",
        dataTableOutput(outputId = ns("show_rt"))
      ),
      tabPanel(
        title = "Peak area",
        dataTableOutput(outputId = ns("show_area"))
      ),
      tabPanel(
        title = "Peak height",
        dataTableOutput(outputId = ns("show_height"))
      ),
      tabPanel(
        title = "Peak width",
        dataTableOutput(outputId = ns("show_width"))
      ),
      tabPanel(
        title = "Peak symmetry",
        dataTableOutput(outputId = ns("show_sym"))
      ),
      tabPanel(
        title = "FWHM",
        dataTableOutput(outputId = ns("show_FWHM"))
      )
    )
  )
}

#' files Server Functions
#'
#' @noRd 
mod_files_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    mod_download_server(id = "download",
                        r = r)
    
    # observe file upload
    observe({
      req(input$result_files)
      
      if(!is.null(input$result_files)) {
        # store the file names
        r$result_files_name <- input$result_files$name
        # store the data paths
        r$result_files_path <- input$result_files$datapath
        
        # read the files
        res_df <- read_mh_xls(file_paths = r$result_files_path,
                              file_names = r$result_files_name) 
        
        # restructure the data
        r$area <- tidy_df(data = res_df,
                          parameter = "area")
        r$height <- tidy_df(data = res_df,
                            parameter = "height")
        r$width <- tidy_df(data = res_df,
                            parameter = "width")
        r$rt <- tidy_df(data = res_df,
                        parameter = "rt")
        r$sym <- tidy_df(data = res_df,
                         parameter = "sym")
        r$FWHM <- tidy_df(data = res_df,
                          parameter = "FWHM")
      }
    })
    
    
    # show the retention time table
    output$show_rt <- renderDataTable({
      req(r$rt)
      
      if(!is.null(r$rt)) {
        r$rt
      }
    })
    
    # show the area table
    output$show_area <- renderDataTable({
      req(r$area)
      
      if(!is.null(r$area)) {
        r$area
      }
    })
    
    # show the height table
    output$show_height <- renderDataTable({
      req(r$height)
      
      if(!is.null(r$height)) {
        r$height
      }
    })
    
    # show the width table
    output$show_width <- renderDataTable({
      req(r$width)
      
      if(!is.null(r$width)) {
        r$width
      }
    })
    
    # show the symmetry table
    output$show_sym <- renderDataTable({
      req(r$sym)

      if(!is.null(r$sym)) {
        r$sym
      }
    })
    
    # show the FWHM table
    output$show_FWHM <- renderDataTable({
      req(r$FWHM)
      
      if(!is.null(r$FWHM)) {
        r$FWHM
      }
    })
    
  })
}


