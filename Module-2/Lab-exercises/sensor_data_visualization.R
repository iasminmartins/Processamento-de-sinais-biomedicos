# Reading data from text, CSV, and EDF files

# Read data from a text file
df2 <- read.table("V16C1RCC92.txt", header = TRUE, sep = "\t", dec = ".", skip = 1, quote = "", comment.char = "")
df2.1 <- data.frame(time = df2$X.Time., df2$X.G1.X.)  # Create a dataframe for storage
dygraph(df2.1, main = "Angular Velocity (dps - degrees per second)") %>%
  dyRangeSelector() %>%
  dyAxis("x", label = "Time (s)") %>%
  dyAxis("y", label = "Amplitude")

# Read data from a CSV file
df3 <- read.csv("V16C1RCC92.csv", header = TRUE, sep = ";")
df3.1 <- data.frame(time = df3[[1]], amp = df3$X.A1.X.)  # Create a dataframe for storage
dygraph(df3.1, main = "Accelerometry (g)") %>%
  dyRangeSelector() %>%
  dyAxis("x", label = "Time (s)") %>%
  dyAxis("y", label = "Amplitude")

# Read data from an EDF file
library(edfReader)
CHdr <- readEdfHeader("V16C1RCC92.edf")  # Read header information
Signals <- readEdfSignals(CHdr)  # Read the signals

# Create time vector
tt <- seq(from = 0, to = 1049, by = 1) * 1 / Signals$`Ch: 0-:G1.X`$sRate

# Create a dataframe for storage
df4 <- data.frame(time = tt, amp = Signals$`Ch: 1-:G1.Y`$signal)

# Plot the data from EDF file
dygraph(df4, main = "Accelerometry - Y Axis (g)") %>%
  dyRangeSelector() %>%
  dyAxis("x", label = "Time (s)") %>%
  dyAxis("y", label = "Amplitude")
