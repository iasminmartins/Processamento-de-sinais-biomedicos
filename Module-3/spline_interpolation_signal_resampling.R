# This program demonstrates signal resampling through interpolation. 
# It uses spline interpolation to resample a sine wave signal at a lower frequency.

library(ggplot2)
library(plotly)

# Set the initial sampling frequency (in Hz)
fs <- 1000
dt <- 1/fs
tf <- 10 # Signal duration in seconds

# Create the time vector for the original signal
t <- seq(from=0, to=tf, by = dt)
# Generate the original sine wave signal with frequency 8 Hz
y <- sin(2*pi*t * 8)

# Define the new (lower) sampling frequency for resampling
fs1 <- 150
dt1 <- 1/fs1
t1 <- seq(from=0, to=tf, by=dt1)

# Apply spline interpolation to resample the signal
y1 <- spline(x=t, y=y, xout=t1)

# Create data frames for plotting
df <- data.frame(t, y)
df1 <- data.frame(time = t1, y1$y)

# Plot the original and resampled signals
p <- ggplot()
p <- p + geom_line(data = df, aes(x = t, y = y), color = "green") +
  geom_point(data = df, aes(x = t, y = y), color = "green")

# Plot the resampled signal (interpolated points and line)
p <- p + geom_point(data = df1, aes(x = time, y = y1.y)) +
  geom_line(data = df1, aes(x = time, y = y1.y))

# Display the plot interactively
ggplotly(p)
