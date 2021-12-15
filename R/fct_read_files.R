#' read_files 
#'
#' @title Read result files
#' @description Read MassHunter Qual result files
#' 
#' @param file_paths file paths to the files to read, multiple files is ok
#' @param file_names the actual file names
#'
#' @return data frame
#'
#' @author Rico Derks
#'
#' @importFrom tibble tibble
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom dplyr mutate
#' @importFrom purrr map
#' @importFrom readxl read_xls
#' @importFrom tidyr unnest
#'
#' @noRd
#'
read_mh_xls <- function(file_paths = NULL, file_names = NULL) {
  my_df <- tibble(file_paths = file_paths,
                  file_names = file_names)
  
  my_df <- my_df %>% 
    mutate(data = map(.x = .data$file_paths,
                      .f = ~ read_xls(path = .x))) %>% 
    unnest(cols = .data$data)
  
  return(my_df)
}

#'
#' @title Tidy data.frame
#'
#' @description Tidy data.frame for export/download
#' 
#' @param data data.frame with all the data
#' @param parameter which column to use for making a wide table
#' 
#' @author Rico Derks
#' 
#' @importFrom magrittr %>%
#' @importFrom tidyr pivot_wider
#' @importFrom rlang .data
#' @importFrom dplyr select
#' 
#' @noRd
tidy_df <- function(data = NULL, parameter = NULL) {
  
  param <- switch(parameter,
                  "area" = "Area",
                  "rt" = "RT",
                  "height" = "Height",
                  "width" = "Width",
                  "FWHM" = "FWHM",
                  "sym" = "Symmetry")
  
  if(!is.null(data)) {
    # get the column names
    cols <- colnames(data)
    
    # check if the column is present
    if(param %in% cols) {
      my_df <- data %>%
        select(-.data$file_paths) %>% 
        pivot_wider(id_cols = .data$file_names,
                    names_from = .data$Peak,
                    values_from = param,
                    names_prefix = "peak")
    } else {
      my_df <- NULL
    }
  } else {
    my_df <- NULL
  }
  
  return(my_df)
}