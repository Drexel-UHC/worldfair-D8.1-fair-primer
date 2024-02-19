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
  
  tibble(vars = names(data_raw)) 
  
  #' Looking at the data I see a few potential strata. which are listed below.
  #'   - CNSUNEMPL1AD
  #'     CNSUNEMPL_M_L1AD
  #'     CNSUNEMPL_F_L1AD
  #'   - CNSLABPARTL1AD 
  #'     CNSLABPART_F_L1AD 
  #'     CNSLABPART_M_L1AD
  #'   - CNSST1517L1AD
  #'     CNSST1517ML1AD
  #'     CNSST1517FL1AD
  #'     CNSST1517RATL1AD
  #'   - CNSMINPR_L1AD
  #'     CNSMINPRM_L1AD
  #'     CNSMINPRF_L1AD
  #'   - CNSMINHS_L1AD    
  #'     CNSMINHSM_L1AD
  #'     CNSMINHSF_L1AD
  #'   - CNSMINUN_L1AD
  #'     CNSMINUNM_L1AD
  #'     CNSMINUNF_L1AD
  #'     CNSHSEDRATL1AD
  #' its really messy. there isn't a standard for specifying sex in the variable name; some are
  #' seperated by underdashes (e.g. `_M_` or `_F_`) and some oare not. Also there are some `RAT`
  #' ratios. we'll lets split them based on this initial evaluation and see what happens.  
  #' 
  #' 
  #' 
  #' ## Recipe ##
  #'   1. select only variable names
  #'   2. put those in a table as var_name_raw
  #'   3. create intermediate column `var_name_san` using our general cleaner function
  #'   4. operationzlie `var_name` from `special_var_names` via imputation
  #'   5. check imputation manually
  #'   6. operationalize `dataset_id`
  
}

# 2. Code  ----------------------------------------------------------------
# Impute var_name for messy SEC var_name_raw
#' NOTE @Diana. this is probably easier to do manually so its your call to do this
#' programmatically as shown below or manually. 
{
  ## Inialize intermediate table
  var_name_raw = data_raw %>% 
    select(-ISO2, -SALID1, -YEAR) %>% 
    names()
  df_intermediate = tibble(var_name_raw = var_name_raw ) %>%  
    mutate(var_name_san = sanitize_codebook_var(var_name_raw) )
  
  ## Impute var name
  df_var_name_imputed =  df_intermediate %>% 
    impute_var_name()

  ## Check imputation
  #' seems like all sex. Ratios and proportions are appropriated their own var_name
  df_var_name_imputed %>%  filter(imputation == 1)
  df_var_name_imputed %>%  filter(imputation == 0)
  
  # step 6
  df_var_name = df_var_name_imputed %>% 
    select(-imputation) %>% 
    mutate(dataset_id = dataset_id_tmp ) %>% 
    ## select as per tempalte
    select(c(names(template__var_name),"var_name_san"))
}


# 3. Review and save  ----------------------------------------------------------------
{
  ## examine
  df_var_name %>%    add_count(var_name)
  
  
  ## save   
  df_var_name %>% fwrite("1_var_name.csv")
  # df_var_name %>% fwrite(paste0("../../datasets/",dataset_id_tmp,"/1-var_name.csv"))
}

message(paste("Step 1 Done:",dataset_id_tmp))
