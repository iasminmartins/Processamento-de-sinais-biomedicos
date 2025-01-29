# This illustrates both analog and discrete signals in the same graph.
# The analog signal is a continuous cosine wave, and the discrete signal is obtained by sampling the analog signal at a given frequency.

library(dygraphs)

# Oscillation frequency of the signal
f <- 25 # frequency in Hz

# Sampling frequency (Hz)
fs <- 500 # sampling frequency in Hz

# Temporal resolution (seconds)
dt <- 1/fs 

# Final time in seconds
tf <- 5

# Time vector from 0 to tf with step size dt
t <- seq(from = 0, to = tf, by = dt)

# Create the analog signal (cosine wave)
y <- cos(2*pi*f*t)

# Create a dataframe containing the signal
df <- data.frame(t, y)

# Plotting the graph
dygraph(data.frame(time = df$t, y1 = df$y, y2 = df$y), 
        xlab = "Time (seconds)", 
        ylab = "Amplitude", 
        main = "Discrete vs. Analog Signal", 
        group = "S") %>%
  dyRangeSelector(c(0.5, 0.85)) %>%
  dySeries("y1", color = "black", stemPlot = TRUE) %>%
  dySeries("y2", color = "red", stemPlot = FALSE)


