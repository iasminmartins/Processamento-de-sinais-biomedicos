# Spline Interpolation Example
fs <- 500  # Hz
dt <- 1 / fs  # sec
tf <- 5  # sec
t <- seq(from = 0, to = tf, by = dt)
y <- sin(2 * pi * t * 10)

# New sampling frequency for interpolation
fs1 <- 100  # Hz
dt1 <- 1 / fs1
t1 <- seq(from = 0, to = tf, by = dt1)

# Perform spline interpolation
y1 <- spline(x = t, y = y, xout = t1)

# Prepare data for plotting
df <- data.frame(t, y)
df1 <- data.frame(time = t1, y1$y)

# Plot using ggplot
p <- ggplot()
p <- p + geom_line(data = df, aes(x = t, y = y), color = "red") +
  geom_point(data = df, aes(x = t, y = y), color = "red")
p <- p + geom_point(data = df1, aes(x = time, y = y1.y)) +
  geom_line(data = df1, aes(x = time, y = y1.y))

# Create an interactive plot using plotly
ggplotly(p)