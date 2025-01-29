# Install and load the dplyr package
install.packages("dplyr")
library(dplyr)

# Create the data frame
student_data <- data.frame(
  id = 1:7,
  name = c("Ana", "Joao", "Mauricio", "Barbara", "Kerlon", "Gustavo", "Mirian"),
  course = c("Nutrition", "Physical Education", "Physical Education", 
             "Engineering", "Engineering", "Engineering", "Nutrition"),
  semester = c(5, 4, 5, 3, 2, 5, 8),
  age = c(20, 22, 21, 20, 22, 23, 23),
  weight = c(60, 70, 75, 77, 77, 60, 66),
  height = c(170, 175, 175, 177, 162, 165, 177),
  fitness = c("none", "none", "low", "moderate", "advanced", "advanced", "moderate"),
  stringsAsFactors = TRUE
)

# Count the number of participants for each fitness level
count(student_data, fitness)

# Calculate the percentage for each fitness level
student_data %>% 
  count(fitness) %>% 
  mutate(percent = n / sum(n))

# Calculate overall averages for age, weight, and height
summarise(student_data, avg_age = mean(age))
summarise(student_data, avg_weight = mean(weight))
summarise(student_data, avg_height = mean(height))

# Calculate averages by semester
age_by_semester <- student_data %>%
  group_by(semester) %>%
  summarise(
    avg_age = mean(age, na.rm = TRUE),
    avg_semester = mean(semester, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_age))

weight_by_semester <- student_data %>%
  group_by(semester) %>%
  summarise(
    avg_weight = mean(weight, na.rm = TRUE),
    avg_semester = mean(semester, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_weight))

height_by_semester <- student_data %>%
  group_by(semester) %>%
  summarise(
    avg_height = mean(height, na.rm = TRUE),
    avg_semester = mean(semester, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_height))

# Print results
print(age_by_semester)
print(weight_by_semester)
print(height_by_semester)

# Calculate averages by course
age_by_course <- student_data %>%
  group_by(course) %>%
  summarise(
    avg_age = mean(age, na.rm = TRUE),
    avg_semester = mean(semester, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_age))

weight_by_course <- student_data %>%
  group_by(course) %>%
  summarise(
    avg_weight = mean(weight, na.rm = TRUE),
    avg_semester = mean(semester, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_weight))

height_by_course <- student_data %>%
  group_by(course) %>%
  summarise(
    avg_height = mean(height, na.rm = TRUE),
    avg_semester = mean(semester, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_height))

# Print results
print(age_by_course)
print(weight_by_course)
print(height_by_course)
