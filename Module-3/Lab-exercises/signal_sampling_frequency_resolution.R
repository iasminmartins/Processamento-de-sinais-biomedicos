# In this example, we show methods of increasing the number of samples

# Initial sampling frequency
fs1 <- 50
# Defining the sampling interval in seconds
dt1 <- 1/fs1
# Defining the time vector (in seconds)
t1 <- seq(0, 10, by = dt1)
# Defining a sine wave signal
f1 <- 3 # sine wave frequency
y1 <- sin(2 * pi * f1 * t1)
# Creating a data frame
df1 <- data.frame(t1, y1)
# Plotting the original signal
g <- ggplot(data = df1, aes(x = t1, y = y1)) +
  ggplot2::geom_line() +
  ggplot2::geom_point() +
  ggplot2::theme_bw() +
  ggplot2::xlab("Time (s)") +
  ggplot2::ylab("Amplitude")
print(g)

# Changing the sampling frequency to 25 Hz
fs2 <- 25 # sampling frequency in Hz
dt2 <- 1/fs2 # temporal resolution in seconds
t2 <- seq(0, 10, by = dt2) # time
f2 <- 3 # sine wave frequency
y2 <- sin(2 * pi * f2 * t2)
df2 <- data.frame(t2, y2)
# Plotting the signal with new sampling frequency
g2 <- ggplot(data = df2, aes(x = t2, y = y2)) +
  ggplot2::geom_line() +
  ggplot2::geom_point() +
  ggplot2::theme_bw() +
  ggplot2::xlab("Time (s)") +
  ggplot2::ylab("Amplitude")
print(g2)

# Further reducing the sampling frequency to 5 Hz
fs3 <- 5 # sampling frequency in Hz
dt3 <- 1/fs3 # temporal resolution in seconds
t3 <- seq(0, 10, by = dt3) # time
f3 <- 3 # sine wave frequency
y3 <- sin(2 * pi * f3 * t3)
df3 <- data.frame(t3, y3)
# Plotting the signal with lower sampling frequency
g3 <- ggplot(data = df3, aes(x = t3, y = y3)) +
  ggplot2::geom_line() +
  ggplot2::geom_point() +
  ggplot2::theme_bw() +
  ggplot2::xlab("Time (s)") +
  ggplot2::ylab("Amplitude")
print(g3)

