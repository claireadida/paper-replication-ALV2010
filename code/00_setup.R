# code/00_setup.R

load_pkg <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg, dependencies = TRUE)
  suppressPackageStartupMessages(library(pkg, character.only = TRUE))
}

pkgs <- c(
  "here","haven","dplyr","tidyr","stringr","stringi",
  "sandwich","lmtest","MASS","broom","ordinal",
  "ggplot2","gridExtra","grid","tools","purrr","tibble"
)
invisible(lapply(pkgs, load_pkg))

# Directories
dir_data_raw <- here::here("data", "raw")
dir_results  <- here::here("results")
dir_tables   <- file.path(dir_results, "tables")
dir_figures  <- file.path(dir_results, "figures")

dir.create(file.path(dir_tables, "cv"), recursive = TRUE, showWarnings = FALSE)
dir.create(file.path(dir_tables, "sv"), recursive = TRUE, showWarnings = FALSE)
dir.create(dir_figures, recursive = TRUE, showWarnings = FALSE)

# Check required data
required_files <- c("OriginalData.dta", "NewAdidaCoding.dta", "SurveyData.dta")
missing <- required_files[!file.exists(file.path(dir_data_raw, required_files))]
if (length(missing) > 0) stop("Missing in data/raw/: ", paste(missing, collapse=", "))

# Load data
original_data <- haven::read_dta(file.path(dir_data_raw, "OriginalData.dta"), encoding = "latin1")
newcoding     <- haven::read_dta(file.path(dir_data_raw, "NewAdidaCoding.dta"), encoding = "latin1")
survey_data   <- haven::read_dta(file.path(dir_data_raw, "SurveyData.dta"), encoding = "latin1")

# Output collectors (globals)
cv_out <- list()
sv_out <- list()

##Creating output pathaways: 


# Save a data frame as one or more PNG pages
save_table_image_pages <- function(df, filename_stub, title,
                                   out_dir = "tables",
                                   rows_per_page = 30,
                                   width = 2000, height = 1400, res = 200,
                                   digits = 4) {
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  
  # Coerce to data.frame 
  df2 <- as.data.frame(df)
  
  # Round numeric columns 
  df2 <- df2 %>%
    mutate(across(where(is.numeric), ~ round(.x, digits)))
  
  # Split into pages
  n <- nrow(df2)
  n_pages <- ceiling(n / rows_per_page)
  
  out_files <- character(0)
  
  for (p in seq_len(n_pages)) {
    idx_start <- (p - 1) * rows_per_page + 1
    idx_end   <- min(p * rows_per_page, n)
    df_page   <- df2[idx_start:idx_end, , drop = FALSE]
    
    fn <- file.path(out_dir, paste0(filename_stub, "_p", p, ".png"))
    out_files <- c(out_files, fn)
    
    png(fn, width = width, height = height, res = res)
    grid::grid.newpage()
    
    page_title <- if (n_pages > 1) {
      paste0(title, " (page ", p, " of ", n_pages, ")")
    } else title
    
    grid::grid.text(page_title, x = 0.02, y = 0.97, just = "left",
                    gp = grid::gpar(fontsize = 16, fontface = "bold"))
    
    # Table
    gridExtra::grid.table(df_page, rows = NULL)
    dev.off()
  }
  
  invisible(out_files)
}

##Helper: save everything inside a list (cv_out / sv_out)

save_all_tables_from_list <- function(out_list, prefix,
                                      base_dir = "tables",
                                      rows_per_page = 30,
                                      width = 2000, height = 1400, res = 200,
                                      digits = 4) {
  
  out_dir <- file.path(base_dir, prefix)
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  
  # Save an index 
  index <- tibble::tibble(
    object_name = names(out_list),
    n_rows = purrr::map_int(out_list, ~ nrow(as.data.frame(.x))),
    n_cols = purrr::map_int(out_list, ~ ncol(as.data.frame(.x)))
  )
  
  # Write index image too
  save_table_image_pages(
    df = index,
    filename_stub = paste0(prefix, "_INDEX"),
    title = paste0(toupper(prefix), " output index"),
    out_dir = out_dir,
    rows_per_page = rows_per_page,
    width = width, height = height, res = res,
    digits = 0
  )
  
  # Save each element
  for (nm in names(out_list)) {
    df <- out_list[[nm]]
    
    # Make filename
    safe_nm <- gsub("[^A-Za-z0-9_\\-]+", "_", nm)
    
    save_table_image_pages(
      df = df,
      filename_stub = safe_nm,
      title = paste0(prefix, ": ", nm),
      out_dir = out_dir,
      rows_per_page = rows_per_page,
      width = width, height = height, res = res,
      digits = digits
    )
  }
  
  invisible(TRUE)
}
