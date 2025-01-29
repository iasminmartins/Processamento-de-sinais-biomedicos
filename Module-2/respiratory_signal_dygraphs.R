# Code for plotting a simulated respiratory signal using dyStemSeries
# The signal represents the breathing rate of a newborn (35 breaths per minute) 
# The code uses dygraphs to visualize the respiratory waveform and dyRangeSelector for interactive range selection

# Load required libraries
library(dygraphs)
library(ggplot2)

# Define simulation parameters
total_time <- 60   # Total simulation time (in seconds)
time_step <- 0.001 # Time step (in seconds)
time <- seq(from = 0, to = total_time, by = time_step)  # Generate time sequence

# Define respiratory rate (breaths per minute) for newborn
rate_newborn <- 35
waveform_newborn <- sin(2 * pi * time * rate_newborn)

# Create a data frame for the signal
data <- data.frame(time = time, respiration = waveform_newborn)

# Plot the respiratory signal using dyStemSeries
time_window <- c(10, 10.05)  # Define the time window for the plot
dygraph(data, group = "G") %>% 
  dyRangeSelector(dateWindow = time_window) %>% 
  dyStemSeries("respiration")

# Explanation: 
# The temporal gap between each sample occurs because the signal is discretized at regular time intervals (e.g., every 0.001 seconds).
# In real-world biological signal acquisition, the signal is sampled at specific intervals, leading to discrete points
# rather than a continuous representation, which is why the graph shows individual points rather than a smooth curve.