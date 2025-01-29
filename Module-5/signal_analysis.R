# Exercise: Analysis of MODULO5.xlsx
# 
# Given the data in "MODULO5.xlsx," answer the following questions:
# a) What is the signal-to-noise ratio for the period between 0 and 14 seconds?
#    Estimate it for channels ch1 and ch2. Hint: Use the RMS value for the calculation.
# b) Compare the noise segments between 0-14 s (noise 1) and 18-43 s (noise 2). 
#    Estimate for channels ch1 and ch2 using RMS and present results in dB.
# c) For each channel (ch1 and ch2), estimate the constant linear trend value for 
#    noise 1, noise 2, and the signal segment (45-334 s).
# d) Are there any discontinuities in the signals from channels 1 and 2? 
#    Justify using a boxplot for the segment 0-40 s.
# e) If any discontinuities exist (see part d), remove them using linear interpolation.
#    Generate a plot illustrating the signal segment with and without discontinuities.
# f) Are the signals in channels 1 and 2 continuous in time and value? Explain.
# g) Challenge: Use the concept of independent and identically distributed (iid) 
#    variables to verify if the segments (0-8 s, 20-40 s, 45-334 s) are iid. 
#    Use the `diffsign.test` function from the `spgs` library and justify your conclusions.

# The code below implements the solution to the above exercise.

# --- Code starts here ---

# Required Libraries
library(openxlsx)   # For reading Excel files
library(dygraphs)   # For interactive plotting
library(spgs)       # For IID test

# Load data
file_name <- "MODULO5.xlsx"
data <- readWorkbook(file_name, sheet = 1, detectDates = TRUE)

# Explore data structure
str(data)

# Prepare data for visualization
df_plot <- data.frame(time = data$time, ch1 = data$chan.1, ch2 = data$chan.2)
dygraph(df_plot) %>% dyRangeSelector()

# Helper function: RMS (Root Mean Square) Calculation
calculate_rms <- function(x) {
  sqrt(mean(x^2))
}

# --- Part (a) Signal-to-Noise Ratio (SNR) between 0 and 14 seconds ---
# Channel 1
noise_indices_ch1 <- which(data$time <= 14)
noise_ch1 <- data$chan.1[noise_indices_ch1]
time_noise_ch1 <- data$time[noise_indices_ch1]
df_noise_ch1 <- data.frame(time = time_noise_ch1, Rch1 = noise_ch1)
dygraph(df_noise_ch1, main = "Noise - Channel 1") %>% dySeries("Rch1", color = "red")

# Channel 2
noise_indices_ch2 <- which(data$time <= 14)
noise_ch2 <- data$chan.2[noise_indices_ch2]
time_noise_ch2 <- data$time[noise_indices_ch2]
df_noise_ch2 <- data.frame(time = time_noise_ch2, Rch2 = noise_ch2)
dygraph(df_noise_ch2, main = "Noise - Channel 2") %>% dySeries("Rch2", color = "blue")

# Main signal
signal_indices <- which(data$time >= 45 & data$time <= 334)
signal_ch1 <- data$chan.1[signal_indices]
signal_ch2 <- data$chan.2[signal_indices]

# Compute RMS values
rms_noise_ch1 <- calculate_rms(noise_ch1)
rms_signal_ch1 <- calculate_rms(signal_ch1)
rms_noise_ch2 <- calculate_rms(noise_ch2)
rms_signal_ch2 <- calculate_rms(signal_ch2)

# Calculate SNR (dB)
snr_ch1 <- 20 * log10(rms_signal_ch1 / rms_noise_ch1)
snr_ch2 <- 20 * log10(rms_signal_ch2 / rms_noise_ch2)

cat("SNR for Channel 1:", snr_ch1, "dB\n")
cat("SNR for Channel 2:", snr_ch2, "dB\n")

# --- Part (b) Compare Noise Segments (0-14s vs 18-43s) ---
# Noise Segment 2
noise_indices_2 <- which(data$time >= 18 & data$time <= 43)
noise_2_ch1 <- data$chan.1[noise_indices_2]
noise_2_ch2 <- data$chan.2[noise_indices_2]

# Compute RMS for Noise Segment 2
rms_noise_2_ch1 <- calculate_rms(noise_2_ch1)
rms_noise_2_ch2 <- calculate_rms(noise_2_ch2)

# SNR for Noise Segment 2
snr_2_ch1 <- 20 * log10(rms_signal_ch1 / rms_noise_2_ch1)
snr_2_ch2 <- 20 * log10(rms_signal_ch2 / rms_noise_2_ch2)

cat("SNR for Noise Segment 2 - Channel 1:", snr_2_ch1, "dB\n")
cat("SNR for Noise Segment 2 - Channel 2:", snr_2_ch2, "dB\n")

# --- Part (c) Linear Trend Estimation ---
linear_trend_ch1 <- mean(signal_ch1)
linear_trend_noise_ch1 <- mean(noise_ch1)
linear_trend_ch2 <- mean(signal_ch2)
linear_trend_noise_ch2 <- mean(noise_ch2)

cat("Linear Trend - Channel 1 (Signal):", linear_trend_ch1, "\n")
cat("Linear Trend - Channel 1 (Noise):", linear_trend_noise_ch1, "\n")
cat("Linear Trend - Channel 2 (Signal):", linear_trend_ch2, "\n")
cat("Linear Trend - Channel 2 (Noise):", linear_trend_noise_ch2, "\n")

# --- Part (d) Discontinuity Analysis using Boxplot ---
boxplot(data$chan.1[1:40], main = "Boxplot - Channel 1 (0-40s)", col = "red")
boxplot(data$chan.2[1:40], main = "Boxplot - Channel 2 (0-40s)", col = "blue")

# --- Part (e) Discontinuity Removal with Linear Interpolation ---
# Interpolation Example
interpolated_ch1 <- approx(data$time, data$chan.1, method = "linear", xout = data$time)$y
plot(data$time[1:400], data$chan.1[1:400], type = "l", col = "red", main = "Channel 1 - Original vs Interpolated")
lines(data$time[1:400], interpolated_ch1[1:400], col = "blue")

# --- Part (f) Continuous Signal Discussion ---
cat("The statement that the signals are continuous in time and values is FALSE.\n")
cat("Continuous signals imply infinite resolution, which is impossible to process computationally.\n")

# --- Part (g) IID Test ---
# Define segments
segment_1 <- data[data$time >= 0 & data$time <= 8, ]
segment_2 <- data[data$time >= 20 & data$time <= 40, ]

# IID Test using diffsign.test
iid_ch1_seg1 <- diffsign.test(segment_1$chan.1)
iid_ch2_seg1 <- diffsign.test(segment_1$chan.2)
iid_ch1_seg2 <- diffsign.test(segment_2$chan.1)
iid_ch2_seg2 <- diffsign.test(segment_2$chan.2)

cat("IID Test Results:\n")
cat("Channel 1 - Segment 1:", iid_ch1_seg1$p.value, "\n")
cat("Channel 2 - Segment 1:", iid_ch2_seg1$p.value, "\n")
cat("Channel 1 - Segment 2:", iid_ch1_seg2$p.value, "\n")
cat("Channel 2 - Segment 2:", iid_ch2_seg2$p.value, "\n")