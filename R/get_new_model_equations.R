# Extract an lm model formula as a character string
extract_model_equation <- function(model) {
  
  intercept <- paste(model$coefficients[[1]][[1]])
  coefficients <- paste(model$coefficients[2:length(model[[1]])])
  
  equation <- as.character()
  
  for (i in 1:length(coefficients)) {
    
    equation <- paste(equation, coefficients[i], "*x^", i, " + ", sep = "")
    
  }
  
  equation <- gsub('.{3}$', '', equation)
  
  equation <- paste(intercept, '+', equation)
  
  return(equation)
  
}

get_model_equations <- function(models_df, model_colname = "model"){
  
  equations <- as.character()
  
  for(i in seq(nrow(models_df))){
    
    equation <- extract_model_equation(model = models_df[[model_colname]][[i]])
    
    equations <- append(equations, equation)
    
  }
  
  model_and_equation_df <- models_df |> 
    dplyr::mutate("equation" = equations) |> 
    dplyr::select(-model_colname)
  
  return(model_and_equation_df)
  
  
}
