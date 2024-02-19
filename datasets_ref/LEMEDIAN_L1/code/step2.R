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
  #'   - one one variable `LEALE`
  #'   - two strata of data: `LEMALE` and `LEAGE`
  #'   - the data is organized long with value in the `LE` 
  
  data_raw %>% count(LEMALE)
  data_raw %>% count(LEAGE)
}

# 1.2 action plan  -----------------------------------------------------------
{
  # [1] "var_name"       "strata_1_name" 
  # [3] "strata_1_raw"   "strata_1_value"
  # [5] "strata_2_name"  "strata_2_raw"  
  # [7] "strata_2_value"
  #' Our goal is to have strata wide. So currenlty its fine since `LEMALE` and `LEAGE` are wide.
  #' We will just rename as strat_n_raw and
  
  #' ## Recipe ##
  #'   1. operationalize var_name
  #'   2. rename LEMALE and LEAGE as `strata_n_raw`
  #'   3. fill in `strata_n_name`
  #'   4. recode `strata_n_value`
  #'   5. operatinoalize `strata_id`
  #'   6. select columns in template
  #'   7. make sure rows are unique/distinct
}

# 2. Code  ----------------------------------------------------------------
{
  df_strata =  data_raw %>% 
    select(    
      strata_1_raw = LEMALE,  
      strata_2_raw = LEAGE)  %>%    
    distinct() %>% 
    mutate(strata_1_name = "Sex",
           strata_2_name = "Age") %>%   
    mutate(strata_1_value = strata_1_raw %>% recode("1"="Male",
                                                    "0"="Female"),
           strata_2_value = strata_2_raw) %>%  
    mutate(strata_id = paste(strata_1_name, strata_1_value, strata_2_name, strata_2_value,sep ="_")) %>% 
    # oeprationalize var_name
    mutate( var_name = df_var_name$var_name,
            var_name_raw = df_var_name$var_name_raw) %>% 
    ## select columns as per template
    select(names(template__strata)) 
}


# 3. Review and save  ----------------------------------------------------------------
{
  df_strata %>% fwrite(file ="2-strata.csv")
  df_strata %>% fwrite(paste0("../../datasets/",dataset_id_tmp,"/2-strata.csv"))
}

message(paste("Step 2 Done:",dataset_id_tmp))
