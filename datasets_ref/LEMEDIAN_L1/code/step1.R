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
  
  #' ## Evaluation ##
  #'   - one one variable `LEALE`
  #'   - two strata of data: `LEMALE` and `LEAGE`
  #'   - the data is organized long with value in the `LE` 
  #' 
  #' ## Recipe ##
  #'   1. pull the single variable 
  #'   2. operationalize var_name
  #'   3. assign dataset_id
  
}

# 2. Code  ----------------------------------------------------------------
{
  # 1. select only variable names
  var_name_raw = data_raw %>% 
    select(LEALE) %>% 
    names()
  
  # 2. put those in a table as var_name_raw
  df_var_name = tibble(var_name_raw = var_name_raw ) %>%  # step 2
    mutate(
      var_name = sanitize_codebook_var(var_name_raw), # 3. clean them as per manual and store then as var_name
      dataset_id = dataset_id_tmp # 4. Assign dataset_id
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
