
rm(list = ls())

library(tidyverse)
library(readxl)

cell_ids <- read_excel("input_data/cell_gis_dat_filter_ag_gldas.xlsx")$cell_id

# first_cell_i <- 5401 # one indexed
n_cells <- 1800

for (first_cell_i in seq(1, length(cell_ids), by = n_cells)) {
  file_txt <- c()
  
  for (cell_no in 1:n_cells) {
    cell_id <- cell_ids[first_cell_i + cell_no - 1]
    if (is.na(cell_id)) break
    file_txt <- c(file_txt, 
                  paste('Rscript rothc_by_cell.R ', cell_id, 
                        ' "ccsm4" "$INDATAPATH/cell_gis_dat_filter_ag.xlsx" "$INDATAPATH/ccsm4_1950-2099_by_cell/" "$INDATAPATH/rothc_lm_in_dat.xlsx" "/glade/scratch/swiltshire/"', sep = ""))
    
  }
  
  write(file_txt, paste("command_files/command_file_", length(file_txt), '_cells_', first_cell_i, '-', min(first_cell_i + n_cells - 1, length(cell_ids)), sep = ""))
}