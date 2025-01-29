# This code generates a synthetic EMG signal with bursts and noise, 
# calculates RMS values using overlapping windows, and detects bursts based on a threshold

# Load necessary libraries
library(dygraphs)  # For interactive plotting
library(tuneR)     # For signal generation

# Parameters
fs <- 1000                    # Sampling frequency (Hz)
dt <- 1 / fs                  # Time resolution
duration <- 10                # Simulation duration (seconds)
t <- seq(from = 0, to = duration, by = dt) # Time vector

# Generate square wave to represent bursts
fqua <- 5                     # Frequency of the square wave
square_wave <- square(fqua, samp.rate = fs, duration = duration + dt, xunit = "time")@left

# Generate noise for EMG signal
bursts <- noise(kind = "white", samp.rate = fs, duration = duration + dt, xunit = "time")@left
background_noise <- rnorm(length(t))

# Combine bursts and noise to form the EMG signal
indx1 <- which(square_wave == -1)
emg <- rep(NA, length(background_noise))
emg[indx1] <- background_noise[indx1]
indx2 <- which(square_wave > -1)
emg[indx2] <- bursts[indx2] * 25

# Create a data frame for the EMG signal
emg_data <- data.frame(time = t, signal = emg)

# Interactive plot of the synthetic EMG signal
dygraph(emg_data, main = "Synthetic EMG Signal", xlab = "Time (s)", ylab = "Amplitude") %>%
  dyRangeSelector()

# Parameters for RMS calculation
window_size_ms <- 100         # Window size in milliseconds
overlap_percent <- 30         # Overlap percentage
window_size_samples <- (window_size_ms / 1000) * fs
overlap_samples <- ceiling(window_size_samples * (overlap_percent / 100))

# Function to apply overlapping windowing
overlapping_windows <- function(signal, seg_length, overlap) {
  indices <- 1:length(signal)
  starts <- seq(1, length(indices), by = seg_length - overlap)
  ends <- starts + seg_length - 1
  ends[ends > length(indices)] <- length(indices)
  windows <- lapply(1:length(starts), function(i) {
    if ((ends[i] - starts[i] + 1) == seg_length) {
      indices[starts[i]:ends[i]]
    } else {
      NULL
    }
  })
  windows[!sapply(windows, is.null)]
}

# Apply windowing
data_windows <- overlapping_windows(emg, window_size_samples, overlap_samples)

# Calculate RMS values for each window
rms_time_centers <- sapply(data_windows, function(win) mean(t[win]))
rms_values <- sapply(data_windows, function(win) {
  sqrt(mean(emg[win]^2))
})

# Create data frame for RMS values
rms_data <- data.frame(time = rms_time_centers, rms = rms_values)

# Interactive plot of RMS values
dygraph(rms_data, main = "RMS Values", xlab = "Time (s)", ylab = "RMS") %>%
  dyRangeSelector()

# Detect bursts based on RMS threshold
threshold <- 4
burst_indices <- which(rms_values > threshold)
threshold_values <- rep(NA, length(rms_values))
threshold_values[burst_indices] <- rms_values[burst_indices]

# Create data frame for threshold crossings
threshold_data <- data.frame(time = rms_time_centers, threshold = threshold_values)

# Interactive plot of bursts detected
dygraph(threshold_data, main = "Detected Bursts (RMS > Threshold)", xlab = "Time (s)", ylab = "RMS") %>%
  dySeries("threshold", stemPlot = TRUE)