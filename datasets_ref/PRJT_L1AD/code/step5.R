
# 1. Evaluate raw data  ----------------------------------------------------------------
{
  glimpse(data_raw)
  
  names(template__data)
   
  #' just need to pivot variables longer then add metadata as needed
  
}

# 2. Code  ----------------------------------------------------------------
{
  df_data = data_raw %>% 
    ## operationalize var_name + var_name_raw
    pivot_longer(-c(ISO2, SALID1, YEAR), 
                 names_to = "var_name_raw") %>% 
    left_join(df_var_name, by = 'var_name_raw') %>% 
    ## operationalize: iso2, year, salid1
    rename_all(tolower) %>% 
    ## operationalize geo, strata_id
    left_join(df_strata) %>% 
    mutate(geo = "L1AD") %>% 
    arrange(var_name_raw, year, salid1) %>% 
    ## select columns as per template
    select(names(template__data))
}


# 3. Output  ----------------------------------------------------------------
{
  df_data %>% fwrite(file = get_uhc_file_path(dataset_id_tmp,"5-data.csv") )
}



message(paste("Step 5 Done:",dataset_id_tmp))