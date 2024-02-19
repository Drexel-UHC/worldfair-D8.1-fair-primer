
# 1. Evaluate raw data  ----------------------------------------------------------------
{
  glimpse(data_raw)
  
  #' a few things we need to do
  #'   1. make lowercase column names
  #'   2. variables are currently wide. need to pivot longer
  #'   3. sanitize variable names
  #'   4. oepratliaztions `geo` as L1AD
  #'   5. oepratliaztions `strata_id` as NA
  #'   5. select desiered variables
  
}

# 2. Code  ----------------------------------------------------------------
{
  df_data = data_raw %>% 
    # pivots 
    rename_all(tolower) %>%     
    pivot_longer(              
      cols = c(-iso2,-salid1,-year),
      names_to = 'var_name_raw') %>% 
    ## merges with step 1/2 xwalks
    left_join(df_var_name %>% select(var_name_raw, var_name)) %>% 
    left_join(df_strata %>% select(var_name, strata_id, strata_1_raw, strata_2_raw)) %>% 
    select(-strata_1_raw,-strata_2_raw) %>% 
    ## operationalize remaining columns
    mutate(
      var_name = sanitize_codebook_var(var_name_raw), ## step 3
      geo = "L1AD"     
    ) %>% 
    ## select columns as per template
    select(names(template__data)) ## step 5
}


# 3. Output  ----------------------------------------------------------------
{
   df_data %>% fwrite(file = get_uhc_file_path(dataset_id_tmp,"5-data.csv") )
}



message(paste("Step 5 Done:",dataset_id_tmp))
