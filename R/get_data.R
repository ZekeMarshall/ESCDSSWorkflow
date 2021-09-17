get_scores_raw <- function(path){
  
  scores_files <- list.files(path = path)
  
  scores_df_all <- data.frame()
  
  for (file in scores_files) {
    
    scores_file <- file.path(path, file)
    
    sheets <- readxl::excel_sheets(scores_file)
    
    scores_df <- data.frame()
    
    for (sheet in sheets) {
      
      scores <- readxl::read_xlsx(path = scores_file, sheet = sheet) |>
        dplyr::select(tidyselect::all_of(c(val_cols, suit_cols))) |> 
        dplyr::mutate(species = sheet)
      
      scores_df <- rbind(scores_df, scores)
      
    } # Close 2nd for loop
    
    scores_df_all <- rbind(scores_df_all, scores_df)
    
  } # Close 1st for loop
  
  return(scores_df_all)

} # Close function


tidy_scores_raw <- function(.raw_scores){
  
  at <- .raw_scores |> 
    dplyr::select("AT val", "AT suit", "species") |> 
    dplyr::rename("value" = "AT val",
                  "score" = "AT suit") |> 
    dplyr::mutate(factor = "at", .before = value) |> 
    dplyr::filter(!is.na(`value`))
  
  ct <- .raw_scores |> 
    dplyr::select("Con val", "Con suit", "species") |> 
    dplyr::rename("value" = "Con val",
                  "score" = "Con suit") |> 
    dplyr::mutate(factor = "ct", .before = value) |> 
    dplyr::filter(!is.na(`value`))
  
  md <- .raw_scores |> 
    dplyr::select("MD val", "MD suit", "species") |> 
    dplyr::rename("value" = "MD val",
                  "score" = "MD suit") |> 
    dplyr::mutate(factor = "md", .before = value) |> 
    dplyr::filter(!is.na(`value`))
  
  dams <- .raw_scores |> 
    dplyr::select("Dams val", "Dams suit", "species") |> 
    dplyr::rename("value" = "Dams val",
                  "score" = "Dams suit") |> 
    dplyr::mutate(factor = "dams", .before = value) |> 
    dplyr::filter(!is.na(`value`))
  
  smr <- .raw_scores |> 
    dplyr::select("SMR val", "SMR suit", "species") |> 
    dplyr::rename("value" = "SMR val",
                  "score" = "SMR suit") |> 
    dplyr::mutate(factor = "smr", .before = value) |> 
    dplyr::filter(!is.na(`value`))
  
  snr <- .raw_scores |> 
    dplyr::select("SNR val", "SNR suit", "species") |> 
    dplyr::rename("value" = "SNR val",
                  "score" = "SNR suit") |> 
    dplyr::mutate(factor = "snr", .before = value) |> 
    dplyr::filter(!is.na(`value`))
  
  
  scores_tidy <- rbind(at,ct,md,dams,smr,snr) |> 
    dplyr::relocate(species, .before = factor) |> 
    dplyr::filter(species != "master")
  
  return(scores_tidy)
  
}

get_tidy_scores <- function(path){
  
  scores_tidy <- get_scores_raw(path = path) |> 
    tidy_scores_raw()
  
  return(scores_tidy)
  
}

get_wide_scores_df <- function(tidy_scores_df, suit_factor){
  
  wide_scores_df <- tidy_scores_df |> 
    dplyr::filter(factor == suit_factor) |>
    tidyr::pivot_wider(names_from = value, values_from = score) |> 
    dplyr::add_row(species = ESC_spp_add, factor = suit_factor) |> 
    dplyr::arrange(species)
  
  return(wide_scores_df)
  
}

