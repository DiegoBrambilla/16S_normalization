#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)

if length(args) < 1 {
  stop("Usage: pivot_creation.r <relab16S.csv> ...")
}

suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(optparse))

OUT="pivot_table.tsv"

# Get arguments
option_list = list(
  make_option(
  c('--outdir'), type='character', default='.',
  help='Output directory, default is working directory.'
  ),
  make_option(
    c("-f","--filelist"),default=FALSE,
    help="comma separated list of files (default %default)"
    ),
  make_option(
    c('--tblmark'), type='character', default='.csv',
    help="Name pattern to identify input file names, default= %default"
  ),
  make_option(
    c('--prefix'), type='character', default='pivot',
    help='Prefix for output files, default %default.'
  ),  
  make_option(
    c("-v", "--verbose"), action="store_true", default=FALSE, 
    help="Print progress messages"
  ),
)

opt = parse_args(OptionParser(option_list=option_list), positional_arguments=TRUE)

logmsg = function(msg, llevel='INFO') {
  if ( opt$verbose ) {
    write(
      sprintf("%s: %s: %s", llevel, format(Sys.time(), "%Y-%m-%d %H:%M:%S"), msg),
      stderr()
    )
  }
}

tables = Sys.glob(sprintf("%s/*.csv", opt$outdir))


tbl = tables[grep(opt$tblmark, tables, fixed=T)]

samples = sub(sprintf("%s.*", opt$tblmark), "", basename(tbl))

names(tbl) = samples

# Check if file import and options have been correctly set
options <- opt$options
args <- opt$args

myfilelist <- strsplit(options$filelist, "[,:]")

print (myfilelist)
print(samples)
print (args)

# Trying to merge files in a single pivot
mergers = vector('list', length(samples))
names(mergers) = samples
for ( s in samples ) {
  logmsg(sprintf("--> merging %s <--", s))
  smptbl = add_column (tbl[[s]], sample = tbl[[s]] ) %>%
    