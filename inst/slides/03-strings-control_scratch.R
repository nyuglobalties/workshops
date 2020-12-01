library(tidyverse)

stringr::words

str_subset(stringr::words, "z.*e")
str_detect("~$test-file.docx", "^~\\$")
str_detect("word\\thing", "\\\\")

str_detect("group", "^(group(_[ab])?)")
str_detect("group_", "^(group(_[ab])?)$")
str_detect("group_a", "^(group(_[ab])?)$")

given_name <- "Patrick"
str_c("Hello, ", given_name, "!")
str_glue("Hello, {given_name}!")
