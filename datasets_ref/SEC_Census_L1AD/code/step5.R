
# 1. Evaluate raw data  ----------------------------------------------------------------
{
  glimpse(data_raw)
  
  names(template__data)
  
  #' a few things we need to do
  #'   1. make lowercase column names
  #'   2. variables are currently wide. need to pivot longer
  #'   3. sanitize variable names
  #'   4. oepratliaztions `geo` as L1AD
  #'   5. select desiered variables
  
}

# 2. Code  ----------------------------------------------------------------
{
  df_data = data_raw %>% 
    ## pivots
    pivot_longer(
      cols = c(-ISO2,-YEAR,-SALID1),
      names_to = "var_name_raw") %>% 
    ## merges with step 1/2 tables
    left_join(df_var_name %>% select(var_name_raw, var_name)) %>% 
    left_join(df_strata %>% select(var_name_raw, var_name,strata_id)) %>% 
    ## operationalize remaining columns
    mutate(geo = "L1AD") %>% 
    rename_all(tolower) %>% 
    arrange(var_name, salid1, year) %>% 
    ## select as per template
    select(names(template__data)) 
}


# 3. Output  ----------------------------------------------------------------
{
  df_data %>% fwrite(file = get_uhc_file_path(dataset_id_tmp,"5-data.csv") )
}



message(paste("Step 5 Done:",dataset_id_tmp))