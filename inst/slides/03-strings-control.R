library(tidyverse)

# Pattern Matching ----

str_view_all(
  c("hi world", "hihi"),
  "hi"
)

str_view_all("Any digit: 1a2b45", "\\d")
str_view_all("All alphanumeric characters, including _", "\\w")
str_view_all("All whitespace (spaces, tabs, new lines)", "\\s")
str_view_all("ANY character except newline", ".")
str_view_all("A period/full-stop.", "\\.")

str_view_all("One or more characters: baab", "a+")
str_view_all("Zero or more characters: zzzero", "z*")
str_view_all("Between 2 and 3 digits: 2345", "\\d{2,3}")
str_view_all("5 contiguous letters", "\\w{5}")
str_view_all("Zero or one b characters", "b?")

str_view_all("One or more of 'a', 'b', or 'c': abcdab", "[abc]+")
str_view_all("Any lowercase letter", "[a-z]")
str_view_all("Any character BUT 'a'", "[^a]")
str_view_all("All caps, numbers, and '+'", "[A-Z0-9+]")

str_view_all("Starts with 'Starts'", "^Starts")
str_view_all("Ends in '.docx': test-file.docx", "\\.docx$")

str_view_all("'this' or 'that'", "this|that")
str_view_all("Matches 'this word' or 'that word'", "(this|that) word")

# String Manipulation ----
str_c("a", "b")
x <- letters[1:6]
str_c(x, "_", LETTERS[1:6])
paste0(x, "_", LETTERS[1:6]) # Base R equiv

given_name <- "Patrick"
str_glue("Hello, {given_name}!")

str_glue_data(
  head(mtcars, 3),
  "Miles per gallon: {mpg}"
)

# grep("(\\w)\\1", stringr::words, value = TRUE) -- base R equivalent
str_subset(stringr::words, "(\\w)\\1")

sum(str_count(stringr::words, "(\\w)\\1") > 0)

# grepl("(\\w)\\1", stringr::words) -- Base R equivalent
sum(str_detect(stringr::words, "(\\w)\\1")) # Should be 157!

# grep("(\\w)\\1", stringr::words) -- Base R equivalent
str_which(stringr::words, "(\\w)\\1")

str_extract("rabbit", "(\\w)\\1")
str_extract("rabid", "(\\w)\\1")

sentence <- "This is a sentence that I'd like to get the words from"
str_split(sentence, "\\s+") # Recall that \\s means all whitespace!

sentences <- c(
  "This is one sentence",
  "This is another"
)
str_split(sentences, "\\s+")

str(str_split(sentences, "\\s+"))

results <- str_split(sentences, "\\s+")
results[[1]]

str_replace(
  "G102041",
  "^G(\\d)(\\d{2})(\\d{2})(\\d)",
  "game_\\2_session_\\4_day_\\1_week_\\3"
)

# Functions and For Loops ----
say_hi <- function(x) {
  stringr::str_glue("Hi, {x}!")
}
say_hi("Charles")

# Function arguments don't modify their calling environment!
x <- "Bob"
say_hi_again <- function(x) {
  x <- stringr::str_c(x, " Jones")
  stringr::str_glue("Hi, {x}!")
}
say_hi_again("Bob")
print(x)

# In pursuit of a vector mode
vec_mode <- function(x) {
  x
}
vec_mode(1:5)

vec_mode <- function(x) {
  ux <- unique(x)

  ux
}
vec_mode(c(1, 1, 2))

vec_mode <- function(x) {
  ux <- unique(x)
  tabulated <- tabulate(match(x, ux))

  tabulated
}
vec_mode(c(1, 1, 2))

vec_mode <- function(x) {
  ux <- unique(x)
  tabulated <- tabulate(match(x, ux))

  ux[which.max(tabulated)]
}
vec_mode(c(1, 1, 2))

# Without for loop
set.seed(2003)
words_subset <- sample(stringr::words, 50)

sentences <- c(
  paste0(sample(words_subset, 10, replace = TRUE), collapse = " "),
  paste0(sample(words_subset, 10, replace = TRUE), collapse = " "),
  paste0(sample(words_subset, 10, replace = TRUE), collapse = " "),
  paste0(sample(words_subset, 10, replace = TRUE), collapse = " "),
  paste0(sample(words_subset, 10, replace = TRUE), collapse = " ")
)

# With for loop
set.seed(2003)
sentences <- character(5)

for (i in seq_along(sentences)) {
  sentences[[i]] <- paste0(sample(words_subset, 10, replace = TRUE), collapse = " ")
}

# Putting it all together
split_list <- str_split(sentences, "\\s+")
mode_chr <- character(length(split_list))

for (i in seq_along(mode_chr)) {
  mode_chr[[i]] <- vec_mode(split_list[[i]])
}

mode_chr
