# Discrete Event Detection Example
# This example demonstrates the detection of discrete events, which occur at specific time points in a signal. 
# We identify events at the peaks of a signal above a defined threshold, using an EMG signal in this case.

library(pracma)  # Package for using the findpeaks function
library(htmltools)

# Define the threshold for event detection
th <- max(df1$EMG1, na.rm = TRUE) * 0.4  # Threshold at 40% of max value

# Detect peaks in the EMG signal
pp <- findpeaks(df1$EMG1, minpeakheight = th)

# Extract the indices where peaks occur
indxpeaks <- pp[, 2]

# Initialize a column to store peak data
df1$peaks <- NA
df1$peaks[indxpeaks] <- df1$EMG1[indxpeaks]

# Create the first dygraph with the original EMG signal and marked peaks
d1 <- dygraph(df1, group = "E1") %>%
  dySeries("peaks", stemPlot = TRUE) %>%
  dyAxis("y", valueRange = c(-1, 1)) %>%
  dyLegend(width = 400) %>%
  dyLimit(th, "Max", strokePattern = "solid", color = "blue") %>%
  dyRangeSelector()

# Create the second dygraph showing only the peaks
d2 <- dygraph(df1[c("Time", "peaks")], main = "Discrete Events", group = "E1") %>%
  dySeries("peaks", stemPlot = TRUE) %>%
  dyAxis("y", valueRange = c(-1, 1)) %>%
  dyLegend(width = 400) %>%
  dyLimit(th, "Max", strokePattern = "solid", color = "blue") %>%
  dyRangeSelector()

# Combine the two graphs
dy_graph <- list(d1, d2)

# Render the graphs
htmltools::browsable(htmltools::tagList(dy_graph))
