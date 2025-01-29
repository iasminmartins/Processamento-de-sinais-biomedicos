# This script explores the Fast Fourier Transform (FFT) function in R,
# compares it with a manually implemented Discrete Fourier Transform (DFT), and 
# measures the computational time difference

# --- Basic FFT Operations ---

# Define an input sequence
x <- 1:5  

# Compute the Fast Fourier Transform (FFT)
fft_x <- fft(x)  
print(fft_x)  # Display FFT result

# Compute the Inverse FFT and normalize it by the sequence length
ifft_x <- fft(fft_x, inverse = TRUE) / length(x)  
print(ifft_x)  # Display the reconstructed signal

# --- Manual Implementation of DFT ---
DFT <- function(z, inverse = FALSE) {
  n <- length(z)
  if (n == 0) return(z)  # Return empty if input length is zero
  
  k <- 0:(n - 1)  # Frequency index
  ff <- (if (inverse) 1 else -1) * 2 * pi * 1i * k / n  # Rotation factor
  
  # Compute the DFT using the summation formula
  vapply(1:n, function(h) sum(z * exp(ff * (h - 1))), complex(1))
}

# --- Compare FFT and DFT Results ---

# Function to compute relative difference between two sets of values
relD <- function(x, y) 2 * abs(x - y) / abs(x + y)

# Generate a complex-valued sequence
n <- 2^10  
z <- complex(n, rnorm(n), rnorm(n))  # Generate random complex values

# Compare the FFT and manually computed DFT
summary(relD(fft(z), DFT(z)))  

# Compare the inverse FFT and inverse DFT
summary(relD(fft(z, inverse = TRUE), DFT(z, inverse = TRUE)))  

# --- Measure Execution Time ---

# Measure execution time of DFT
DFT_time <- proc.time()
proc.time() - DFT_time  # Display time taken
