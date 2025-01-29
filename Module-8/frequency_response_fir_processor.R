# This script calculates the frequency response H(z) for y[n] = 0.5[x(n) + x[n−1]], 
# and plots the amplitude and phase. The processor is identified as a FIR type.

# Load necessary library
library(ggplot2)

# Define digital frequency range
digital_frequency <- seq(from = 0, to = pi, by = pi / 100)

# Calculate the frequency response H(z)
frequency_response <- 0.5 + 0.5 * exp(complex(real = 0, imaginary = -digital_frequency))

# Compute amplitude and phase
amplitude <- abs(frequency_response)
phase <- Arg(frequency_response)

# Plot amplitude response
plot(digital_frequency, amplitude, type = 'l', col = "blue", lwd = 2, 
     xlab = "Digital Frequency (rad/s)", ylab = "Amplitude", 
     main = "Amplitude Response")

# Plot phase response
plot(digital_frequency, phase, type = 'l', col = "red", lwd = 2, 
     xlab = "Digital Frequency (rad/s)", ylab = "Phase (radians)", 
     main = "Phase Response")

# Processor Type
# This is a FIR (Finite Impulse Response) processor, as it depends only on the input and is non-recursive.
