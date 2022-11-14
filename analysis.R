setwd("/Users/romanov/Dropbox/_EIS1600_Working/github_repositories_data/CAMeLizer/")
print(getwd())

library(tidyverse)

fromFolder <- "./results_raw/"
toFolder   <- "./results_final/"


file <- "all_results.tsv"
files <- list.files(fromFolder, pattern = "*.tsv")

library(readr)

for (f in files){
  results <- read_delim(paste0(fromFolder, f), delim = "\t", escape_double = FALSE, trim_ws = TRUE)
  
  tokens <- results %>%
    count(TOKEN) %>%
    arrange(desc(n)) %>%
    rename(FREQ = n) %>%
    filter(!stringr::str_detect(TOKEN, "[\\W\\dA-Za-z]+"))
  write_delim(tokens, paste0(toFolder, f, "_TOKENS.tsv"), delim = "\t")
  
  lemma <- results %>%
    count(LEMMA) %>%
    arrange(desc(n)) %>%
    rename(FREQ = n) %>%
    filter(!stringr::str_detect(LEMMA, "[\\W\\dA-Za-z]+"))
  write_delim(lemma, paste0(toFolder, f, "_LEMMAS.tsv"), delim = "\t")
  
}


# results <- read_delim("all_results.tsv", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
# 
# tokens <- results %>%
#   count(TOKEN) %>%
#   arrange(desc(n)) %>%
#   rename(FREQ = n) %>%
#   filter(!stringr::str_detect(TOKEN, "[\\W\\dA-Za-z]+"))
# write_delim(tokens, "all_results_TOKENS.tsv", delim = "\t")
# 
# lemma <- results %>%
#   count(LEMMA) %>%
#   arrange(desc(n)) %>%
#   rename(FREQ = n) %>%
#   filter(!stringr::str_detect(LEMMA, "[\\W\\dA-Za-z]+"))
# write_delim(lemma, "all_results_LEMMAS.tsv", delim = "\t")
