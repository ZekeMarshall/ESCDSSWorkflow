# Global variables to store parameters for growth models and esc
speciesparams <- NULL
escparameters <- NULL

# Load the most recent version of the ESC-DSS models suitability curve function parameters
loadESCParams <- function(path){
  
  escparamsfile <- read.csv(path, strip.white = TRUE)
  
  return(escparamsfile)
  
}

tidyESCParams <- function(params_file){
  
  escparamstidy <- params_file |> 
    dplyr::select(7:31)
  
  return(escparamstidy)
  
}

ESCmodel <- function(params, factor, min_val, max_val, step){
  
  all_species <- unique(params$sci.name)
  
  all_model_results <- data.frame()
  
  for(species in all_species){
  
    params_spp <- params |>
      dplyr::filter(sci.name == species) |> 
      dplyr::select(paste0(factor, "4"),
                    paste0(factor, "3"),
                    paste0(factor, "2"),
                    paste0(factor, "1"))
    
    model_results <- data.frame()
    
    values <- seq(min_val, max_val, step)
    
    for(value in values){ # turn this into a lapply statement, or purr::map_dfr
      
      p1 <- params[1]
      p2 <- params[2]
      p3 <- params[3]
      p4 <- params[4]
      
      modelled_score <- sum((p1*value^3), 
                            (p2*value^2), 
                            (p3*value), 
                            (p4))
    
      result <- data.frame("species" = species,
                           "value" = value,
                           "score" = modelled_score
                           )
    
      model_results <- rbind(model_results, result)
      
      } # Close inner for loop
    
    all_model_results <- rbind(all_model_results, model_results) |> 
      dplyr::mutate(
        score = dplyr::case_when(
          score > 1 ~ 1,
          score < 0 ~ 0,
          TRUE ~ as.numeric(score)
        )
      )
    
    } # Close outer for loop
  
  return(all_model_results)
  
}