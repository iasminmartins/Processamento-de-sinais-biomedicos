# Discrete Signal Simulation
# This example simulates a discrete signal with specific values at discrete time points. 
# Discrete signals are considered analog because they can take any amplitude value, though they exist only at discrete moments in time.

dygraph(data.frame(t, y), 
        xlab = "Time (s)", 
        ylab = "Amplitude", 
        main = "Discrete Signal", 
        group = "SD") %>% 
  dyRangeSelector(dateWindow = c((517-1)*dt, (600-1)*dt)) %>% 
  dySeries(stemPlot = TRUE)
