# dplyr tutorial example

# Load the dataset
mydata <- read.csv("file.csv") 

# Display the first few rows and columns of the data
head(mydata, 3)

# Display 10% of the data
sample_n(mydata, 0.1)

# Get unique values based on the 'Index' column, keeping all other variables
mydata_distinct <- distinct(mydata, Index, .keep_all = TRUE)

# Select specific columns (Index, State, and all columns up to Y2007)
mydata_selected <- select(mydata, Index, State:Y2007)

# Remove the 'Index' and 'State' columns
mydata_cleaned <- select(mydata_selected, -Index, -State)

# Check the first few rows of the cleaned data
head(mydata_cleaned)

# Sample 3 rows from the data
sample_n(data, 3)

# Sample 10% of the data
sample_n(data, 0.1)

# Remove duplicate rows based on the 'Index' column and keep all other columns
data_distinct = distinct(data, Index, .keep_all = TRUE)

# Select only the 'Index' and 'State' columns along with data from 2002 to 2007
selected_data = select(data, Index, State:Y2007)

# Select columns excluding 'Index' and 'State'
final_data = select(selected_data, -Index, -State)

# Display the first few rows of the final dataset
head(final_data)

# Selecting columns starting with "Y"
mydata_Y_start = select(mydata, starts_with("Y"))

# Selecting columns not starting with "Y"
mydata_no_Y_start = select(mydata, -starts_with("Y"))

# Selecting columns containing "K"
mydata_K_contain = select(mydata, contains("K"))

# Renaming columns
mydata_rename = rename(mydata, Index1 = Index)

# Filtering rows based on conditions
mydata_A_filter = filter(mydata, Index == "A")
mydata_AC_filter = filter(mydata, Index %in% c("A", "C"))
mydata_AC_Y2002_filter = filter(mydata, Index %in% c("A", "C") & Y2002 >= 1300000)
mydata_or_condition = filter(mydata, Index %in% c("A", "C") | Y2002 >= 1300000)
mydata_not_AC = filter(mydata, !Index %in% c("A", "C"))
mydata_state_contains_Ar = filter(mydata, grepl("Ar", State))

# Summarizing data
summarise(mydata, Y2015_mean = mean(Y2015), Y2015_median = median(Y2015))
summarise_at(mydata, vars(Y2005, Y2006), funs(n(), mean, median))
summarise_at(mydata, vars(Y2005, Y2006), list(n = ~n(), mean = mean, median = median))
summarise_at(mydata, vars(Y2011, Y2012), funs(mean, median), na.rm = TRUE)
summarise_at(mydata, vars(Y2011, Y2012), funs(n(), missing = sum(is.na(.)), mean(., na.rm = TRUE), median(., na.rm = TRUE)))

# Variance calculation
summarise_at(mydata, vars(X1, X2), function(x) var(x - mean(x)))

# Summarizing conditional data
summarise_if(mydata, is.numeric, funs(n(), mean, median))

# Arranging data
arrange(mydata, Index, Y2011)
arrange(mydata, desc(Index), Y2011)

# Sampling data
sample_data = sample_n(select(mydata, Index, State), 10)

# Grouping and summarizing data by Index
grouped_summary = summarise_at(group_by(mydata, Index), vars(Y2011, Y2012), funs(n(), mean(., na.rm = TRUE)))

# Selecting the first two rows for specific Index values
grouped_first_two = mydata %>% filter(Index %in% c("A", "C", "I")) %>% group_by(Index) %>% do(head(., 2))

# Sorting data by Y2015 for specific Index values
sorted_data = mydata %>%
  select(Index, Y2015) %>%
  filter(Index %in% c("A", "C", "I")) %>%
  group_by(Index) %>%
  do(arrange(., desc(Y2015))) %>%
  slice(3)

# Calculating cumulative sum for Y2015
cumulative_data = mydata %>% group_by(Index) %>% mutate(Total = cumsum(Y2015)) %>%
  select(Index, Y2015, Total)

# Combining two dataframes by row
combined_df = bind_rows(df1, df2)

# Combining two dataframes by column
combined_cols = cbind(df1, df2)

# Finding common data between two dataframes
common_data = intersect(first, second)

# Finding union of two dataframes
union_data = union(x, y)

# Performing conditional logic on a dataframe
df_result = if_else(df < 0, "negative", "positive", missing = "missing")

# Applying conditional logic to mutate a new variable
mutated_df = df %>% mutate(newvar = if_else(x < 5, x + 1, x + 2, 0))

# Handling missing values with multiple if_else conditions
missing_handling = mydf %>%
  mutate(newvar = if_else(is.na(x), "I am missing", 
                          if_else(x == 1, "I am one", 
                                  if_else(x == 2, "I am two", 
                                          if_else(x == 3, "I am three", "Others")))))

# Calculating unique values in a column
unique_values = length(unique(mtcars$cyl))

# Selecting numeric columns
numeric_data = select_if(mydata, is.numeric)

# Summarizing factor columns
summarise_if(mydata, is.factor, funs(nlevels(.)))

# Applying a transformation to numeric columns
transformed_data = mutate_if(mydata, is.numeric, funs("new" = . * 1000))