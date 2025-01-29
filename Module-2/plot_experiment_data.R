# Visualizes experimental data of amplitude vs. time from Excel, CSV, or EDF files

library(openxlsx)
library(ggplot2)
library(edfReader)

# XLS files
# Aduccao data
df1 <- read.xlsx("aduccao.xlsx", sheet = 1, skipEmptyRows = FALSE)
qplot(df1$`[Time]`, df1$`[G1.X]`, geom=c("point", "line")) + 
  labs(x = "Time (s)", y = "Amplitude (g)")

# Flexao data
df2 <- read.xlsx("flexao.xlsx", sheet = 1, skipEmptyRows = FALSE)
qplot(df2$`[Time]`, df2$`[G1.X]`, geom=c("point", "line")) + 
  labs(x = "Time (s)", y = "Amplitude (g)")

# Rotacao data
df3 <- read.xlsx("rotacao.xlsx", sheet = 1, skipEmptyRows = FALSE)
qplot(df3$`[Time]`, df3$`[G1.X]`, geom=c("point", "line")) + 
  labs(x = "Time (s)", y = "Amplitude (g)")

# CSV files (commented out)
# Aduccao data
# df4 <- read.csv("aduccao.csv", header = TRUE, sep = ";")
# df4.1 <- data.frame(time = df4[[1]], amp = df4$X.A1.X.)
# qplot(df4.1$`time`, df4.1$`amp`) + labs(x = "Time (s)", y = "Amplitude (g)")

# Flexao data
# df5 <- read.csv("flexao.csv", header = TRUE, sep = ";")
# df5.1 <- data.frame(time = df5[[1]], amp = df5$X.A1.X.)
# qplot(df5.1$`time`, df5.1$`amp`) + labs(x = "Time (s)", y = "Amplitude (g)")

# Rotacao data
# df6 <- read.csv("rotacao.csv", header = TRUE, sep = ";")
# df6.1 <- data.frame(time = df6[[1]], amp = df6$X.A1.X.)
# qplot(df6.1$`time`, df6.1$`amp`) + labs(x = "Time (s)", y = "Amplitude (g)")

# EDF files (commented out)
# Aduccao data
# df7.1 <- readEdfHeader("Aduccao.edf")
# df7.2 <- readEdfSignals(df7.1)
# tt = seq(from = 0, to = 499, by = 1) * 1 / Signals$`Ch: 0-:G1.X`$sRate
# df7 <- data.frame(time = tt, amp = Signals$`Ch: 1-:G1.Y`$signal)
# qplot(df7$`time`, df7$`amp`) + labs(x = "Time (s)", y = "Amplitude (g)")

# Flexao data
# df8.1 <- readEdfHeader("Flexao.edf")
# df8.2 <- readEdfSignals(df8.1)
# tt = seq(from = 0, to = 499, by = 1) * 1 / Signals$`Ch: 0-:G1.X`$sRate
# df8 <- data.frame(time = tt, amp = Signals$`Ch: 1-:G1.Y`$signal)
# qplot(df8$`time`, df8$`amp`) + labs(x = "Time (s)", y = "Amplitude (g)")

# Rotacao data
# df9.1 <- readEdfHeader("Rotacao.edf")
# df9.2 <- readEdfSignals(df9.1)
# tt = seq(from = 0, to = 499, by = 1) * 1 / Signals$`Ch: 0-:G1.X`$sRate
# df9 <- data.frame(time = tt, amp = Signals$`Ch: 1-:G1.Y`$signal)
# qplot(df9$`time`, df9$`amp`) + labs(x = "Time (s)", y = "Amplitude (g)")
