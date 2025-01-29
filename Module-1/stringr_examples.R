# stringr tutorial example

# 1. String length
str_length("mode") # Length of string

# 2. Substring extraction
x <- c("abcdef", "ghifjk")
str_sub(x, 5, 6) # Extracts 5th and 6th characters
str_sub(x, 2, -2) # From the second to the second-to-last character

# 3. String duplication
str_dup(x, c(2, 3)) # Duplicates first string, triples second

# 4. String padding
x <- c("abc", "defghi")
str_pad(x, 10) # Adds spaces on the left
str_pad(x, 10, "both") # Adds spaces on both sides

# 5. Truncating strings
x <- c("pequeno", "um grande string de caracteres")
str_trunc(x, 10) # Truncates to 10 characters

# 6. Trimming whitespace
x <- c(" a ", "b ", " c")
str_trim(x) # Trims both sides

# 7. String concatenation
jabberwocky <- str_c(
  "`Twas brillig, and the slithy toves ",
  "did gyre and gimble in the wabe."
)
cat(str_wrap(jabberwocky, width = 40)) # Wraps text

# 8. Case transformations
x <- "edição de strings"
str_to_upper(x) # Uppercase
str_to_title(x) # Title case

# 9. Sorting strings
x <- c("d", "e", "f")
str_sort(x) # Alphabetical order

# 10. Pattern matching
strings <- c("maçã", "98855 8965", "3763 8555")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
str_detect(strings, phone) # Detects pattern

# 11. Replacing substrings
str_replace(strings, phone, "XXX-XXX-XXXX") # Replaces first match

# 12. Splitting strings
str_split("e-d-d", "-") # Splits string by "-"

# 13. Unicode handling
a <- "\u00e1"
b <- "a\u0301"
str_detect(a, coll(b)) # Collation-aware matching

# 14. Word boundaries
x <- "Isso é uma frase"
str_split(x, boundary("word")) # Splits into words