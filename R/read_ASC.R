library(readr)

var_names <- c(
  "database",
  "year",
  "table",
  "var_num",
  "var_name",
  "start_pos",
  "end_pos",
  "num_digits",
  "var_type",
  "var_label"
)

read_file_spec <- function(working_file, 
                           column_names = var_names
                           ) {
  columns_position <- read_fwf(working_file, skip = 8, n_max = 10,
                              col_positions = 
                                 fwf_positions(start = c(1,4,11),
                                               end   = c(2,6,NA)))  %>% 
                      mutate(X1 = if_else(is.na(X1), X2, X1))
  
  read_fwf(working_file, 
           col_positions = 
             fwf_positions(start = columns_position$X1,
                           end = columns_position$X2,
                           col_names = column_names),
           skip = 20)
}

read_asc <- function(file, file_layout, ...){
  pos_layout <- read_file_spec(file_layout)
  read_fwf(file, 
           col_positions = 
             fwf_positions(start = pos_layout$start_pos,
                           end   = pos_layout$end_pos,
                           col_names = pos_layout$var_name),
           ...)
}


