#' Step2.R will generate strata.csv
#' 
#' manual: https://drexel-uhc.github.io/salurbal-project-dashboard/pages/manuals/step1.html
#' 
#' We want to look at the raw data check if any data is stratafied

# 1. Evaluate raw data  ----------------------------------------------------------------
{
  glimpse(data_raw)
  
  #' here data is not stratied by population (e.g. sex, age, .... etc)
  #' so we don't have to produce anything!
  
}

# 2. Code  ----------------------------------------------------------------
{
 #' no output needed
}


# 3. Review and save  ----------------------------------------------------------------
{
  strata_template %>% 
    fwrite(file = get_uhc_file_path(dataset_id,"strata.csv") )
}

message(paste("Step 2 Done:",dataset_id))
