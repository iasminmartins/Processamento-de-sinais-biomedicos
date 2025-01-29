# Exercise: Signal Resampling and Sampling Frequencies

Given the following code snippet:

A) Study and explain each line of code.
B) What concept is illustrated in the animation?
C) Which line color represents a continuous signal?
D) Which symbol represents a discrete signal?
E) What is the temporal resolution of signals v1 and v2?
F) Which signal, v1 or v2, has the higher oscillation frequency?
G) What is the practical implication of signal v1 being sampled at a higher frequency rate than signal v2?
H) Were the signals sampled according to the Nyquist frequency?
I) Do the samples of signals v1 and v2 occur at the same discrete time? Justify.
J) What is the peak-to-peak value of signals v1 and v2?
K) What are the peak and trough values of signals v1 and v2?
L) How could we estimate a sample at a discrete time that does not initially exist in signal v2?

## A) Code Explanation:

```r
library("reshape2")   # Loads the "reshape2" library
library(ggplot2)      # Loads the "ggplot2" library
library(gganimate)    # Loads the "gganimate" library
library(dplyr)        # Loads the "dplyr" library

fs <- 100             # Defines a sampling frequency of 100 Hz
dt <- 1/fs            # Defines the sampling period in seconds
tf <- 5               # Defines the duration of the signal (5 seconds)
t <- seq(from = 0, to = tf, by = dt)  # Creates a time vector for sampling

f <- 1                 # Defines the frequency of the sine wave (1 Hz)
y <- sin(2*pi*f*t)     # Defines the sine wave signal

fs1 <- 30              # Changes the sampling frequency to 30 Hz
dt1 <- 1/fs1           # Defines a new sampling period based on the new frequency
t1 <- seq(from = 0, to = tf, by = dt1)  # Defines a new time vector

y2 <- sin(2*pi*f*t1)   # Defines a new sine wave signal for the second frequency

# Create a union of time vectors (not used here)
# tt <- union(t, t1)

tt <- sort(tt)  # Sorts the time vector

v1 <- rep(NA, length(tt))  # Creates a vector with NA values for the first signal
v2 <- rep(NA, length(tt))  # Creates a vector with NA values for the second signal

v1[(tt %in% t) == TRUE] <- y  # Assigns the values from 'y' to 'v1'
v2[(tt %in% t1) == TRUE] <- y2  # Assigns the values from 'y2' to 'v2'

dfplot <- data.frame(t = tt, v1, v2)  # Creates a data frame with the time vector and signals
dfplotm <- melt(dfplot, id="t")  # Melts the data frame for plotting

# Static plot
theme_set(theme_bw())  # Sets the default ggplot2 theme
p <- ggplot(dfplotm, aes(x=t, y=value, colour = variable)) +
  geom_line(data=dfplotm[!is.na(dfplotm$value),]) +
  geom_point(data=dfplotm[!is.na(dfplotm$value),], aes(shape=variable, size = variable, alpha = variable)) +
  scale_size_manual(values=c(3.2,2.8)) +  # Adjusts the point sizes
  scale_alpha_manual(values = c(0.5,1)) +  # Adjusts the alpha values
  scale_shape_manual(values = c(1, 16))  # Adjusts the shapes of the points

print(p)  # Prints the plot
```
## B) What concept is illustrated in the animation?
The concept of aliasing is illustrated in the animation.

## C) Which line represents a continuous signal?
The red line represents the continuous signal.

## D) Which symbol represents a discrete signal?
The blue points represent the discrete signals.

## E) What is the temporal resolution of signals v1 and v2?
v1 has a temporal resolution of 0.01 seconds.
v2 has a temporal resolution of 0.03 seconds.

## F) Which signal, v1 or v2, has the highest frequency of oscillation?
v1 has the highest frequency of oscillation because it has more samples in the sine wave.

## G) What is the practical implication of v1 being sampled at a higher frequency than v2?
Sampling at a higher frequency results in better temporal resolution, which leads to a more accurate signal representation. A lower sampling frequency (like for v2) can cause aliasing and signal distortion, making it difficult to analyze and interpret the signal.

## H) Were the signals sampled according to the Nyquist frequency?
Yes, the signals were sampled according to the Nyquist criterion, which states that the sampling frequency should be at least twice the frequency of the signal (fs > 2*f_signal).

## I) Do the samples of signals v1 and v2 occur at the same discrete time?
No, the sampling frequencies are different, so the samples for v1 and v2 occur at different discrete times.

## J) What is the peak-to-peak value of signals v1 and v2?
The peak-to-peak value for both signals is 2.

## K) What are the peak and trough values of signals v1 and v2?
The peak value is 1.
The trough value is -1.

## L) How could we estimate a sample at a discrete time that is missing in signal v2?
We can estimate missing samples in signal v2 by using methods like interpolation. One approach is to use the average of neighboring samples or employ polynomial models (e.g., splines) to estimate the missing values based on the surrounding data.
