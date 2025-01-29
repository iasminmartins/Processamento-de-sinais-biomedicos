# Quantization Example
# This example demonstrates quantization, where the amplitude values of a signal are discretized, 
# making them take predefined values based on a certain bit depth.

library(dygraphs)

fs <- 1000  # Sampling frequency
dt <- 1 / fs  # Temporal resolution
tf <- 5  # Final time of the event

# Create a time vector
t <- seq(from = 0, to = tf, by = dt)

f <- 30  # Oscillation frequency
y <- cos(2 * pi * f * t)  # Signal

# Quantizing the signal
y <- ifelse(y > 0.98, 1, y)  # Set values above 0.98 to 1

Vmax <- max(y)  # Maximum value
Vmin <- min(y)  # Minimum value

k <- 1  # Number of bits
Q <- (Vmax - Vmin) / 2^k  # A/D resolution

# Generate quantization levels
qts <- seq(from = Vmin, to = Vmax, by = Q)

# Apply quantization to the signal
yq <- qts[findInterval(y, qts)]

# Plot the quantized signal using dygraph
dygraph(data.frame(t, y, yq), xlab = "Time (seconds)", ylab = "Amplitude", main = "Quantized Signal") %>%
  dyRangeSelector(dateWindow = c((517 - 1) * dt, (600 - 1) * dt))  # Plotting the graph
