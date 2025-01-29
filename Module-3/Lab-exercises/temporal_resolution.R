# Temporal Resolution Simulation
library(openxlsx)
library(dygraphs)

# Reads data from Excel
df1 <- read.xlsx("Data1.xlsx", sheet = 1, skipEmptyRows = FALSE, rows = c(1:10000))

# Calculates the temporal resolution (in seconds)
dt <- df1$Tempo[2] - df1$Tempo[1]

# Graph format
dygraph(data.frame(time = df1$Time, y1 = df1$EMG1, y2 = df1$EMG1), group = "EMG") %>%
  dyRangeSelector() %>%
  dySeries("y1", stemPlot = TRUE)
