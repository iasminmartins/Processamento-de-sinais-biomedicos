# This script computes the rotation factor matrix W for a given sequence.
# It then calculates the DFT and IDFT coefficients based on this matrix

# Define the input sequence
x <- c(-1, 1, 2, -2)  # Input sequence

# Define the DFT rotation factor matrix W
W <- matrix(
   c(1, 1, 1, 1,
     1, -1i, -1, 1i,
     1, -1, 1, -1,
     1, 1i, -1, -1i), 
   nrow = 4, 
   ncol = 4, 
   byrow = TRUE)

# Print the rotation matrix
print(W)

# Compute the DFT coefficients
X <- W %*% x  
print(X)  # Display the computed DFT coefficients

# Compute the inverse DFT matrix
N <- length(x)  
INV <- (1 / N) * Conj(W)  # Conjugate of W divided by N

# Print the inverse DFT matrix
print(INV)

# Compute the IDFT (Inverse Discrete Fourier Transform)
x_reconstructed <- INV %*% X  
print(x_reconstructed)  # Display the reconstructed sequence
