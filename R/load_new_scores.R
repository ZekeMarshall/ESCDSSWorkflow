# Load new scores
load_new_scores <- function(path){
  
  scores_files <- list.files(path = path)
  
  scores_df_all <- data.frame()
  
  for (file in scores_files) {
    
    scores_file <- file.path(path, file)
    
    scores_df_raw <- read.csv(scores_file,
                          header = TRUE)
    
    scores_df <- scores_df_raw |>  
      tidyr::pivot_longer(cols = 3:ncol(scores_df_raw),
                          names_to = "Value",
                          values_to = "Score"
                          )
    
    scores_df_all <- rbind(scores_df_all, scores_df)
    
  }
  
  return(scores_df_all)
  
}


foo <-load_new_scores(path = new_scores)
