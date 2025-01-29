# This script simulates respiratory waveforms for various age groups based on typical breathing rates,
# generating sine wave signals to represent breathing cycles over a specified time period.
# It uses ggplot to plot individual graphs for each of the simulated signals.

# Load required libraries
library(ggplot2)

# Define simulation parameters
total_time <- 60       # Total simulation time (seconds)
time_step <- 1         # Time step (seconds)
time <- seq(from = 0, to = total_time, by = time_step)  # Generate time sequence

# Define respiratory rates (breaths per minute) for different age groups
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

# Create data frames for each waveform to be used in plotting
df_newborn <- data.frame(time = time, respiration = waveform_newborn)
df_six_months <- data.frame(time = time, respiration = waveform_six_months)
df_three_years <- data.frame(time = time, respiration = waveform_three_years)
df_six_years <- data.frame(time = time, respiration = waveform_six_years)
df_ten_years <- data.frame(time = time, respiration = waveform_ten_years)
df_adult <- data.frame(time = time, respiration = waveform_adult)
df_elderly_65 <- data.frame(time = time, respiration = waveform_elderly_65)
df_elderly_80 <- data.frame(time = time, respiration = waveform_elderly_80)

# Plotting the respiratory waveforms for each group with ggplot and labels for the axes
ggplot(data = df_newborn, aes(x = time, y = respiration)) + 
  geom_line() + 
  labs(x = "Time (s)", y = "Respiratory Rate (breaths per minute)") + 
  ggtitle("Newborn Respiratory Cycle")

ggplot(data = df_six_months, aes(x = time, y = respiration)) + 
  geom_line() + 
  labs(x = "Time (s)", y = "Respiratory Rate (breaths per minute)") + 
  ggtitle("6 Months Respiratory Cycle")

ggplot(data = df_three_years, aes(x = time, y = respiration)) + 
  geom_line() + 
  labs(x = "Time (s)", y = "Respiratory Rate (breaths per minute)") + 
  ggtitle("3 Years Respiratory Cycle")

ggplot(data = df_six_years, aes(x = time, y = respiration)) + 
  geom_line() + 
  labs(x = "Time (s)", y = "Respiratory Rate (breaths per minute)") + 
  ggtitle("6 Years Respiratory Cycle")

ggplot(data = df_ten_years, aes(x = time, y = respiration)) + 
  geom_line() + 
  labs(x = "Time (s)", y = "Respiratory Rate (breaths per minute)") + 
  ggtitle("10 Years Respiratory Cycle")

ggplot(data = df_adult, aes(x = time, y = respiration)) + 
  geom_line() + 
  labs(x = "Time (s)", y = "Respiratory Rate (breaths per minute)") + 
  ggtitle("Adult Respiratory Cycle")

ggplot(data = df_elderly_65, aes(x = time, y = respiration)) + 
  geom_line() + 
  labs(x = "Time (s)", y = "Respiratory Rate (breaths per minute)") + 
  ggtitle("Elderly (≥ 65 years) Respiratory Cycle")

ggplot(data = df_elderly_80, aes(x = time, y = respiration)) + 
  geom_line() + 
  labs(x = "Time (s)", y = "Respiratory Rate (breaths per minute)") + 
  ggtitle("Elderly (≥ 80 years) Respiratory Cycle")
