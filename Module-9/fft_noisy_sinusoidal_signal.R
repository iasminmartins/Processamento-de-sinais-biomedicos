# This script generates a signal composed of three sinusoidal components 
# (10 Hz, 23 Hz, and 49 Hz) with unit amplitude. Gaussian noise (max 10% of peak value) 
# is added to the signal. The amplitude and phase spectra are computed using FFT.
# Sampling frequency: 700 Hz, Duration: 10 seconds.

# Load required libraries
library(dygraphs)
library(signal)
library(oce)

# --- Signal Parameters ---

fs <- 700  # Sampling frequency (Hz)
dt <- 1 / fs  # Sampling interval
t <- seq(from = 0, to = 10, by = dt)  # Time vector

# Frequencies of the sinusoidal components
fA <- 10
fB <- 23
fC <- 49

# Generate sinusoidal components
yA <- sin(2 * pi * fA * t)
yB <- sin(2 * pi * fB * t)
yC <- sin(2 * pi * fC * t)

# Sum of sinusoids
y <- yA + yB + yC

# Plot the original signal
dygraph(data.frame(t, y), main = "Sinusoids") %>% dyRangeSelector(c(0, 0.4))

# --- Add Gaussian Noise ---

y_noisy <- y + 0.08 * max(y) * rnorm(length(y))  # Noise with max amplitude 10% of peak

# Plot the noisy signal
dygraph(data.frame(t, y_noisy), main = "Sinusoids with Noise") %>% dyRangeSelector(c(0, 0.4))

# --- Frequency Domain Analysis ---

# Frequency resolution
delta_f <- fs / length(t)
f_nyquist <- (length(t) - 1) * delta_f  # Nyquist frequency
freq_vector <- seq(from = 0, to = f_nyquist, by = delta_f)

# Compute FFT
yFFT <- fft(y_noisy)

# --- Amplitude Spectrum ---
amplitude_spectrum <- Mod(yFFT)

# Plot amplitude spectrum
dygraph(data.frame(freq_vector, amplitude_spectrum),
        main = "Amplitude Spectrum", xlab = "Frequency (Hz)", ylab = "Amplitude") %>% 
  dyRangeSelector()

# --- Phase Spectrum ---
phase_spectrum <- atan2(Im(yFFT), Re(yFFT))

# Plot phase spectrum
dygraph(data.frame(freq_vector, phase_spectrum),
        main = "Phase Spectrum", xlab = "Frequency (Hz)", ylab = "Phase") %>% 
  dyRangeSelector(c(0, 2))

# --- Spectrogram Analysis ---

# Function to compute and plot spectrogram
compute_spectrogram <- function(nFFT, window_size, overlap, signal, fs) {
  spec <- specgram(x = signal, n = nFFT, Fs = fs, window = window_size, overlap = overlap)
  
  P <- abs(spec$S)
  P <- P / max(P)
  P <- 20 * log10(P)  # Convert to dB
  
  list(t = spec$t, f = spec$f, P = P)
}

# Compute spectrogram
spectrogram_data <- compute_spectrogram(2048, 256, 128, y, fs)

# Plot spectrogram
imagep(x = spectrogram_data$t,
       y = spectrogram_data$f,
       z = t(spectrogram_data$P),
       col = oce.colorsViridis,
       ylab = "Frequency (Hz)",
       xlab = "Time (s)",
       drawPalette = TRUE,
       decimate = FALSE)
