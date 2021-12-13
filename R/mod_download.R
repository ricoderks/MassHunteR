#' download UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session,r Internal parameters for {shiny}.
#'
#' @noRd 
#' 
#' @importFrom openxlsx createWorkbook addWorksheet saveWorkbook writeData
#'
#' @importFrom shiny NS tagList 
mod_download_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 12,
        uiOutput(
          outputId = ns("download_ui")
        )
      )
    )
  )
}

#' download Server Functions
#'
#' @noRd 
mod_download_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # download button
    output$download_ui <- renderUI({
      if(!is.null(r$result_files_name)) {
        tagList(
          downloadButton(
            outputId = ns("download_res"),
            label = "Download"
          ),
          hr()
        )
      }
      
    })
    
    
    # download excel file
    output$download_res <- downloadHandler(
      # define file name
      filename = "merged_results.xlsx",
      
      # make the content
      content = function(file) {
        # create workbook
        wb <- createWorkbook()
        
        # add sheets
        addWorksheet(wb = wb, 
                     sheetName = "Retention time")
        addWorksheet(wb = wb, 
                     sheetName = "Peak area")
        addWorksheet(wb = wb, 
                     sheetName = "Peak height")
        addWorksheet(wb = wb, 
                     sheetName = "Peak width")
        addWorksheet(wb = wb, 
                     sheetName = "Peak symmetry")
        addWorksheet(wb = wb, 
                     sheetName = "FWHM")
        
        # write the data
        writeData(wb = wb,
                  sheet = "Retention time",
                  x = r$rt)
        writeData(wb = wb,
                  sheet = "Peak area",
                  x = r$area)
        writeData(wb = wb,
                  sheet = "Peak height",
                  x = r$height)
        writeData(wb = wb,
                  sheet = "Peak width",
                  x = r$width)
        writeData(wb = wb,
                  sheet = "Peak symmetry",
                  x = r$sym)
        writeData(wb = wb,
                  sheet = "FWHM",
                  x = r$FWHM)
        
        # save the workbook
        saveWorkbook(wb = wb,
                     file = file)
      }
    )
    
  })
}
