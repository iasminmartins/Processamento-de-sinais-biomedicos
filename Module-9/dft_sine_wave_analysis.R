# This script generates a 20 Hz sine wave sampled at 500 Hz 
# and computes the amplitude and phase spectrum using DFT

# Load necessary library
library(dygraphs)

# Define sampling parameters
fs <- 500  # Sampling frequency in Hz
dt <- 1 / fs  # Sampling interval

# Generate time vector (10-second duration)
t <- seq(from = 0, to = 10, by = dt)

# Define sine wave parameters
f <- 20  # Frequency of the sine wave in Hz
y <- sin(2 * pi * f * t)  # Generate sine wave

# Plot the generated sine wave
dygraph(data.frame(t, y), main = "Generated Sine Wave", xlab = "Time (s)", ylab = "Amplitude") %>%
  dyRangeSelector()

# --- Frequency Domain Analysis ---

# Compute frequency resolution
delta <- fs / length(y)

# Define the frequency range
fn <- (length(y) - 1) * delta
ff <- seq(from = 0, to = fn, by = delta)

# Compute the Fast Fourier Transform (FFT)
yFFT <- fft(y)  

# --- Amplitude Spectrum ---
mag <- Mod(yFFT)  # Compute magnitude of FFT

# Plot the amplitude spectrum
dygraph(data.frame(ff, mag), main = "Amplitude Spectrum", xlab = "Frequency (Hz)", ylab = "Amplitude") %>%
  dyRangeSelector() %>%
  dyEvent(fs / 2, label = "SYMMETRY", labelLoc = "top")

# --- Phase Spectrum ---
theta <- atan2(Im(yFFT), Re(yFFT))  # Compute phase angle

# Plot the phase spectrum
dygraph(data.frame(ff, theta), main = "Phase Spectrum", xlab = "Frequency (Hz)", ylab = "Phase") %>%
  dyRangeSelector() %>%
  dyEvent(fs / 2, label = "SYMMETRY", labelLoc = "top")
