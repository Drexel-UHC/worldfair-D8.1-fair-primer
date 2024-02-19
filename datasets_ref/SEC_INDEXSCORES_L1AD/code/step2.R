#' Step2.R will generate strata.csv
#' 
#' manual: https://drexel-uhc.github.io/salurbal-project-dashboard/pages/manuals/step1.html
#' 
#' We want to look at the raw data check if any data is stratafied

# 1. Evaluate  ----------------------------------------------------------------

# 1.1 raw data  -----------------------------------------------------------
{
  glimpse(data_raw)
  
  #' ## Evaluation ##
  #' no strata. just return empty template
  
}

# 1.2 action plan  -----------------------------------------------------------
{

}

# 2. Code  ----------------------------------------------------------------
{
  df_strata =  template__strata %>% 
    ## select columns as per template
    select(names(template__strata)) 
}


# 3. Review and save  ----------------------------------------------------------------
{
  df_strata %>% fwrite(file ="2-strata.csv")
  df_strata %>% fwrite(paste0("../../datasets/",dataset_id_tmp,"/2-strata.csv"))
}

message(paste("Step 2 Done:",dataset_id_tmp))
