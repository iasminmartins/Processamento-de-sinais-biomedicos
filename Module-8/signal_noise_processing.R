# This script generates a 5-second sinusoidal signal sampled at 500 Hz, adds Gaussian noise, 
# applies a recursive processor to the noisy signal, and visualizes the original, noisy, and processed signals

library(dygraphs)

# Parameters
sampling_frequency <- 500  # Sampling frequency (Hz)
time_step <- 1 / sampling_frequency
time_vector <- seq(from = 1, to = 5, by = time_step)

# Sinusoidal signal
signal_frequency <- 30  # Frequency (Hz)
original_signal <- sin(2 * pi * signal_frequency * time_vector)

# Plot original signal
plot_original_signal <- dygraph(data.frame(time = time_vector, amplitude = original_signal), 
                                 main = "Original Signal", xlab = "Discrete Time", ylab = "Amplitude") %>% 
  dyRangeSelector()
plot_original_signal

# Add Gaussian noise (10% max amplitude)
noisy_signal <- original_signal + 0.1 * max(original_signal) * rnorm(length(time_vector))

# Plot noisy signal
plot_noisy_signal <- dygraph(data.frame(time = time_vector, amplitude = noisy_signal), 
                              main = "Noisy Signal", xlab = "Discrete Time", ylab = "Amplitude") %>% 
  dyRangeSelector()
plot_noisy_signal

# Apply recursive processor from Exercise 3
data_frame <- data.frame(time = time_vector, signal = noisy_signal)
processed_signal <- rep(NA, length(noisy_signal))

# Initialize first two values
processed_signal[1] <- data_frame$signal[1]
processed_signal[2] <- (1.8523 * data_frame$signal[1]) + data_frame$signal[2] - (1.9021 * data_frame$signal[1])

# Apply recursive equation
for (i in 3:length(processed_signal)) {
  processed_signal[i] <- 1.8523 * processed_signal[i - 1] - 0.94833 * processed_signal[i - 2] + 
    data_frame$signal[i] - 1.9021 * data_frame$signal[i - 1] + data_frame$signal[i - 2]
}

# Plot processed signal
plot_processed_signal <- dygraph(data.frame(time = time_vector, amplitude = processed_signal), 
                                  main = "Processed Signal", xlab = "Discrete Time", ylab = "Amplitude") %>% 
  dyRangeSelector()
plot_processed_signal

# Compare original, noisy, and processed signals
comparison_plot <- dygraph(data.frame(time = time_vector, 
                                       original = original_signal, 
                                       noisy = noisy_signal, 
                                       processed = processed_signal), 
                            main = "Signal Comparison", xlab = "Discrete Time", ylab = "Amplitude") %>% 
  dyRangeSelector()
comparison_plot
