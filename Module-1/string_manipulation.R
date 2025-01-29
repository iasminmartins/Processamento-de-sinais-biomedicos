# Load the "stringr" library
library("stringr")

# Define the sentence
frase <- c("The Sun is much bigger than the Earth")

# A - Replace the word "Earth" with "Moon"
frase_nova <- str_replace(frase, "Earth", "Moon")

# Print the original and updated sentences
cat("Sentence:\n")
print(frase)
cat("Updated sentence:\n")
print(frase_nova)

# B - Count the number of characters in the original and updated string
cat("\nNumber of characters:\n")
cat("Original sentence length:", str_length(frase), "\n")
cat("Updated sentence length:", str_length(frase_nova), "\n")

# C - Sort the updated string
cat("\nSorted sentence (alphabetically):\n")
sorted_frase_nova <- str_sort(strsplit(frase_nova, " ")[[1]])  # Split the sentence into words and sort them
sorted_frase_nova <- paste(sorted_frase_nova, collapse = " ")  # Join the sorted words back into a single string
print(sorted_frase_nova)

# D - Compare using the '&' operator
if(str_length(frase) > 36 & str_length(frase_nova) <= 36)
{
 cat("\nComparison:\n")
 print("The first sentence has more than 36 characters and the second has 36 or fewer characters")
}

# E - Compare characters using '==' with padding (spaces)
cat("\nCharacter-by-character comparison using '==':\n")

# Find the length difference
max_length <- max(str_length(frase), str_length(frase_nova))

# Pad the shorter string with spaces
frase_padded <- str_pad(frase, max_length, side = "right")
frase_nova_padded <- str_pad(frase_nova, max_length, side = "right")

# Compare character-by-character
comparison_result <- (sapply(strsplit(frase_padded, NULL)[[1L]], utf8ToInt)) == 
                     (sapply(strsplit(frase_nova_padded, NULL)[[1L]], utf8ToInt))

print(comparison_result)