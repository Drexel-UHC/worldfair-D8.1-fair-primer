#' Step2.R will generate strata.csv
#' 
#' manual: https://drexel-uhc.github.io/salurbal-project-dashboard/pages/manuals/step1.html
#' 
#' We want to look at the raw data check if any data is stratafied

# 1. Evaluate    ----------------------------------------------------------------
{
  df_var_name # %>% View()
  #' Looking at the variables, I see tw
  #' 
  template__strata
  #' here data is not stratied by population (e.g. sex, age, .... etc)
  #' so we don't have to produce anything!
  
}

# 2. Code  ----------------------------------------------------------------
{
  df_strata = df_var_name %>% 
    ## operationlize strata_1_raw
    mutate(strata_1_raw = str_remove(string = var_name_san, 
                                     pattern = var_name) %>% 
             recode("LM"="M",
                    "LF"="F")) %>% 
    # opertaionzalize `strata_1_name`
    add_count(var_name) %>% 
    mutate(strata_1_name = ifelse (n>1,'Sex','')) %>% 
    select(-n) %>% 
    # opertaionlize strata_1_value
    mutate(strata_1_value = case_when(
      strata_1_raw == "M" ~ "Male",
      strata_1_raw == "F" ~ "Female",
      strata_1_raw == ""&strata_1_name=="Sex" ~ "Overall",
      TRUE ~ ""
    )) %>% 
    ## operatainoalize strata_id
    mutate(strata_id = ifelse(
      strata_1_name=="","",paste(strata_1_name, strata_1_value, sep = "_")
    )  ) %>% 
    ## operatainoalize remianing columns
    mutate(strata_2_name = "",
           strata_2_raw = "",
           strata_2_value = "") %>% 
    ## select columns as per template
    select(names(template__strata))
  
}


# 3. Review and save  ----------------------------------------------------------------
{
  df_strata %>% fwrite(file = "2-strata.csv" )
  # df_strata %>% fwrite(paste0("../../datasets/",dataset_id_tmp,"/2-strata.csv"))
}

message(paste("Step 2 Done:",dataset_id_tmp))
