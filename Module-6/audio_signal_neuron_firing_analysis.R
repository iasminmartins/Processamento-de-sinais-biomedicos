# Exercise 1
# Record five audio signals for the word "yes" and five for the word "no" using Audacity.
# Label and save each segment of the commands in separate files, resulting in a total of 10 files.

# Load necessary libraries
library(tuneR)
library(dygraphs)
library(agricolae)  # For skewness and kurtosis calculations

# Define the directory and file names
directory <- "C:/Users/Acer/Documents/module6/"
file_names <- c("1.wav", "2.wav", "3.wav", "4.wav", "5.wav", "a.wav", "b.wav", "c.wav", "d.wav", "e.wav")
file_paths <- file.path(directory, file_names)

# Function to extract data from .wav files
extract_data <- function(file_path) {
  signal <- readWave(file_path)  # Read audio file
  fs <- signal@samp.rate         # Sampling rate
  dt <- 1 / fs                   # Temporal resolution
  yE <- signal@left              # Left channel
  yD <- signal@right             # Right channel
  t <- seq(0, (length(yE) - 1) * dt, by = dt)
  
  data.frame(time = t, yE = yE, yD = yD)
}

# Function to plot .wav signals
plot_signal <- function(file_path) {
  signal <- readWave(file_path)
  fs <- signal@samp.rate
  dt <- 1 / fs
  yE <- signal@left
  yD <- signal@right
  t <- seq(0, (length(yE) - 1) * dt, by = dt)
  df <- data.frame(time = t, yE = yE, yD = yD)

  dygraph(df, main = basename(file_path)) %>% dyRangeSelector()
}

# Extract data and create plots for all files
data_list <- lapply(file_paths, extract_data)
plot_list <- lapply(file_paths, plot_signal)

# Exercise 2
# Calculate statistics: mean, variance, skewness, kurtosis.
# Organize results in a table and estimate the variance of each statistic.
# Analyze stationarity and ergodicity.

# Function to calculate statistics
calculate_statistics <- function(data_list) {
  stats <- lapply(data_list, function(df) {
    list(
      mean_yE = mean(df$yE),
      var_yE = var(df$yE),
      skewness_yE = skewness(df$yE),
      kurtosis_yE = kurtosis(df$yE),
      mean_yD = mean(df$yD),
      var_yD = var(df$yD),
      skewness_yD = skewness(df$yD),
      kurtosis_yD = kurtosis(df$yD)
    )
  })
  do.call(rbind, lapply(stats, as.data.frame))
}

# Compile statistics
stats <- calculate_statistics(data_list)
stats_table <- data.frame(
  Audio = file_names,
  Mean_Left = stats$mean_yE,
  Variance_Left = stats$var_yE,
  Skewness_Left = stats$skewness_yE,
  Kurtosis_Left = stats$kurtosis_yE,
  Mean_Right = stats$mean_yD,
  Variance_Right = stats$var_yD,
  Skewness_Right = stats$skewness_yD,
  Kurtosis_Right = stats$kurtosis_yD
)

print(stats_table)

# Function to analyze stationarity and ergodicity
analyze_stationarity <- function(stats_table) {
  list(
    stationary = all(diff(stats_table$Mean_Left) == 0 & diff(stats_table$Variance_Left) == 0),
    ergodic = var(stats_table$Mean_Left) < 1e-5
  )
}

# Perform stationarity and ergodicity analysis
stationarity_yes <- analyze_stationarity(stats_table[1:5, ])
stationarity_no <- analyze_stationarity(stats_table[6:10, ])

cat("Stationarity and ergodicity analysis for 'yes':\n")
print(stationarity_yes)
cat("\nStationarity and ergodicity analysis for 'no':\n")
print(stationarity_no)

# Exercise 3
# Use the maximum value of cross-correlation to compare voice commands.

# Vectors containing left-side values for YES and NO
yList <- lapply(1:10, function(i) data_list[[i]]$yE)

# Function to calculate maximum cross-correlation with lag of 10,000 samples
calculate_max_ccf <- function(signal1, signal2, lag.max = 10000) {
  ccf_result <- ccf(signal1, signal2, lag.max = lag.max, plot = FALSE)
  return(max(ccf_result$acf))
}

# Cross-correlation calculations
cross_corr_values <- matrix(NA, nrow = 10, ncol = 10)
for (i in 1:10) {
  for (j in 1:10) {
    cross_corr_values[i, j] <- calculate_max_ccf(yList[[i]], yList[[j]])
  }
}

# Create table for the cross-correlation results
table <- data.frame(
  Audio = c("YES-1", "YES-2", "YES-3", "YES-4", "YES-5", "NO-1", "NO-2", "NO-3", "NO-4", "NO-5"),
  cross_corr_values
)

# Display the table
library(knitr)
knitr::kable(table)

# Explanation
# A voice control system can be implemented based on the cross-correlation difference:
# If the cross-correlation value is greater than 0.5, classify as "YES."
# If the cross-correlation value is less than or equal to 0.5, classify as "NO."

# Exercise 4
# Considering the evaluation of three groups of neurons, with the characteristics below:
# E1: firing mean = 53 ms; standard deviation = 50 ms
# E2: firing mean = 100 ms; standard deviation = 35 ms
# E3: firing mean = 53 ms; standard deviation = 15 ms
# Tip: The interval between firings is a point process with a Gaussian distribution (Use the rnorm function in R to generate firing times)

# 4.1 Plot the firing diagram for the three neuron groups during 10 seconds, 
# according to the rules given in the table, where the numerical values 
# indicate the start and end times (in seconds) of the firings of the groups E1, E2, and E3. 
# Example: Group E1 fires between 1 and 2 s, between 5 and 7 s, and remains at rest 
# during the entire simulation interval (from 0 to 10 seconds). 
# The simulation should be done with a sampling rate of 10 kHz.

fs <- 10000  # Sampling frequency
dt <- 1 / fs  # Temporal resolution
t <- seq(from=0, to=10, by=dt)  # Time vector
df <- data.frame(t, E1 = NA, E2 = NA, E3 = NA)

# E1 group: firing between 1-2s and 5-7s
indx1 <- which(t >= 1 & t <= 2 | t >= 5 & t <= 7)
df$E1[indx1] <- rnorm(length(indx1), mean = 0.053, sd = 0.05)

# E2 group: firing between 2-4s and 7-9s
indx2 <- which(t >= 2 & t <= 4 | t >= 7 & t <= 9)
df$E2[indx2] <- rnorm(length(indx2), mean = 0.1, sd = 0.035)

# E3 group: firing between 1-3s and 9-10s
indx3 <- which(t >= 1 & t <= 3 | t >= 9 & t <= 10)
df$E3[indx3] <- rnorm(length(indx3), mean = 0.053, sd = 0.015)

# Plot the firing diagram for all groups
dygraph(df[c("t", "E1", "E2", "E3")]) %>% dyRangeSelector()

# Plot individual firing diagrams for each group
dygraph(df[c("t", "E1")]) %>% dyRangeSelector()
dygraph(df[c("t", "E2")]) %>% dyRangeSelector()
dygraph(df[c("t", "E3")]) %>% dyRangeSelector()

# 4.2 Generate histograms of the intervals between firings for the neuron groups E1, E2, and E3.
# Three histograms should be generated (one for each group).
hist(df$E1)
hist(df$E2)
hist(df$E3)