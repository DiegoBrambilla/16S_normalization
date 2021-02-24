#!/usr/bin/Rscript

#Loading libraries quietly
#If you need functions from both plyr and dplyr, please load plyr first, then dplyr
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(purrr)) # For map()
suppressPackageStartupMessages(library(stringr)) # For str_remove()
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(openxlsx)) # For writing to .xlsx file

#setting current directory as constant
BASE_GLOB = '.'

# Loads default BLOSUM62 alignment table (from BLAST, LAST, DIAMOND, etc.)
# Reads all .m8 blast/diamond output into a long table
long <- tibble(fname = Sys.glob("*.m8")) %>%
  mutate(
    d = map(
      fname,
      function(f) read_tsv(f, col_names = c(
        "contig_ID", "db_descriptor", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", 
        "evalue", "bitscore", "qcovhsp"
      ), col_types = cols(.default = col_double(), read_ID = col_character(), db_descriptor = col_character())
      ) %>%
        mutate(sample = str_remove(f, '\\.cdhit\\.argdb\\.m8'))
    )
  ) %>%
  unnest(d) %>%
  select(-fname) %>%
  separate(db_descriptor, c("db_ID", "features", "db", "phenotype", "ARG"), sep = "\\|", fill = 'right', extra = 'drop') %>%
  filter(length >= 70)%>%
  select(sample, read_ID, ARG) %>%
  # Count the number of rows for combinations of sample, read_ID and ARG. This introduces a new column: n.
  count(sample, contig_ID, ARG) %>%
  group_by(sample) %>%
  mutate(relab = n/sum(n) * 100) %>%
  ungroup() %>%
# Make it wide: genes as rows, samples as columns
  pivot_wider(
    names_from = sample,
    values_from = relab,
    values_fill = 0
  ) %>%
  write.xlsx('prova.xlsx')
