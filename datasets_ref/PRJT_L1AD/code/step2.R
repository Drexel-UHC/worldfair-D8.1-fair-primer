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
  #' the PRJPOP variable is srtatafied by sex, lets documente that below
  
}


# 2. Code  ----------------------------------------------------------------
{
  
  ## intermediate table containing var_name that are strata
  df_strata_tmp = df_var_name %>% 
    filter(var_name == 'PRJPOP') %>% 
    mutate(
      strata_1_name = "Sex",
      strata_1_raw = var_name_raw %>% 
        recode("PRJL1ADPOP" = "",
               "PRJL1ADPOPF" = "F",
               "PRJL1ADPOPM" = "M"),
      strata_1_value = var_name_raw %>% 
        recode("PRJL1ADPOP" = "Overall",
               "PRJL1ADPOPF" = "Female",
               "PRJL1ADPOPM" = "Male"),
      strata_2_name = NA,
      strata_2_raw = NA,
      strata_2_value = NA,
      strata_id = paste(strata_1_name, strata_1_value,sep ="_") )
                          
  ## Intermediatetable containing var_name that are not stratfied
  df_non_strata_tmp = df_var_name %>% 
    filter(!var_name%in%df_strata_tmp$var_name)
  
  
  ## final table
  df_strata = bind_rows(df_strata_tmp, df_non_strata_tmp) %>% 
    select(names(template__strata))
}


# 3. Review and save  ----------------------------------------------------------------
{
  df_strata %>% fwrite(file ="2-strata.csv")
  df_strata %>% fwrite(paste0("../../datasets/",dataset_id_tmp,"/2-strata.csv"))
}

message(paste("Step 2 Done:",dataset_id_tmp))
