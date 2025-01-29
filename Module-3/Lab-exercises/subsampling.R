# Subsampling Example: Increase in the time interval between samples
indx <- seq(from = 1, to = length(df1$Time), by = 10)
dfsub <- data.frame(time = df1$Time[indx], y1 = df1$EMG1[indx])

# Graph for subsampled data
dygraph(data.frame(time = dfsub$time, y1 = dfsub$y1, y2 = dfsub$y1), group = "SUB") %>%
  dyRangeSelector() %>%
  dySeries("y1", stemPlot = TRUE)

# Discarding 4 samples every 5
i <- seq(from = 1, to = tf * fs + 1, by = 5)
dt <- 1 / 1000

# Graph for subsampled signal at 200 Hz
dygraph(data.frame(tn = t[i], yn = y[i], yns = y[i]), xlab = "Time (seconds)", ylab = "Amplitude", main = "Subsampled signal at 200 Hz") %>%
  dySeries(stemPlot = TRUE) %>%
  dyRangeSelector(c((517 - 1) * dt, (600 - 1) * dt))
