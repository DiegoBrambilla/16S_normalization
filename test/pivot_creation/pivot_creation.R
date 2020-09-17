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



filenames <- list.files(path=sprintf("%s", BASE_GLOB), pattern="*.csv", full.names=TRUE, recursive=FALSE)
samples <- unique( sub( '^([^.]+)\\..*', '\\1',basename( Sys.glob(sprintf("%s/*.csv", BASE_GLOB)))))

for (i in filenames) {
  for (s in samples) {
      t <- csv_import(i) %>% add_column(sample = s)
    print(t)
  }
}








#check running time:
#system.time()


#Scrapped ideas for recursive file import and save into different objects:

#fn <- function(filenames) {
#  out <- matrix(ncol = length(filenames), nrow = seq_along(filenames))
  
#  for (f in seq_along(filenames)) {
#    fdata <- read.table(filenames[f],header=TRUE,sep=",")
#    out[, f] <- map(fdata, add_column (sample = )
#                    return(out)
#  }
#}


#for (file in filenames) {
#  for (sample in samples) {
#    for (i in seq_along(samples)) {
#      x <- sample[i]
#      y <- sample[i+1]
#      v <- map2(x,y, function(x,y){t <- union(x,y)})
#    }
#  }
#  print(v)
#}

#files <- list.files( path = sprintf("%s/*.csv", BASE_GLOB), pattern, full.names=TRUE)

#for (f in seq_along(filenames)) {
#  fdata <- read.csv(filenames[f], header = FALSE)
#  out[, f] <- map(fdata, function(x){add_column(x, sample = basename( Sys.glob(sprintf("%s/*.csv", BASE_GLOB) ) ) )})
#}
#return(out)
#}

#Use: pivot_all("*.csv") if in same directory of .csv files
#pivot_all <- function(folder = sprintf("%s", BASE_GLOB), pattern) {
#list.files is a function that finds files whose names match a pattern
#we also need to include the “path” portion of the file name. We can do that by using the argument full.names = TRUE
#files <- list.files( path = folder, pattern, full.names=TRUE)
#map (files, function(x) {
#  t <- read.table(x, header=TRUE,sep=",") # load file
  # apply function
#  out <- add_column(t , sample = basename( Sys.glob(sprintf("%s/*.csv", BASE_GLOB) ) ) )
  # write to file
#  write.table(out, "path/to/output", sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
#}

#for s in samples {
#   write(sprintf("*** %s ***", s), stderr())
#   write(sprintf("\t-->importing %s.csv<--", s), stderr())
#   ??? <- csv_import(sprintf("%s%s.csv",BASE_GLOB, s))}
#   for ( tf in Sys.glob(sprintf("%s/%s.csv", BASE_GLOB, s)) )  {
#     add_column (sample = sprintf("%s", tf)) #  Error in if (nrow(df) != nrow(.data)) { : argument is of length zero
#     tkn <- (sprintf("%s",tf))
#     r <- fread(tkn , sep = ',', stringsAsFactors = FALSE, header = FALSE, data.table = TRUE, fill = TRUE, col.names = c('genes','normalized_values')) }
