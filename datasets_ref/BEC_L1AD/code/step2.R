#' Step2.R will generate strata.csv
#' 
#' manual: https://drexel-uhc.github.io/salurbal-project-dashboard/pages/manuals/step1.html
#' 
#' We want to look at the raw data check if any data is stratafied

# 1. Evaluate    ----------------------------------------------------------------
{
  df_var_name  %>% count(var_name) # %>% View()
  #' Looking at the variables (var_name) I don't see any stratitfaction
  #' 
  template__strata
  #' here data is not stratafied by population (e.g. sex, age, .... etc)
  #' so we don't have to produce anything!
  
}

# 2. Code  ----------------------------------------------------------------
{
 df_strata = template__strata
    
}


# 3. Review and save  ----------------------------------------------------------------
{
  df_strata %>% fwrite(file = "2-strata.csv" )
  df_strata %>% fwrite(paste0("../../datasets/",dataset_id_tmp,"/2-strata.csv"))
  }

message(paste("Step 2 Done:",dataset_id_tmp))
