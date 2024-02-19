#' Step1.R will generate var_name.csv
#' 
#' manual: https://drexel-uhc.github.io/salurbal-project-dashboard/pages/manuals/step1.html
#' 
#' We want to look at the raw data and generate a table containing 
#'   - var_name
#'   - var_name_raw
#'   - dataset_id 

# 1. Evaluate raw data  ----------------------------------------------------------------
{
  glimpse(data_raw)
  
  ## Evaluation
  ##' it looks like we have four variables organized wide. No strata. 
  ##' pretty easy, lets just pivot
}

# 2. Code  ----------------------------------------------------------------
{
  # 1. select only variable names
  vec__var_name_raw = data_raw %>% 
    select(-ISO2, -SALID1, - YEAR) %>% 
    names()
  
  # 2. put those in a table as var_name_raw
  df_var_name = tibble(var_name_raw = vec__var_name_raw ) %>%
    mutate(
      var_name = sanitize_codebook_var(var_name_raw), 
      dataset_id = dataset_id_tmp 
      ) %>% 
    ## select columns as per template
    select(names(template__var_name))
  
}


# 3. Review and save  ----------------------------------------------------------------
{
  ## examine
  df_var_name
  
  
  ## save   
  df_var_name %>% fwrite("1-var_name.csv")
  df_var_name %>% fwrite(paste0("../../datasets/",dataset_id_tmp,"/1-var_name.csv"))
}

message(paste("Step 1 Done:",dataset_id_tmp))
