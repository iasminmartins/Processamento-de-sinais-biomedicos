# Physical Activity Level Analysis for Biomedical Signal Processing Students

# Creating a data frame to store the collected variables
student_data <- data.frame(
  id = c(1:7),
  name = c("Ana", "João", "Mauricio", "Barbara", "Kerlon", "Gustavo", "Mirian"),
  course = c("Nutrition", "Physical Education", "Physical Education", "Engineering", "Engineering", "Engineering", "Nutrition"),
  period = c(5, 4, 5, 3, 2, 5, 8),
  age = c(20, 22, 21, 20, 22, 23, 23),
  weight = c(60, 70, 75, 77, 77, 60, 66),
  height = c(170, 175, 175, 177, 162, 165, 177),
  activity_level = c("none", "none", "low", "moderate", "advanced", "advanced", "moderate"),
  stringsAsFactors = TRUE
)

# Displaying the count of participants in each activity level category
activity_summary <- summary(student_data$activity_level)
print(activity_summary)

# Calculating the percentage of participants in each activity level category
activity_percentage <- prop.table(summary(student_data$activity_level)) * 100
print(activity_percentage)

# Calculating global averages for age, weight, and height
global_avg_age <- mean(student_data$age)
global_avg_weight <- mean(student_data$weight)
global_avg_height <- mean(student_data$height)

cat("Global Averages:\n")
cat("Age:", global_avg_age, "\n")
cat("Weight:", global_avg_weight, "\n")
cat("Height:", global_avg_height, "\n")

# Function to calculate averages by course
calculate_course_averages <- function(course_name) {
  course_filter <- student_data$course == course_name
  course_data <- student_data[course_filter, ]
  
  avg_age <- mean(course_data$age)
  avg_weight <- mean(course_data$weight)
  avg_height <- mean(course_data$height)
  
  cat("\nAverages for", course_name, ":\n")
  cat("Age:", avg_age, "\n")
  cat("Weight:", avg_weight, "\n")
  cat("Height:", avg_height, "\n")
}

# Calculating averages for each course
calculate_course_averages("Engineering")
calculate_course_averages("Physical Education")
calculate_course_averages("Nutrition")