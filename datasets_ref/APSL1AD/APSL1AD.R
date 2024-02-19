# 1. Setup ----------------------------------------------------------------
{
  ##### Local Parameters #####
  rm(list=ls())
  dataset_id_tmp = "APSL1AD"
  file_data_tmp = "APSL1AD_06132022.csv"
  ############################
  
  ## Load dependencies
  library(tidyverse) 
  library(data.table)
  library(rstudioapi)
  
  ## Set directory to current folder
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  
  ## Load SALURBAL helpers
  sapply(list.files(path = '../../R/', all.files = T,recursive = T, full.names = T, pattern = '.R'), source)
  
  ## Local variables (only thing we should be change across `datasets`)
  
  ## Imports 
  data_raw = get_uhc_file_path(dataset_id_tmp,file_data_tmp) %>% read_csv()
  template__var_name = read_csv("../../documents/templates/1-var_name_template.csv")
  template__strata = read_csv("../../documents/templates/2-strata_template.csv")
  template__data = read_csv("../../documents/templates/5-data_template.csv")
  xwalk_iso2 = read_csv("../../documents/crosswalks/xwalk_salid0_id0.csv") %>% select(salid0, iso2) %>% mutate_all(~as.character(.x))

  message(paste("Setup success:",dataset_id_tmp))
  }

# 2. Run steps ------------------------------------------------------------
{                           ## outputs ##
  source("code/step1.R")    #  df_var_name 
  source("code/step2.R")    #  df_strata 
  # source("code/step3.R")  #
  # source("code/step4.R")  #
  source("code/step5.R")    #  df_data
}
