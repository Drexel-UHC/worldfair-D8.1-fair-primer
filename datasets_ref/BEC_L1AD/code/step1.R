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
  
  #' Looking at the data I don't really see any stratified variables (sex, age or population)
  #' one noticabile thing is that year is wide. so we will need to pivot that to wide and remove it
  #' from the raw var_name.
  
}

# 2. Code  ----------------------------------------------------------------
{
  vec__var_name_raw = data_raw %>% 
    select(-ISO2, -SALID0, -SALID1) %>% 
    names() %>% 
    str_to_lower()
   
  df_var_name = tibble(var_name_raw = vec__var_name_raw) %>% 
    mutate(var_name = sanitize_codebook_var(var_name_raw)) %>% 
    arrange(var_name) %>% 
    ## operationalize year from var_name_raw 
    mutate(year_extract = str_extract(var_name_raw, '[0-9]{4}') %>% as.numeric()) %>% 
    mutate( year = case_when(
      between(year_extract,1960,2040) ~ year_extract,
      TRUE ~ 9999)) %>% 
    ## operatinoalize dataset_id 
    mutate(dataset_id = dataset_id_tmp) %>% 
    ## subset as per template
    select(c(names(template__var_name),'year'))  
    
     
}


# 3. Review and save  ----------------------------------------------------------------
{
  ## examine
  df_var_name %>% 
    add_count(var_name)
  
  
  ## save   
  df_var_name %>% fwrite("1-var_name.csv")
  df_var_name %>% fwrite(paste0("../../datasets/",dataset_id_tmp,"/1-var_name.csv"))
}

message(paste("Step 1 Done:",dataset_id_tmp))
