
# 1. Evaluate raw data  ----------------------------------------------------------------
{
  glimpse(data_raw)
   
  #' columns in data.csv
  #'   - [x] "var_name"  
  #'   - [x] "iso2"      
  #'   - [x] "strata_id" 
  #'   - [x] "geo"  
  #'   - [x] "salid1"    
  #'   - [x] "year"      
  #'   - [x] "value"  
  #' 
  #'  ## Recipe ##
  #'  1. rename columns to those in data.csv or strata.csv 
  #'  2.opertaionlize `var_name`
  #'  3. merge with df_strata to operationalize strata_id + remove strata_detail columns
  #'  4. opertaionlize `iso2`
  #'  5. operationzlie `geo`
  #'  6. Need to operationalize `YEAR` (TBD need to merge with codebook!)
  #'  7. Select variables in template
  #'  
  #'  
  
  
  #' we nee to prep table for year of data as its not in data but in Codebook_LifeExpectancy_20200916.docx
  xwalk_data_year = tribble(
    ~iso2, ~year_raw,  ~ year,
    "AR", "2012-2016", 2014,
    "BR", "2012-2016", 2014,
    "CL", "2012-2016", 2014,
    "CO", "2012-2016", 2014,
    "CR", "2012-2016", 2014,
    "GT", "2012-2016", 2014,
    "MX", "2012-2016", 2014,
    "NI", NA         , NA  ,
    "PA", "2012-2016", 2014,
    "PE", "2012-2016", 2014,
    "SV", "2010-2014", 2012
  )
}

# 2. Code  ----------------------------------------------------------------
{
  df_data = data_raw %>% 
    ## var_name + rename columns
    mutate(var_name = "LEALE",
           var_name_raw =  "LEALE") %>% 
    rename(salid1 = SALID1,
           strata_1_raw = LEMALE,
           strata_2_raw = LEAGE,
           value = LEALE) %>% 
    ## merges with step df_strata
    left_join(df_strata %>% select(var_name, strata_id, strata_1_raw, strata_2_raw)) %>% 
    select(-strata_1_raw,-strata_2_raw) %>% 
    ## operationalize remaining columns
    mutate(salid0 = str_sub(salid1, 1,3)) %>% 
    left_join(xwalk_iso2) %>% 
    mutate(geo = 'L1AD') %>% 
    left_join(xwalk_data_year, by = "iso2") %>%  
    select(names(template__data), year_raw)
}


# 3. Output  ----------------------------------------------------------------
{
  df_data %>% fwrite(file = get_uhc_file_path(dataset_id_tmp,"5-data.csv") )
}



message(paste("Step 5 Done:",dataset_id_tmp))