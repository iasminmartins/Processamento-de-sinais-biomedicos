# This program simulates quantization error using rounding functions. 
# It loads the dataset collected in class with inertial sensors, 
# applies the ceiling function to a selected variable, and plots the waveforms 
# of the original variable, the result of the ceiling function, 
# and the difference between the two variables.

library(openxlsx)
require(graphics)

# Load data from the file "flexao.xlsx"
df1 <- read.xlsx("flexao.xlsx", sheet = 1, skipEmptyRows = FALSE)

# Select the time column and the variable to be quantized
x1 <- data.frame(Time = df1$`[Time]`)
coluna2.1 <- df1$`[G1.X]`
x1$Variable <- coluna2.1

# Apply the ceiling function to the selected variable
x2 <- data.frame(Time = df1$`[Time]`)
coluna2 <- ceiling(df1$`[G1.X]`)
x2$Variable <- coluna2

# Calculate the difference between the original and quantized variables
y <- x1$Variable - x2$Variable

# Show the quantization results
ceiling(df1$`[G1.X]`)

# Create a data frame for the difference between the quantized and original signal
df2 <- ceiling(df1$`[G1.X]`) - df1

# Plot the time series for the original variable, quantized variable, and their difference
dygraph(data.frame(time = df1$`[Time]`, x1 = x1$Variable, x2 = x2$Variable, y = y), group = "G1") %>%
  dyRangeSelector()
