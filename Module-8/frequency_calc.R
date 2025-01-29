# Calculate frequency in cycles/s, rad/sample, and cycles/sample for given f and fs.

# Parameters
fs <- 200    # Sampling frequency (Hz)
f <- 0.3     # Frequency (rad/s)

# Calculations
fciclos <- f / (2 * pi)         # Frequency in cycles per second
fzao <- fciclos * 2 / fs        # Frequency in cycles per sample
frad <- pi * fzao               # Frequency in radians per sample

# Display results
print("Cycles/s: ") 
print(fciclos)
print("Rad/sample: ")
print(frad)
print("Cycles/sample: ")
print(fzao)
