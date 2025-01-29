# Generation and processing of synthetic EMG signals with linear and nonlinear trends, 
# followed by trend removal and interactive visualization

# Load necessary libraries
library(tuneR)    # Functions for generating basic signals
library(dygraphs) # Interactive time series plotting
library(ggplot2)  # Additional plotting library
library(htmltools)
library(plyr)

# Parameters
fs <- 1000                     # Sampling frequency (Hz)
dt <- 1 / fs                  # Time step
t <- seq(0, 1, by = dt)       # Time vector

# Synthetic EMG signal generation
freqsin <- 10                 # Frequency of the square wave

# Generate square wave
square_wave <- square(freqsin, samp.rate = fs, duration = dt + 1, xunit = "time")@left

dygraph(data.frame(time = t, square_wave), main = "Square Wave", xlab = "Time (s)", ylab = "Amplitude")

# Generate white noise
white_noise <- noise(kind = "white", samp.rate = fs, duration = 1 + dt, xunit = "time")@left

dygraph(data.frame(time = t, white_noise), main = "White Noise", xlab = "Time (s)", ylab = "Amplitude")

# Create synthetic EMG signal
indx1 <- which(square_wave == -1.0)
yEMG <- rep(NA, length(white_noise))
yEMG[indx1] <- white_noise[indx1]

indx2 <- which(square_wave > -1.0)
yEMG[indx2] <- white_noise[indx2] * 20

# Data frame with synthetic EMG signal
emg_data <- data.frame(time = t, signal = yEMG)

dygraph(emg_data, main = "Synthetic EMG Signal", xlab = "Time (s)", ylab = "Amplitude") %>%
  dyRangeSelector()

# Add linear trend
yLinear <- yEMG + (5 * t + 10)
emg_data$linear_signal <- yLinear

dygraph(emg_data[c("time", "linear_signal")], main = "EMG Signal with Linear Trend", xlab = "Time (s)", ylab = "Amplitude") %>%
  dyRangeSelector()

# Add non-linear trend
yNLin <- yLinear + sin(2 * pi * 1 * t)
emg_data$nonlinear_signal <- yNLin

dygraph(emg_data[c("time", "nonlinear_signal")], main = "EMG Signal with Linear and Nonlinear Trends", xlab = "Time (s)", ylab = "Amplitude") %>%
  dyRangeSelector()

# Remove linear trend
linear_model <- lm(linear_signal ~ t, data = emg_data)
linear_prediction <- predict(linear_model, emg_data)

detrended_signal <- emg_data$nonlinear_signal - linear_prediction

dygraph(data.frame(time = t, detrended_signal), main = "Signal After Linear Trend Removal", xlab = "Time (s)", ylab = "Amplitude") %>%
  dyRangeSelector()

# Remove non-linear trend
poly_model <- lm(detrended_signal ~ poly(time, 5), data = data.frame(time = t, detrended_signal))
poly_fit <- fitted(poly_model)
final_signal <- detrended_signal - poly_fit

# Final signal visualization
dygraph(data.frame(time = t, final_signal), main = "Signal After Linear and Nonlinear Trend Removal", xlab = "Time (s)", ylab = "Amplitude") %>%
  dyRangeSelector()