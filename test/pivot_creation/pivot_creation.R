#!/usr/bin/Rscript

library(dplyr)
library(tidyr)
library(readr)
library(data.table)

#setting current directory as environmental variable (useless for this script version)
BASE_GLOB = '.'

#Extracting sample names out of file names (useless for this script version)
samples <- unique( sub( '^([^.]+)\\..*', '\\1',basename( Sys.glob(sprintf("%s/*.csv", BASE_GLOB)))))
#uncomment the following if you want to check samples:
#cat("cat(samples): \n")


# I don't know how to recursively import csv files and save each into a separate object as part of a for loop
# So I load them manually
# maybe using map()? how?
csv_import <- function (x) {
  fread(x , sep = ',', stringsAsFactors = FALSE, header = TRUE, data.table = TRUE, fill = TRUE )
} 
CER1 <- csv_import("./CER1.csv") %>% add_column (sample = "CER1")
PHA1 <- csv_import("./PHA1.csv") %>% add_column (sample = "PHA1")
PET1 <- csv_import("./PET1.csv") %>% add_column (sample = "PET1")
H2O1 <- csv_import("./H2O1.csv") %>% add_column (sample = "H2O1")

#I don't know how to join tables together in a recursive way
#So I do it manually
#maybe using map()? how?
pivot <- CER1 %>%
  # Join the two columns with union()
  # union() combines all rows from both the tables and **removes duplicate records** from the combined dataset
  # union_all() combines all rows from both the tables **without** removing the duplicate records from the combined dataset
  union_all(PHA1) %>% union_all(H2O1) %>% union_all(PET1) %>%
  pivot_wider(
    names_from = sample,
    values_from = normalized_value,
    values_fill = list (normalized_count = 0)
  )

#Scrapped ideas for recursive file import and save into different objects:

#filenames <- list.files( path = sprintf("%s", BASE_GLOB), pattern="*.csv", full.names=TRUE)

#lapply(filenames, function(x) {read.table(x,header=TRUE,sep=",")})

#for s in samples {
#   write(sprintf("*** %s ***", s), stderr())
#   write(sprintf("\t-->importing %s.csv<--", s), stderr())
#   ??? <- csv_import(sprintf("%s%s.csv",BASE_GLOB, s))}
#   for ( tf in Sys.glob(sprintf("%s/%s.csv", BASE_GLOB, s)) )  {
#     add_column (sample = sprintf("%s", tf)) #  Error in if (nrow(df) != nrow(.data)) { : argument is of length zero
#     tkn <- (sprintf("%s",tf))
#     r <- fread(tkn , sep = ',', stringsAsFactors = FALSE, header = FALSE, data.table = TRUE, fill = TRUE, col.names = c('genes','normalized_values')) }
