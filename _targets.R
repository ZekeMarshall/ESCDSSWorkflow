# _targets.R file
library(targets)

# Load Scripts
source("R/filepaths.R")
source("R/constants.R")
source("R/get_data.R")

# Set options
options(tidyverse.quiet = TRUE)
# tar_option_set(packages = c("biglm", "tidyverse"))

# Create targets
list(

  # A tidy data frame containing version one of the raw ESC-DSS suitability factor scores
  tar_target(
    tidy_scores_v1,
    get_tidy_scores(path = esc_v1_files)
  )
  
)