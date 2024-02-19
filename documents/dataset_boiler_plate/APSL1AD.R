# 1. Setup ----------------------------------------------------------------
{
  ## Load dependencies
  rm(list=ls())
  library(tidyverse) 
  library(data.table)
  library(rstudioapi)
  
  ## Set directory to current folder
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  
  ## Load SALURBAL helpers
  sapply(list.files(path = '../../R/', all.files = T,recursive = T, full.names = T, pattern = '.R'), source)
  
  ## Local variables (only thing we should be change across `datasets`)
  dataset_id = "APSL1AD"
  file_data = "APSL1AD_06132022.csv"
  
  ## Imports 
  data_raw = get_uhc_file_path(dataset_id,file_data) %>% read_csv()
  data_template = read_csv("../../documents/templates/data_template.csv")
  strata_template = read_csv("../../documents/templates/strata_template.csv")
  xwalk_iso2 = read_csv("../../documents/crosswalks/xwalk_salid0_id0.csv") %>% select(salid0, iso2) %>% mutate_all(~as.character(.x))
  
  message(paste("Setup success:",dataset_id))
}

# 2. Run steps ------------------------------------------------------------
{                           ## outputs ##
  source("code/step1.R")    #  df_var_name + var_name.csv
  source("code/step2.R")    #  df_strata + strata.csv
  # source("code/step3.R")  #
  # source("code/step4.R")  #
  source("code/step5.R")    #
}
