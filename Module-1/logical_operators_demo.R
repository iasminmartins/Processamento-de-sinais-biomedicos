# The "&" operator performs an element-wise logical AND operation, 
# returning TRUE only if both elements are TRUE.

# The "|" operator performs an element-wise logical OR operation, 
# returning TRUE if at least one of the elements is TRUE.

# The "&&" operator performs a logical AND operation, considering only the first element of each vector.
# It returns TRUE only if both the first elements are TRUE.

# The "||" operator performs a logical OR operation, considering only the first element of each vector.
# It returns TRUE if at least one of the first elements is TRUE.

# Define vectors
vector1 <- c(TRUE, FALSE, 5, 0)
vector2 <- c(FALSE, TRUE, 0, 0)

# Using "&" for element-wise AND operation
print("Result of element-wise AND (z & h):")
print(vector1 & vector2)  # Output: [1] FALSE FALSE FALSE FALSE

# Using "&&" for logical AND considering only the first element
print("Result of logical AND considering only the first element (z && h):")
print(vector1[1] && vector2[1])  # Output: [1] FALSE

# Using "|" for element-wise OR operation
print("Result of element-wise OR (z | h):")
print(vector1 | vector2)  # Output: [1] TRUE TRUE TRUE FALSE

# Using "||" for logical OR considering only the first element
print("Result of logical OR considering only the first element (z || h):")
print(vector1[1] || vector2[1])  # Output: [1] TRUE
