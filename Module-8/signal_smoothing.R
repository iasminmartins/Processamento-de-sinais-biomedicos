# Generate a 5-second signal as the sum of two sine waves and apply a recursive equation. 
# The effect of the equation on the signal is smoothing, making it more uniform.

library(dygraphs)

# Parameters
fs <- 1200  # Sampling frequency (Hz)
dt <- 1 / fs
t <- seq(from = 1, to = 5, by = dt)

# Sine wave 1
f1 <- 60  # Frequency of oscillation (Hz)
y1 <- sin(2 * pi * f1 * t)

# Sine wave 2
f2 <- 100  # Frequency of oscillation (Hz)
y2 <- sin(2 * pi * f2 * t)

# Sum of the two sine waves
soma <- y1 + y2

# Plot the sum of the sine waves
dygraph(data.frame(time = t, soma), main = "Sum of Sine Waves", xlab = "Discrete Time", ylab = "Amplitude") %>% dyRangeSelector()

# Recursive equation application
vetor <- data.frame(time = t, x = soma)
sinalfilt <- rep(NA, length(soma))

# Initialize the first two values
sinalfilt[1] <- vetor$x[1]
sinalfilt[2] <- (1.8523 * vetor$x[1]) + vetor$x[2] - (1.9021 * vetor$x[1])

# Apply recursive equation starting from the 3rd sample
for (i in 3:length(soma)) {
  sinalfilt[i] <- 1.8523 * soma[i - 1] - 0.94833 * soma[i - 2] + vetor$x[i] - 1.9021 * vetor$x[i - 1] + vetor$x[i - 2]
}

# Plot the filtered signal
dygraph(data.frame(time = t, sinalfilt), main = "Filtered Signal", xlab = "Discrete Time", ylab = "Amplitude") %>% dyRangeSelector()

