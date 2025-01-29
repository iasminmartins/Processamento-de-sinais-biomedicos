# Plotting data from an Excel file using ggplot2

# Load libraries
library(openxlsx)
library(ggplot2)

# Read data from an Excel file
df1 <- read.xlsx("V16C1RCC92.xlsx", sheet = 1, skipEmptyRows = FALSE)

# Static plot using ggplot2
qplot(df1$`[Time]`, df1$`[G1.X]`, data = df1)

# Add both points and lines to the plot
qplot(df1$`[Time]`, df1$`[G1.X]`, geom = c("point", "line"))

# Modify units and labels in the plot
p <- qplot(df1$`[Time]`, df1$`[G1.X]`, geom = c("point", "line"))
p <- p + labs(x = "Time (s)", y = "Degrees/second")  # Changing units
print(p)  # Print the plot

# Additional plotting methods using ggplot2
ggplot(data = df1, aes(x = df1$`[Time]`, y = df1$`[G1.X]`)) + geom_point()
ggplot(data = df1, aes(x = df1$`[Time]`, y = df1$`[G1.X]`)) + geom_line()
ggplot(data = df1, aes(x = df1$`[Time]`, y = df1$`[G1.X]`)) + geom_point() + geom_line()
