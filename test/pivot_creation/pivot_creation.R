#!/usr/bin/Rscript

library(dplyr)
library(tidyr)
library(readr)
library(data.table)

BASE_GLOB = '.'

samples <- unique( sub( '^([^.]+)\\..*', '\\1',basename( Sys.glob(sprintf("%s/*.csv", BASE_GLOB)))))
#cat("cat(samples): \n")
#cat(samples)

for ( s in samples ) {
  write(sprintf("*** %s ***", s), stderr())
  for ( tf in Sys.glob(sprintf("%s/%s.csv", BASE_GLOB, s)) )  {
    write(sprintf("\t--> %s <--", tf), stderr())
    tkn <- (sprintf("%s",tf))
    t <- fread(tkn , sep = ',', stringsAsFactors = FALSE, header = FALSE, data.table = TRUE, fill = TRUE, col.names = c('genes','normalized_values')) %>% head(n = 100)
  }
}