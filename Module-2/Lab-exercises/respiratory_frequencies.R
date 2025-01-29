# Plotting respiratory frequencies

# Loading necessary libraries
library(dygraphs)

# Define parameters for the signals
tf <- 60  # Time in seconds
dt <- 0.001  # Time step in seconds
t <- seq(from = 0, to = tf, by = dt)  # Generate time vector

# Frequency for a newborn's respiration (40 Hz)
f1 <- 40
y1 <- sin(2 * pi * t * f1)

# Frequency for a 10-year-old child's respiration (23 Hz)
f2 <- 23
y2 <- sin(2 * pi * t * f2)

# Set time window for plotting
tWindow <- c(10, 11)  # Define time window for data visualization

# Create a data frame for the first signal and plot
df1 <- data.frame(time = t, y1) 
dygraph(df1, group = "G1") %>% dyRangeSelector(dateWindow = tWindow)

# Create a data frame for the second signal and plot
df2 <- data.frame(time = t, y2)
dygraph(df2, group = "G1") %>% dyRangeSelector(dateWindow = tWindow)

# Change time window to zoom in and display the second signal with stem plot
tWindow <- c(10, 10.05)
df2 <- data.frame(time = t, y2)
dygraph(df2, group = "G1") %>% dyRangeSelector(dateWindow = tWindow) %>% dyOptions(stemPlot = TRUE)
