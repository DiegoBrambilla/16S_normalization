#!/usr/bin/Rscript

#If you need functions from both plyr and dplyr, please load plyr first, then dplyr
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(purrr)) # For map()
suppressPackageStartupMessages(library(stringr)) # For str_remove()
suppressPackageStartupMessages(library(data.table))

#setting current directory as constant
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
#samples2genes <- long %>%
#  pivot_wider(names_from = gene, values_from = normalized_value, values_fill = 0)
