#!/usr/bin/Rscript

#If you need functions from both plyr and dplyr, please load plyr first, then dplyr
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(purrr)) # For map()
suppressPackageStartupMessages(library(stringr)) # For str_remove()
suppressPackageStartupMessages(library(data.table))

#setting current directory as environmental variable
# This is a *constant*, not an environment variable
BASE_GLOB = '.'

# Read all data files into a long table
long <- tibble(fname = Sys.glob("*.csv")) %>%
  mutate(
    d = map(
      fname,
      function(f) read_csv(f, col_types = cols(gene = col_character(), normalized_value = col_double())) %>% mutate(sample = str_remove(f, '\\.csv'))
    )
  ) %>%
  unnest(d) %>%
  select(-fname)

# Make it wide: genes as rows, samples as columns
genes2samples <- long %>%
  pivot_wider(names_from = sample, values_from = normalized_value, values_fill = 0)

# Wide: samples as rows, genes as columns
samples2genes <- long %>%
  pivot_wider(names_from = gene, values_from = normalized_value, values_fill = 0)

# I don't know what you're doing below
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
