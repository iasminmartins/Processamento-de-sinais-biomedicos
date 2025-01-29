# The "%in%" operator checks if elements of one vector are present in another vector.
# It returns a logical vector indicating whether there is a match for each element.

# Define vectors
vector1 <- c(1:25)  # List with numbers
vector2 <- c(22:32) 

# Use "%in%" to check which elements of vector1 are also in vector2
matching_elements <- vector1[vector1 %in% vector2]

# Print the result
print("Elements in vector1 that are also in vector2:")
print(matching_elements)  # Output: [1] 22 23 24 25
