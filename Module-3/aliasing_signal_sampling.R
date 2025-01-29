# This program illustrates the concept of "aliasing" by sampling a sine wave signal
# at different frequencies and plotting the resulting signals to visualize the 
# aliasing effect when the sampling frequency is too low for accurate signal representation.

library(ggplot2)
library(plotly)

# Set the oscillation frequency (in Hz)
f <- 1 
# Set the sampling frequency
fs <- 100 
# Temporal resolution
dt <- 1/fs 
# Number of samples for the signal (signal duration of 5 seconds)
nmax <- floor(5/dt) 
# Create a vector for the sample number
n <- 0:nmax 
# Generate the sampled sine wave signal at 100 Hz
y <- sin(2*pi*f*n*dt) 

# Create a data frame to store time and amplitude values
dados <- data.frame(n*dt, y)
dados$amplitude1 <- NA
dados$tempo1 <- NA
dados$amplitude2 <- NA
dados$tempo2 <- NA

# Assign amplitude and time for sampling every 10th sample (for aliasing effect)
x1 <- 1
while(x1 < 501){
  dados$amplitude1[x1] <- dados$y[x1]
  dados$tempo1[x1] <- dados$n * dt[x1]
  x1 <- x1 + 10
}

# Assign amplitude and time for sampling every 40th sample (stronger aliasing effect)
x2 <- 1
while(x2 < 501){
  dados$amplitude2[x2] <- dados$y[x2]
  dados$tempo2[x2] <- dados$n * dt[x2]
  x2 <- x2 + 40
}

# Plot the original signal
g1 <- ggplot(data = dados, aes(x = n*dt, y = y)) + 
  geom_line() + geom_point() + 
  theme_bw() + 
  xlab("Time (s)") + 
  ylab("Amplitude")
ggplotly(g1)

# Plot the signal with sampling every 10th sample (first aliasing case)
g2 <- ggplot(data = dados, aes(x = tempo1, y = amplitude1)) + 
  geom_line() + geom_point() + 
  theme_bw() + 
  xlab("Time (s)") + 
  ylab("Amplitude")
ggplotly(g2)

# Plot the signal with sampling every 40th sample (stronger aliasing case)
g3 <- ggplot(data = dados, aes(x = tempo2, y = amplitude2)) + 
  geom_line() + geom_point() + 
  theme_bw() + 
  xlab("Time (s)") + 
  ylab("Amplitude")
ggplotly(g3)
