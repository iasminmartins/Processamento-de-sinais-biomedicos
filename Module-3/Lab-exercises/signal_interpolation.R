# Creating an interpolation between previous data
signal_time_original <- df3$t3
signal_amplitude_original <- df3$y3
desired_discrete_time <- df1$t1

# Data frame containing the interpolation result
df4 <- data.frame(spline(x = signal_time_original, y = signal_amplitude_original, xout = desired_discrete_time))
signal_amplitude_interpolated <- df4$y
signal_time_interpolated <- df4$x

# Combine original and interpolated times
tt <- union(signal_time_original, signal_time_interpolated)
tt <- sort(tt)

# Prepare the data for plotting
df6 <- data.frame(time = tt)
df6$y1 <- NA
df6$y2 <- NA
df6$y1[tt %in% signal_time_original] <- signal_amplitude_original
df6$y2[tt %in% signal_time_interpolated] <- signal_amplitude_interpolated

# Plotting the interpolation
dygraph(df6, main = "Interpolation") %>%
  dyRangeSelector() %>%
  dyOptions(drawPoints = TRUE, connectSeparatedPoints = TRUE, pointSize = 2) %>%
  dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.2, hideOnMouseOut = FALSE)
