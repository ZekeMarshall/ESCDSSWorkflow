# _targets.R file
library(targets)

# Load Scripts
source("R/filepaths.R")
source("R/constants.R")
source("R/get_data.R")
source("R/esc_model_functions.R")

# Set options
options(tidyverse.quiet = TRUE)
# tar_option_set(packages = c("biglm", "tidyverse"))

# Create targets
list(

  # A tidy data frame containing version one of the raw ESC-DSS suitability factor scores
  tar_target(
    tidy_scores_v1,
    get_tidy_scores(path = esc_v1_files)
  ),
  
  # A wide data frame containing version one of the Accumulated Temperature suitability scores
  tar_target(
    wide_scores_at,
    get_wide_scores_df(tidy_scores_df = tidy_scores_v1,
                       suit_factor = "at")
    
  ),
  
  # A wide data frame containing version one of the Continentality suitability scores
  tar_target(
    wide_scores_ct,
    get_wide_scores_df(tidy_scores_df = tidy_scores_v1,
                       suit_factor = "ct")
    
  ),
  
  # A wide data frame containing version one of the Moisture Deficit suitability scores
  tar_target(
    wide_scores_md,
    get_wide_scores_df(tidy_scores_df = tidy_scores_v1,
                       suit_factor = "md")
    
  ),
  
  # A wide data frame containing version one of the Exposure suitability scores
  tar_target(
    wide_scores_dams,
    get_wide_scores_df(tidy_scores_df = tidy_scores_v1,
                       suit_factor = "dams")
    
  ),
  
  # A wide data frame containing version one of the Soil Moisture Regime suitability scores
  tar_target(
    wide_scores_smr,
    get_wide_scores_df(tidy_scores_df = tidy_scores_v1,
                       suit_factor = "smr")
    
  ),
  
  # A wide data frame containing version one of the Soil Nutrient Regime suitability scores
  tar_target(
    wide_scores_snr,
    get_wide_scores_df(tidy_scores_df = tidy_scores_v1,
                       suit_factor = "snr")
    
  ),
  
  # A data frame containing the latest ESC model data
  tar_target(
    esc_params_file,
    loadESCParams(path = esc_params_path)
  ),
  
  # A data frame containing trimmed ESC model data
  tar_target(
    esc_params_tidy,
    tidyESCParams(params_file = esc_params_file)
  ),
  
  # A data frame containing modeled Accumulated Temperature (at) scores
  tar_target(
    ESCresults_at,
    ESCmodel(params = esc_params_tidy,
             factor = "at",
             min_val = 550, 
             max_val = 3000, 
             step = 5)
  ),
  
  # A data frame containing modeled Moisture Deficit (md) scores
  tar_target(
    ESCresults_md,
    ESCmodel(params = esc_params_tidy,
             factor = "md",
             min_val = 0,
             max_val = 320,
             step = 0.5)
  ),

  # A data frame containing modeled Continentality (ct) scores
  tar_target(
    ESCresults_ct,
    ESCmodel(params = esc_params_tidy,
             factor = "ct",
             min_val = 1,
             max_val = 12,
             step = 0.1)
  ),

  # A data frame containing modeled Exposure (dams) scores
  tar_target(
    ESCresults_dams,
    ESCmodel(params = esc_params_tidy,
             factor = "da",
             min_val = 2,
             max_val = 24,
             step = 0.1)
  ),

  # A data frame containing modeled Soil Moisture Regime (smr) scores
  tar_target(
    ESCresults_smr,
    ESCmodel(params = esc_params_tidy,
             factor = "smr",
             min_val = 0,
             max_val = 8,
             step = 0.1)
  ),

  # A data frame containing modeled Soil Nutrient Regime (snr) scores
  tar_target(
    ESCresults_snr,
    ESCmodel(params = esc_params_tidy,
             factor = "snr",
             min_val = 0,
             max_val = 6,
             step = 0.1)
  )
  
)