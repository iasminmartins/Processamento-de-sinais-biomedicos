# This script simulates synthetic electromyographic (EMG) signals with bursts of activity. 
# A low-pass filter is applied using both Butterworth and Chebyshev filters to compare their performance. 
# The script plots the generated signals, filtered signals, and frequency responses

# Load necessary libraries
library(tuneR)
library(dygraphs)
library(ggplot2)
library(signal)

# Sampling frequency and time vector
sampling_frequency <- 1000  # Hz
time_step <- 1 / sampling_frequency
time_vector <- seq(from = 0.0, to = 10.0, by = time_step)

# Total signal duration
total_duration <- time_vector[length(time_vector)]

# Generate white noise
noise_signal <- noise(kind = "white", samp.rate = sampling_frequency, duration = total_duration + time_step, xunit = "time")@left

# Initialize EMG signal with noise
synthetic_emg <- rep(NA, length(noise_signal))
time_data <- data.frame(time = time_vector)

# Define burst intervals and amplify segments with activity
burst_indices <- list(
  which(time_data$time < 1),
  which(time_data$time >= 1.0 & time_data$time < 3.0),
  which(time_data$time >= 3.0 & time_data$time < 4.0),
  which(time_data$time >= 4.0 & time_data$time < 6.0),
  which(time_data$time >= 6.0 & time_data$time < 7.0),
  which(time_data$time >= 7.0 & time_data$time < 9.0),
  which(time_data$time >= 9.0)
)

# Assign noise and amplify active segments
for (i in 1:length(burst_indices)) {
  if (i %% 2 == 0) { # Active segments
    synthetic_emg[burst_indices[[i]]] <- noise_signal[burst_indices[[i]]] * 20 * 1.2
  } else { # Inactive segments
    synthetic_emg[burst_indices[[i]]] <- noise_signal[burst_indices[[i]]]
  }
}

# Plot synthetic EMG signal
emg_data <- data.frame(time = time_vector, emg_signal = synthetic_emg)
dygraph(emg_data, main = "Synthetic EMG Signal", xlab = "Time (s)", ylab = "Amplitude (mV)") %>% dyRangeSelector()

# Low-pass Butterworth filter
filter_order <- 3
cutoff_frequency <- 5  # Hz
normalized_cutoff <- cutoff_frequency / (sampling_frequency / 2)
butter_filter <- butter(filter_order, normalized_cutoff, type = "low")
filtered_emg_butter <- filtfilt(filt = butter_filter, synthetic_emg)

# Plot Butterworth filtered signal
dygraph(data.frame(time = time_vector, filtered_signal = filtered_emg_butter), 
        main = "EMG Signal Filtered with Butterworth", xlab = "Time (s)", ylab = "Amplitude (mV)") %>% dyRangeSelector()

# Frequency response of Butterworth filter
butter_response <- freqz(butter_filter)

# Low-pass Chebyshev filter
chebyshev_ripple <- 0.5  # dB
chebyshev_filter <- cheby1(filter_order, chebyshev_ripple, normalized_cutoff, type = "low")
filtered_emg_chebyshev <- filtfilt(filt = chebyshev_filter, synthetic_emg)

# Plot Chebyshev filtered signal
dygraph(data.frame(time = time_vector, filtered_signal = filtered_emg_chebyshev), 
        main = "EMG Signal Filtered with Chebyshev", xlab = "Time (s)", ylab = "Amplitude (mV)") %>% dyRangeSelector()

# Frequency response of Chebyshev filter
chebyshev_response <- freqz(chebyshev_filter)

# Comparison of Butterworth and Chebyshev filtered signals
dygraph(data.frame(time = time_vector, Butterworth = filtered_emg_butter, Chebyshev = filtered_emg_chebyshev), 
        main = "Comparison of Filtered EMG Signals", xlab = "Time (s)", ylab = "Amplitude (mV)") %>% dyRangeSelector()

# Frequency response comparison
plot(butter_response$f / pi, 20 * log10(abs(butter_response$h)), type = "l", col = "blue", lwd = 2,
     ylim = c(-40, 0), xlim = c(0, 0.5), xlab = "Normalized Frequency (π rad/sample)", ylab = "Magnitude (dB)",
     main = "Frequency Response: Butterworth vs Chebyshev")
lines(chebyshev_response$f / pi, 20 * log10(abs(chebyshev_response$h)), col = "red", lwd = 2)
legend("topright", legend = c("Butterworth", "Chebyshev"), col = c("blue", "red"), lty = 1, lwd = 2)
