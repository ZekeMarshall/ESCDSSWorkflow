get_scores_tidy <- function(path){
  
  scores_files <- list.files(path = path)
  
  scores_df_all <- data.frame()
  
  for (file in scores_files) {
    
    scores_file <- file.path(path, file)
    
    sheets <- readxl::excel_sheets(scores_file)
    
    scores_df <- data.frame()
    
    for (sheet in sheets) {
      
      scores <- readxl::read_xls(path = scores_file, sheet = sheet, skip = 5) |>
        dplyr::select(tidyselect::all_of(c(val_cols, suit_cols))) |> 
        tidyr::pivot_longer(cols = tidyselect::everything(), 
                            names_to = c("factor", "metric"), 
                            names_sep = " ",
                            values_to = "value") |> 
        dplyr::filter(!is.na(value)) |>
        # tidyr::pivot_wider(names_from = "metric", value_from = "value") |>
        dplyr::mutate(species = sheet, .before = factor)
      
      scores_df <- rbind(scores_df, scores)
      
    } # Close 2nd for loop
    
    scores_df_all <- rbind(scores_df_all, scores_df)
    
  } # Close 1st for loop
  
  return(scores_df_all)

} # Close function

foo <- get_scores_tidy(path = esc_v1_files)
