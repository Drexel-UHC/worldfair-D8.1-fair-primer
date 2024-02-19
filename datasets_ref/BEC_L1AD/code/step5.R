#' For data.csv we want a table with the following columns
#'    - var_name
#'    - var_name_raw
#'    - iso2
#'    - strata_id
#'    - geo
#'    - salid1
#'    - year
#'    - value
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
    rename_all(tolower) %>%
    mutate_all(~as.character(.x)) %>% 
    ## operationalize var_name + year with df_var_name
    pivot_longer(c(-iso2, -salid0, -salid1),
                 names_to = 'var_name_raw') %>% 
    filter(!is.na(value)) %>% 
    left_join(df_var_name) %>% 
    arrange(var_name) %>% 
    ## operationalize geo
    mutate(geo = "L1AD") %>% 
    ## operationalize strata_id
    left_join(df_strata) %>% 
    ## final selection as per template
    select(names(template__data))
}


# 3. Output  ----------------------------------------------------------------
{
  df_data %>% fwrite(file = get_uhc_file_path(dataset_id_tmp,"5-data.csv") )
}



message(paste("Step 5 Done:",dataset_id_tmp))