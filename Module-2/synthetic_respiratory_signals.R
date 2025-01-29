# This script simulates respiratory waveforms for various age groups based on typical breathing rates, 
# generating sine wave signals to represent breathing cycles over a specified time period

# Load required libraries
library(dygraphs)
library(ggplot2)

# Define simulation parameters
total_time <- 60       # Total simulation time (in seconds)
time_step <- 0.001     # Time step (in seconds)
time <- seq(from = 0, to = total_time, by = time_step)  # Generate time sequence

# Define respiratory rates for different age groups (breaths per minute)
rate_newborn <- 35      # Newborn: 30-40 breaths per minute
waveform_newborn <- sin(2 * pi * time * rate_newborn)

rate_six_months <- 30   # 6 months: 25-40 breaths per minute
waveform_six_months <- sin(2 * pi * time * rate_six_months)

rate_three_years <- 25  # 3 years: 20-30 breaths per minute
waveform_three_years <- sin(2 * pi * time * rate_three_years)

rate_six_years <- 20    # 6 years: 18-25 breaths per minute
waveform_six_years <- sin(2 * pi * time * rate_six_years)

rate_ten_years <- 23    # 10 years: 17-23 breaths per minute
waveform_ten_years <- sin(2 * pi * time * rate_ten_years)

rate_adult <- 15        # Adult: 12-18 breaths per minute
waveform_adult <- sin(2 * pi * time * rate_adult)

rate_elderly_65 <- 18   # Elderly (≥ 65 years): 12-28 breaths per minute
waveform_elderly_65 <- sin(2 * pi * time * rate_elderly_65)

rate_elderly_80 <- 10   # Elderly (≥ 80 years): 10-30 breaths per minute
waveform_elderly_80 <- sin(2 * pi * time * rate_elderly_80)

# Define a time window for visualization (in seconds)
time_window <- c(10, 11)

# Create a data frame for each age group's respiratory signal
data_newborn <- data.frame(time = time, signal = waveform_newborn)
data_six_months <- data.frame(time = time, signal = waveform_six_months)
data_three_years <- data.frame(time = time, signal = waveform_three_years)
data_six_years <- data.frame(time = time, signal = waveform_six_years)
data_ten_years <- data.frame(time = time, signal = waveform_ten_years)
data_adult <- data.frame(time = time, signal = waveform_adult)
data_elderly_65 <- data.frame(time = time, signal = waveform_elderly_65)
data_elderly_80 <- data.frame(time = time, signal = waveform_elderly_80)

# Plot the respiratory signal for each age group

# Newborn
dygraph(data_newborn, group = "Group1", xlab = "Time (s)", ylab = "Respiratory Frequency (breaths per minute)") %>%
  dyRangeSelector(dateWindow = time_window)

# 6 Months
dygraph(data_six_months, group = "Group2", xlab = "Time (s)", ylab = "Respiratory Frequency (breaths per minute)") %>%
  dyRangeSelector(dateWindow = time_window)

# 3 Years
dygraph(data_three_years, group = "Group3", xlab = "Time (s)", ylab = "Respiratory Frequency (breaths per minute)") %>%
  dyRangeSelector(dateWindow = time_window)

# 6 Years
dygraph(data_six_years, group = "Group4", xlab = "Time (s)", ylab = "Respiratory Frequency (breaths per minute)") %>%
  dyRangeSelector(dateWindow = time_window)

# 10 Years
dygraph(data_ten_years, group = "Group5", xlab = "Time (s)", ylab = "Respiratory Frequency (breaths per minute)") %>%
  dyRangeSelector(dateWindow = time_window)

# Adult
dygraph(data_adult, group = "Group6", xlab = "Time (s)", ylab = "Respiratory Frequency (breaths per minute)") %>%
  dyRangeSelector(dateWindow = time_window)

# Elderly (≥ 65 years)
dygraph(data_elderly_65, group = "Group7", xlab = "Time (s)", ylab = "Respiratory Frequency (breaths per minute)") %>%
  dyRangeSelector(dateWindow = time_window)

# Elderly (≥ 80 years)
dygraph(data_elderly_80, group = "Group8", xlab = "Time (s)", ylab = "Respiratory Frequency (breaths per minute)") %>%
  dyRangeSelector(dateWindow = time_window)
