# Plotting the previous graphs together
# Creating a single time vector containing all moments from the generated signals
tt <- dplyr::union(df1$t1, df2$t2)
tt <- dplyr::union(tt, df3$t3)
tt <- sort(tt) # Sorting time in ascending order

# Creating a data frame to facilitate the plotting of graphs with different time axes
# Initializing each of the vectors in the data frame
df5 <- data.frame(time = tt)
df5$y1 <- NA
df5$y2 <- NA
df5$y3 <- NA

# Filling each vector in the data frame
df5$y1[tt %in% df1$t1] <- df1$y1
df5$y2[tt %in% df2$t2] <- df2$y2
df5$y3[tt %in% df3$t3] <- df3$y3

# Plotting the graphs
dygraph(df5) %>%
  dyRangeSelector() %>%
  dyOptions(drawPoints = TRUE, connectSeparatedPoints = TRUE, pointSize = 2) %>%
  dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.2, hideOnMouseOut = FALSE)
