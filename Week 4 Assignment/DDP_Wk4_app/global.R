library(tm)
library(wordcloud)
library(memoise)
library(tidyverse)



getTermMatrix <- memoise(function(text) {
  # lines <- readr::read_lines(text, skip_empty_rows = TRUE)
  lines = strsplit(text, split = '\n\r')
  myCorpus = Corpus(VectorSource(lines)) %>%
    tm_map(content_transformer(tolower)) %>%
    tm_map(removePunctuation) %>%
    tm_map(removeNumbers) %>%
    tm_map(removeWords,
           readLines('stopwords.txt'))
  myDTM = TermDocumentMatrix(myCorpus,
                            control = list(minWordLength = 1))
  m = as.matrix(myDTM)
  sort(rowSums(m), decreasing = TRUE)
})