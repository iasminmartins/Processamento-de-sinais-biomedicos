# Analog Signal Simulation
# This example simulates an analog signal, which can take any value over any time interval.

library(dygraphs)

fs <- 1000 # Sampling frequency in Hz
dt <- 1/fs # Temporal resolution in seconds
tf <- 5 # Final time in seconds
t <- seq(from = 0, to = tf, by = dt) # Time vector
f <- 30 # Oscillation frequency
y <- cos(2*pi*f*t)

dygraph(data.frame(t, y),
        xlab = "Time (seconds)",
        ylab = "Amplitude",
        main = "Analog Signal",
        group = "SA") %>%
  dyRangeSelector(dateWindow = c((517-1)*dt, (600-1)*dt))
