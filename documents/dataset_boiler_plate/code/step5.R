
# 1. Evaluate raw data  ----------------------------------------------------------------
{
  glimpse(data_raw)
  
  #' a few things we need to do
  #'   1. make lowercase column names
  #'   2. variables are currently wide. need to pivot longer
  #'   3. sanitize variable names
  #'   4. oepratliaztions `geo` as L1AD
  #'   5. select desiered variables
  
}

# 2. Code  ----------------------------------------------------------------
{
  data = data_raw %>% 
    rename_all(tolower) %>%     # step 1
    pivot_longer(               # step 2
      cols = c(-iso2,-salid1,-year),
      names_to = 'var_name_raw') %>% 
    mutate(
      var_name = sanitize_codebook_var(var_name_raw), ## step 3
      geo = "L1AD"                                   ## step 4
    ) %>% 
    select(names(data_template)) ## step 5
}


# 3. Output  ----------------------------------------------------------------
{
  data %>% 
    fwrite(file = get_uhc_file_path(dataset_id,"data.csv") )
}



message(paste("Step 5 Done:",dataset_id))