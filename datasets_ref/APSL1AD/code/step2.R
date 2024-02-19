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
 
  df_strata = template__strata %>% 
    bind_rows(df_var_name %>% select(var_name)) %>% 
    ## select columns as per tempalte
    select(names(template__strata))
}


# 3. Review and save  ----------------------------------------------------------------
{

  ## examine
  df_strata
  
  
  ## save   
  df_strata %>% fwrite("2-strata.csv" )
  # df_strata %>% fwrite(paste0("../../datasets/",dataset_id_tmp,"/2-strata.csv"))
}

message(paste("Step 2 Done:",dataset_id_tmp))
