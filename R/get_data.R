get_scores_tidy <- function(path){
  
  scores_files <- list.files(path = path)
  
  scores_df_all <- data.frame()
  
  for (file in scores_files) {
    
    scores_file <- file.path(path, file)
    
    sheets <- readxl::excel_sheets(scores_file)
    
    scores_df <- data.frame()
    
    for (sheet in sheets) {
      
      scores <- readxl::read_xls(path = scores_file, sheet = sheet, skip = 5) |>
        dplyr::select(tidyselect::all_of(val_and_score_cols)) |> 
        tidyr::pivot_longer(cols = tidyselect::everything()) |> 
        dplyr::filter(!is.na(value)) |> 
        dplyr::mutate(species = sheet, .before = name)
      
      scores_df <- rbind(scores_df, scores)
      
    } # Close 2nd for loop
    
    scores_df_all <- rbind(scores_df_all, scores_df)
    
  } # Close 1st for loop
  
  return(scores_df_all)

} # Close function
