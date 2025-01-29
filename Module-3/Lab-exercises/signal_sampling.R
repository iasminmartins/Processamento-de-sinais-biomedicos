# Signal Sampling Example
# This example demonstrates signal sampling, where amplitude values are sampled and retained from an analog signal. 
# The sampling process is controlled by a clock, and the sample time defines a crucial parameter in biomedical signal processing: the sampling frequency.

fs <- 850  # Sampling frequency
dt <- 1 / fs  # Temporal resolution
ti <- 0.0  # Start time
tf <- 4.0  # End time

# Create a time vector with the defined parameters
t <- seq(from = ti, to = tf, by = dt)

# Return the number of samples in the time vector
length(t)
