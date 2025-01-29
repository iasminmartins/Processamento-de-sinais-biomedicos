# This code demonstrates signal windowing using both non-overlapping and overlapping methods. 
# A synthetic signal is generated, normalized, and split into windows

# Load necessary library
library(dygraphs)

# Function to normalize a signal to the range [0, 1]
normalize_signal <- function(signal) {
  max_val <- max(signal)
  min_val <- min(signal)
  normalized <- (signal - min_val) / (max_val - min_val)
  return(normalized)
}

# Function to split a signal into overlapping windows
split_with_overlap <- function(signal, window_length, overlap) {
  indices <- seq(1, length(signal), by = window_length - overlap)
  windows <- lapply(indices, function(start) {
    end <- min(start + window_length - 1, length(signal))
    if (end - start + 1 == window_length) {
      return(start:end)
    }
    return(NULL)
  })
  return(windows[!sapply(windows, is.null)])
}

# General parameters
fs <- 5000                    # Sampling frequency (Hz)
dt <- 1 / fs                  # Time step
t <- seq(0, 10, by = dt)      # Time vector

# Generate a random signal from a normal distribution
y <- rnorm(length(t))
y <- normalize_signal(y)       # Normalize the signal to [0, 1]

# Create a data frame for the signal
data <- data.frame(time = t, signal = y)

# Exercise 1: Non-overlapping windowing
non_overlap_window <- 0.5     # Window duration in seconds
non_overlap_indices <- seq(0, 10, by = non_overlap_window) # Start times for windows

# Plot for Exercise 1
dygraph(data, main = "Non-Overlapping Windowing", group = "Group1") %>%
  dyEvent(non_overlap_indices, labelLoc = "bottom") %>%
  dyRangeSelector()

# Exercise 2: Overlapping windowing
overlap_window_duration <- 1  # Window duration in seconds (1000 ms)
overlap_window_length <- overlap_window_duration * fs # Window length in samples
overlap <- ceiling(overlap_window_length / 2) # 50% overlap

# Split the signal into overlapping windows
overlapping_windows <- split_with_overlap(1:length(y), overlap_window_length, overlap)

# Create pulse signals for each window
pulse_signals <- lapply(overlapping_windows, function(indices) {
  pulse <- rep(0, length(y))
  pulse[indices] <- 1
  return(pulse)
})

# Combine pulses into a single data frame with offsets for visualization
for (i in seq_along(pulse_signals)) {
  data[[paste0("window", i)]] <- pulse_signals[[i]] + i * 2 - 2
}

# Plot for Exercise 2
dygraph(data, main = "Overlapping Windowing", group = "Group2") %>%
  dyRangeSelector()