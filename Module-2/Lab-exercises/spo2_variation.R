# Simulating SpO2 variation

# Load necessary libraries
library(dygraphs)

# Set random seed for reproducibility
set.seed(123)

# Generate time vector for 10 seconds
t <- seq(from = 0, to = 10, by = 0.001)

# Simulate SpO2 variation for day 1 (with noise)
y1 <- 97 + sin(2 * pi * 60 * t) + sin(2 * pi * 30 * t) + rnorm(length(t), mean = 0.3, sd = 0.1)

# Simulate SpO2 variation for day 2 (with phase shift and noise)
y2 <- 97 + sin(2 * pi * 60 * t + (pi / 6)) + sin(2 * pi * 30 * t + (pi / 6)) + rnorm(length(t), mean = 0.5, sd = 0.1)

# Create the dygraph plot for both days
dygraph(data.frame(t, y1, y2), xlab = "Time (seconds)", ylab = "SpO2 (%)") %>%
  dyRangeSelector() %>%
  dyEvent("2.1", "Fixed time tk = 2.1", labelLoc = "bottom")