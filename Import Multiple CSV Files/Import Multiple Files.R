#Import Multiple CSV files and place into a table

# 1.0 LIBRARIES ----

library(tidyverse)
library(fs)

# 2.0 IMPORT DATA INTO SINGULAR DATASET ----
file_paths <- "Import Multiple CSV Files /data/"
car_data_list <- file_paths %>%
    dir_ls() %>%
    map(
        .f = function(path) {
            read_csv(
                path,
                col_types = cols(
                    manufacturer = col_character(),
                    model = col_character(),
                    displ = col_double(),
                    year = col_double(),
                    cyl = col_double(),
                    trans = col_character(),
                    drv = col_character(),
                    cty = col_double(),
                    hwy = col_double(),
                    fl = col_character(),
                    class = col_character()
                )
            )
        }
    )

# 3.0 BINDING DATA FRAMES ----

car_data_tbl <- car_data_list %>%
    set_names(dir_ls(file_paths)) %>%
    bind_rows(.id = "file_path")

car_data_tbl
