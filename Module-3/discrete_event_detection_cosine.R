# This code generates a discrete event graph over time, where the peaks of the cosine signal are identified and plotted.
# The 'findpeaks' function is used to locate the positions of the peaks in the signal, which are then visualized.

library(pracma)

# Sampling frequency in Hz
fs <- 950 

# Temporal resolution in seconds
dt <- 1/fs 

# Final time in seconds
tf <- 6 

# Time vector from 0 to tf with step size dt
t <- seq(from = 0, to = tf, by = dt)

# Signal frequency in Hz
f <- 22

# Create the signal (cosine wave)
y <- cos(2*pi*f*t)

# Create a data frame containing the signal
d1 <- data.frame(t, y)

# Threshold for peak detection (99% of the maximum signal amplitude)
th <- max(d1$y, na.rm = TRUE) * 0.99

# Find the peaks in the signal
pp <- findpeaks(d1$y, minpeakheight = th)

# Store the indices of the peaks in a variable
indxpeaks <- pp[, 2]

# Add a column for peaks in the data frame
d1$peaks <- NA
d1$peaks[indxpeaks] <- d1$y[indxpeaks]

# Plot the graph, including the identified peaks
dygraph(d1, group = "Discrete") %>%
  dySeries("peaks", stemPlot = TRUE) %>%
  dyAxis("y", valueRange = c(-1.5, 1.5)) %>%
  dyLegend(width = 400) %>%
  dyLimit(th, "Max", strokePattern = "solid", color = "blue") %>%
  dyRangeSelector(dateWindow = c((300-1) * dt, (600-1) * dt))
