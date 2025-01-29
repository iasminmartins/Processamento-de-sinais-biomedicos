# Sampled Signals - In this graph, starting from the defined discrete time vector, various signals can be created using mathematical models.

# Load necessary libraries
library(tuneR)
library(dygraphs)

# Define parameters
freq1 <- 10        # Frequency for signals
fs <- 500          # Sampling frequency (Hz)
tf <- 5            # Signal duration (seconds)
dt <- 1/fs         # Time step

# Create time vector
t <- seq(from = 0, to = tf, by = dt)

# 1. Sawtooth signal
y1 <- sawtooth(freq1, samp.rate = fs, duration = tf + dt, xunit = "time")@left
d1 <- dygraph(data.frame(time = t, y1)) %>%
  dyRangeSelector() %>%
  dyOptions(drawPoints = TRUE, pointSize = 2)

# 2. White noise signal
y2 <- noise(kind = "white", samp.rate = fs, duration = tf + dt, xunit = "time")@left
d2 <- dygraph(data.frame(time = t, y2)) %>%
  dyRangeSelector()

# 3. Pulse signal
y3 <- pulse(freq1, samp.rate = fs, duration = tf + dt, xunit = "time")@left
d3 <- dygraph(data.frame(time = t, y3)) %>%
  dyRangeSelector() %>%
  dySeries("y3", stemPlot = TRUE)

# 4. Square wave signal
y4 <- square(freq1, samp.rate = fs, duration = tf + dt, xunit = "time")@left
d4 <- dygraph(data.frame(time = t, y4)) %>%
  dyRangeSelector() %>%
  dyOptions(drawPoints = TRUE, pointSize = 2)

# Combine all the graphs into a list
dy_graph <- list(d1, d2, d3, d4)

# Display the graphs in the browser
htmltools::browsable(htmltools::tagList(dy_graph))
