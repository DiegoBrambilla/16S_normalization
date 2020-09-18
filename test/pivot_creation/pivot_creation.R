#!/usr/bin/Rscript

#If you need functions from both plyr and dplyr, please load plyr first, then dplyr
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(data.table))

#setting current directory as environmental variable
BASE_GLOB = '.'

# I don't know how to recursively import csv files and save each into a separate object as part of a for loop
# So I load them manually
# maybe using map()? how?

csv_import <- function(x) {
  fread( x,
        sep = ',',
        stringsAsFactors = FALSE,
        header = TRUE,
        data.table = TRUE,
        fill = TRUE
  )
}

write("***importing CER1.csv + adding sample column with CER1 as values***", stderr())
CER1 <- csv_import("./CER1.csv") %>% add_column (sample = "CER1")
write("***importing PHA1.csv + adding sample column with PHA1 as values***", stderr())
PHA1 <- csv_import("./PHA1.csv") %>% add_column (sample = "PHA1")
write("***importing PET1.csv + adding sample column with CER1 as values***", stderr())
PET1 <- csv_import("./PET1.csv") %>% add_column (sample = "PET1")
write("***importing H2O1.csv + adding sample column with CER1 as values***", stderr())
H2O1 <- csv_import("./H2O1.csv") %>% add_column (sample = "H2O1")


#I don't know how to join tables together in a recursive way
#So I do it manually
#maybe using map()? how?

pivot2 <- CER1 %>%
  # Join the two columns with union()
  # union() combines all rows from both the tables and **removes duplicate records** from the combined dataset
  # union_all() combines all rows from both the tables **without** removing the duplicate records from the combined dataset
  union_all(H2O1) %>% union_all(PET1) %>% union_all(PHA1) %>% 
  pivot_wider(
    names_from = sample,
    values_from = normalized_value,
    values_fill = list (normalized_count = 0)
  )
write("***reshaping into pivot/mother table, done***", stderr())


filenames <- list.files(path=sprintf("%s", BASE_GLOB), pattern="*.csv", full.names=TRUE, recursive=FALSE)
samplenames <- unique( sub( '^([^.]+)\\..*', '\\1',basename( Sys.glob(sprintf("%s/*.csv", BASE_GLOB)))))
csv_import_n_add_sample_column <- function (input, samples) {
  write(sprintf("***importing %s.csv and adding sample column with %s as values ***", input, samples), stderr())
  data <- fread(
    input ,
    sep = ',',
    stringsAsFactors = FALSE,
    header = TRUE,
    data.table = TRUE,
    fill = TRUE
    ) %>%
  add_column (sample = samples)
} 

table.list <- map2(filenames,samplenames,csv_import_n_add_sample_column)
write("***merging all .csv into the same long table***", stderr())
# I had to load plyr here otherwise it would have been masked by dplyr
# There must be a smarter way to handle it, right?
suppressPackageStartupMessages(library(plyr))
pivot<- ldply(
  table.list,
  function(x) rbind(x, fill = TRUE)
) %>%
pivot_wider(
  names_from = sample,
  values_from = normalized_value,
  values_fill = list (normalized_count = 0)
)
write("***reshaping into pivot/mother table, done***", stderr())

write("***are the two output identical?***", stderr())
write(identical(pivot2,pivot), stderr())


#check running time:
#system.time()
