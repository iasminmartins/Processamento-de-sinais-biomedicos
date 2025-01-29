# This code demonstrates the concept of coherent averaging by generating 10 noisy time series,
# replicating one signal with additional noise, and computing the coherent average to recover
# the original signal

# Load necessary library
library(dygraphs) # For interactive plotting

# Parameters
fs <- 20000                  # Sampling frequency (Hz)
dt <- 1 / fs                # Time step
duration <- 9.5             # Signal duration (seconds)
t <- seq(0, duration, by = dt) # Time vector

# Create a data frame to store 10 time series
data <- data.frame(time = t, ch1 = NA, ch2 = NA, ch3 = NA, ch4 = NA, ch5 = NA, 
                   ch6 = NA, ch7 = NA, ch8 = NA, ch9 = NA, ch10 = NA)

# Generate 10 noisy signals
for (indx in 1:10) {
  pure_signal <- sin(2 * pi * 2 * t) # Pure sinusoidal signal with 2 Hz frequency
  noise <- runif(length(t), -0.3, 0.3) # Add uniform random noise
  data[[indx + 1]] <- pure_signal + noise # Store noisy signal in the data frame
}

# Interactive plot of the noisy signals
dygraph(data, main = "Noisy Time Series", xlab = "Time (s)", ylab = "Amplitude") %>%
  dyRangeSelector()

# Function to replicate a signal with additional noise
replicate_signal <- function(signal, n) {
  replicated_signals <- matrix(NA, nrow = n, ncol = length(signal))
  for (i in 1:n) {
    replicated_signals[i, ] <- signal + rnorm(length(signal)) # Add Gaussian noise
  }
  return(replicated_signals)
}

# Coherent averaging of 20 replicates
replicated_signals <- replicate_signal(data$ch1, 20) # Replicate channel 1
coherent_average <- colMeans(replicated_signals)     # Compute column-wise mean

# Plot results
plot(coherent_average, type = 'l', col = 'blue', lwd = 2, xlab = "Sample", 
     ylab = "Amplitude", main = "Coherent Average vs Original Signal")
lines(sin(2 * pi * 2 * t), col = 'red', lwd = 2) # Overlay the pure signal
legend("topright", legend = c("Coherent Average", "Pure Signal"), 
       col = c("blue", "red"), lty = 1, lwd = 2)
