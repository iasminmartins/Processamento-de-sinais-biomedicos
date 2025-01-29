# This script calculates the frequency resolution of the DFT 
# for a given sampled sequence

# Define sampling frequency
fs <- 33  # Sampling frequency in Hz

# Define the input sequence
xn <- c(-1, 1, 2, -2)  # Input sequence

# Number of points in the sequence
N <- length(xn)

# Calculate frequency resolution
res_freq <- fs / N  
print(res_freq)  # Display frequency resolution
