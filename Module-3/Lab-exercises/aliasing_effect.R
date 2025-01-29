# Aliasing Effect Example
# This example demonstrates the aliasing effect, which occurs when the sampling frequency is too low 
# (less than twice the signal frequency), leading to an incorrect representation of the signal's frequency.

library(ggplot2)
library(plotly)

fs <- 40 # Sampling frequency
dt <- 1/fs # Temporal resolution
t <- seq(from = 0, to = 5, by = dt) # Time vector
f <- 1 # Oscillation frequency
ys <- sin(2*pi*f*t) # Desired signal
p <- ggplot(data.frame(t, ys), aes(t, ys)) + geom_line() + theme_bw() + xlab("Time") + ylab("Amplitude")
ggplotly(p)

# Shows the impression that samples are almost continuously captured due to the small temporal resolution.
fs2 <- 100 # Desired sampling frequency
dt2 <- 1/fs2 # Resolution for the signal at fs2
nmax2 <- floor(5/dt2) # Number of samples for the sampled signal
n2 <- 0:nmax2 # Sample indices
ys2 <- sin(2*pi*f*n2*dt2) # Sampled signal
p <- ggplot(data.frame(n2*dt2, ys2), aes(n2*dt2, ys2)) + geom_line() + geom_point() + theme_bw() + xlab("Time") + ylab("Amplitude")
ggplotly(p) # Plotting the graph

# Even for 20 Hz, the sampling remains satisfactory.
fs3 <- 20 # Sampling frequency
dt3 <- 1/fs3 # Resolution for the sampled signal
nmax3 <- floor(5/dt3) # Number of samples for the sampled signal
n3 <- 0:nmax3 # Sample indices
ys3 <- sin(2*pi*f*n3*dt3) # Sampled signal
p <- ggplot(data.frame(n3*dt3, ys3), aes(n3*dt3, ys3)) + geom_line() + geom_point() + theme_bw() + xlab("Time") + ylab("Amplitude")
ggplotly(p) # Plotting the graph

# Aliasing occurs when the sampling frequency is lower than twice the signal frequency, resulting in a misleading representation.
fs4 <- 0.75 # Sampling frequency
dt4 <- 1/fs4 # Temporal resolution
nmax4 <- floor(5/dt4) # Number of samples
n4 <- 0:nmax4 # Sample number vector
ys4 <- sin(2*pi*f*n4*dt4) # Sampled signal
df11 <- data.frame(time=t, y=ys)
df2 <- data.frame(time=n4*dt4, y=ys4)
p <- ggplot(df11, aes(time, y)) + geom_line() + geom_point(data=df2, aes(time, y)) + theme_bw() + xlab("Time") + ylab("Amplitude")
ggplotly(p)

yc <- sin(2*pi*0.25*t) # Sine wave of 0.25 Hz
df11 <- data.frame(time=t, y=yc)
df2 <- data.frame(time=n4*dt4, y=ys4)
p <- ggplot(df11, aes(time, y)) + geom_line() + geom_point(data=df2, aes(time, y)) + theme_bw() + xlab("Time") + ylab("Amplitude")
ggplotly(p)
