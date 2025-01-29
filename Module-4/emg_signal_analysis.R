# This script performs statistical analysis of electromyographic (EMG) signals
# Steps include peak detection, statistical parameter estimation, and visualization of signal variation over time

# Load necessary libraries
library(rmarkdown)  # For rendering markdown files
library(dygraphs)   # For interactive time-series visualizations
library(pracma)     # For peak detection and mathematical operations

# Step 1: Load the data
# The file "DadosM4-1.txt" contains the EMG signals
df1 <- read.table("DadosM4-1.txt", header = FALSE, sep = " ", skip = 6)
names(df1) <- c("AccX", "AccY", "MusTibial", "MuscTriceps")  # Assign column names for clarity

# Step 2: Add a time vector to the dataframe
fs <- 500                  # Sampling frequency in Hz
dt <- 1 / fs               # Time step in seconds
t <- seq(from = 0, to = dt * (length(df1$AccX) - 1), by = dt)  # Generate time vector
df1 <- cbind(time = t, df1)  # Add time column to the dataframe

# Step 3: Detect peaks in the AccY signal
th <- max(df1$AccY, na.rm = TRUE) * 0.9  # Set threshold at 90% of the maximum peak amplitude
pp <- findpeaks(df1$AccY, minpeakheight = th)  # Identify peaks
indxpeaks <- pp[, 2]  # Extract indices of detected peaks
df1$peaks <- NA       # Initialize a column for peaks
df1$peaks[indxpeaks] <- df1$AccY[indxpeaks]  # Mark detected peaks in the dataframe

# Step 4: Visualize AccY signal with detected peaks
dygraph(df1[c("time", "AccY", "peaks")], group = "E1") %>%
  dyOptions(connectSeparatedPoints = TRUE) %>%
  dySeries("peaks", stemPlot = TRUE) %>%
  dyLegend(width = 400) %>%
  dyLimit(th, "Threshold (90% of Max)", strokePattern = "solid", color = "black") %>%
  dyRangeSelector()

# Step 5: Plot peaks above 90% threshold
dygraph(df1[c("time", "peaks")], main = "Peaks Above 90% in AccY", group = "E1") %>%
  dyOptions(connectSeparatedPoints = TRUE) %>%
  dySeries("peaks", stemPlot = TRUE) %>%
  dyLegend(width = 400) %>%
  dyLimit(th, "Threshold (90% of Max)", strokePattern = "solid", color = "black") %>%
  dyRangeSelector()

# Step 6: Calculate statistical parameters for the tibial muscle signal
z <- df1$MusTibial  # Select tibial muscle signal
Nwnd <- 500         # Window size in milliseconds
indx1 <- seq(from = 1, to = length(z), by = Nwnd)  # Define window indices

# Calculate mean
mean_values <- sapply(indx1, function(i) mean(z[i:(i + Nwnd - 1)], na.rm = TRUE))

# Calculate median
median_values <- sapply(indx1, function(i) median(z[i:(i + Nwnd - 1)], na.rm = TRUE))

# Calculate mode
calculate_mode <- function(values) {
  vmax <- names(table(values))[which.max(table(values))]
  return(as.numeric(vmax))
}
mode_values <- sapply(indx1, function(i) calculate_mode(z[i:(i + Nwnd - 1)]))

# Calculate amplitude (max - min)
amplitude_values <- sapply(indx1, function(i) {
  window <- z[i:(i + Nwnd - 1)]
  return(max(window, na.rm = TRUE) - min(window, na.rm = TRUE))
})

# Calculate variance
variance_values <- sapply(indx1, function(i) var(z[i:(i + Nwnd - 1)], na.rm = TRUE))

# Calculate coefficient of variation
cv_values <- sapply(indx1, function(i) {
  window <- z[i:(i + Nwnd - 1)]
  return(100 * sd(window, na.rm = TRUE) / mean(window, na.rm = TRUE))
})

# Calculate interquartile range (IQR)
iqr_values <- sapply(indx1, function(i) {
  window <- z[i:(i + Nwnd - 1)]
  return(IQR(window, na.rm = TRUE))
})

# Step 7: Plot median variation over time
y <- df1$MusTibial  # Select tibial muscle signal
N <- length(indx1)
dfest <- data.frame(time = numeric(N - 1), median = numeric(N - 1))

# Generate a time vector centered on each window
for (i in 1:(N - 1)) {
  dfest$time[i] <- (indx1[i] + (indx1[i + 1] - indx1[i]) / 2) * dt
  dfest$median[i] <- median(y[indx1[i]:indx1[i + 1]], na.rm = TRUE)
}

# Plot median vs time
dygraph(dfest, main = "Median Variation Over Time", xlab = "Time (s)", ylab = "Median") %>%
  dyRangeSelector()