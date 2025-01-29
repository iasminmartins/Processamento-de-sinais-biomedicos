# Calculate the unit impulse response h[n] for the processor: 
# y[n] = y[n-1] + (1/L * x[n]) - x[n-L].

unit <- function(x) {
  if (x == 0) {
    return(1)
  } else {
    return(0)
  }
}

# Parameters
a <- 30    # Number of samples
b <- 0     # Initial value for b
L <- 8     # Delay parameter
func <- NA
func[1] <- 1

# Apply recursive equation
for (i in 2:a) {
  func[i] <- func[i - 1] + (1 / L * unit(b)) - unit(b - L)
  b <- b + 1
}

# Plot the impulse response
plot(func)
