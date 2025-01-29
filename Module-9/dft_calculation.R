# This script calculates the Discrete Fourier Transform (DFT) coefficients 
# for a given input sequence using the basic DFT definition

# Define the input sequence
xn <- c(-1, 1, 2, -2)  # Input sequence
N <- length(xn)        # Number of points in the sequence

# Define the frequency index and time index vectors
k <- seq(from = 0, to = N - 1, by = 1)  # Frequency index (DFT output)
n <- seq(from = 0, to = N - 1, by = 1)  # Time index (DFT input)

# Define the DFT kernel function
W <- function(k, n, N) {
  exp(-1i * (2 * pi / N) * k * n)  # Exponential kernel of the DFT (-1i represents the imaginary unit)
}

# Initialize the DFT result as a complex number vector
X <- complex(length.out = N)

# Compute the DFT coefficients using the basic formula
for (i in 1:N) {
  X[i] <- sum(W(k[i], n, N) * xn)  # Apply the DFT formula for each frequency component
}

# Print the computed DFT coefficients with three decimal places
print(X, digits = 3)
