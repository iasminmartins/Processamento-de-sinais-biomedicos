# R Programming Basics: Vectors, Lists, Matrices, Arrays, Factors, and Data Frames

## Vectors

### Example of integer vector
```r
v.inteiro <- integer(8)  # Create an integer vector of length 8
v.inteiro <- c(1:9)  # Create an integer vector with elements from 1 to 9
```

### Example of double vector
```r
v.double <- numeric(6)  # Create a numeric (double) vector of length 6
v.double <- c(2.5, c(1:9))  # Create a double vector with the elements 2.5 and 1 to 9
```

### Example of logical vector
```r
v.logical <- logical(10)  # Create a logical vector of length 10
v.logical <- c(T, T, F, F, T, F, T, T, T, F)  # Create a logical vector with TRUE and FALSE values
```

### Example of complex vector
```r
v.complex <- complex(10)  # Create a complex vector of length 10
v.complex <- c(1+2i, 3+1i, 5-4i, 9-0.1i, 10-54i, 100-1i, -2-2i, 3+3i, 10-0i, 8)  # Complex numbers in the vector
```

### Example of raw vector
```r
v.raw <- raw(10)  # Create a raw vector of length 10
v.raw[1] <- as.raw(10)  # Assign raw value 10 to the first element
v.raw[2] <- as.raw(5)  # Assign raw value 5 to the second element
```

### Print various vectors
```r
print("céu azul")  # "céu azul" is a character vector
print("98.1")  # 98.1 is a double vector
print(2:8)  # Integer vector from 2 to 8
print(1.8:6.8)  # Double vector from 1.8 to 6.8
print(c(3, 4, 5))  # Print a simple vector with values 3, 4, and 5
print(c("apple", "banana", "cherry"))  # Character vector with fruits
```

### Generating vector from seq() function
```r
seq(from = 1, to=2, by = 0.1)  # Generate a sequence from 1 to 2 with a step of 0.1
v1 <- seq(from=0, to=2, by=0.1)  # Create a vector using seq() from 0 to 2 with step 0.1
print(v1)  # Print the generated vector
print(v1[1])  # Access the first element of v1
print(v1[c(1, 4)])  # Access the first and fourth elements of v1
```

### Accessing elements from character vector
```r
v2 <- c("maçã", "banana", "amora")  # Character vector with fruits
print(v2[2])  # Access the second element of v2
print(v2[c(1, 3)])  # Access the first and third elements of v2
```

### Logical indexing for elements in a vector
```r
v3 <- c("laranja", "banana", "toranja")  # Character vector
print(v3[c(T, F, F)])  # Print only the elements where the logical value is TRUE
```

### Excluding an item from the vector
```r
v2 <- c("maçã", "banana", "amora")  # Character vector
print(v2)  # Print the original vector
print(v2[-2])  # Exclude the second item (banana) from the vector
```

### Operations between vectors
```r
v1 <- c(1, 2, 3)  # Vector 1
v2 <- c(4, 5, 6)  # Vector 2
print(v1 + v2)  # Element-wise addition of v1 and v2
print(v1 - v2)  # Element-wise subtraction of v1 and v2
print(v1 * v2)  # Element-wise multiplication of v1 and v2
print(v1 / v2)  # Element-wise division of v1 and v2
```

### Recycling rule when vectors have different lengths
```r
v1 <- c(4,5,6,7,8,9)  # Longer vector
v2 <- c(2,3)  # Shorter vector
r <- v1 + v2  # v2 will be recycled to match the length of v1
print(r)  # Observe the recycling of v2
print(v2 - v1)  # Element-wise subtraction
```

### Sorting a vector
```r
v <- c(1:10)  # Integer vector from 1 to 10
print(sort(v, decreasing = T))  # Sort v in decreasing order
a <- seq(from=-1, to=1, by = 0.1)  # Sequence from -1 to 1
print(sort(a, decreasing = F))  # Sort a in increasing order
```

## Lists

### Example of list creation and manipulation
```r
ml <- list("a", "b", "c", "d")  # Create a list with 4 elements
print(ml)  # Print the list
print(ml[3])  # Access the 3rd element in the list
ml[5] <- 48.22  # Add a new element to the list at position 5
print(ml)  # Print the updated list
ml[5] <- NULL  # Remove the element at position 5
print(ml)  # Print the list after removal
ml[2] <- "uptaded 2nd element"  # Update the 2nd element in the list
print(ml[2])  # Print the updated 2nd element
```

### Combining lists
```r
l1 <- list("a", "b", 2)  # List l1
l2 <- list("d", "e", 3)  # List l2
l12 <- c(l1, l2)  # Combine lists l1 and l2 into one
print(l12)  # Print the combined list
```

### Convert list to vector
```r
v12 <- unlist(l12)  # Convert list to a vector
print(v12)  # Print the converted vector
```

## Matrices

### Creating a matrix
```r
v <- c(1:12)  # Vector with 12 elements
vnames <- list(c("row1", "row2"), c("col1", "col2", "col3", "col4", "col5", "col6"))  # Row and column names
m <- matrix(v, nrow = 2, ncol = 6, byrow = TRUE, dimnames = vnames)  # Create matrix with row-wise filling
print(m)  # Print the matrix
m <- matrix(v, nrow = 2, ncol = 6, byrow = FALSE, dimnames = vnames)  # Create matrix with column-wise filling
print(m)  # Print the matrix
```

### Accessing matrix elements
```r
print(m[2,3])  # Access element at row 2, column 3
print(m[3,5])  # Access element at row 3, column 5
print(m[1,1])  # Access element at row 1, column 1
```

### Matrix operations
```r
m2 <- matrix(c(4,5,6,7,8,9), nrow = 2)  # Create another matrix
print(m2)  # Print the matrix
print(m2 + m2)  # Matrix addition
print(m2 - m2)  # Matrix subtraction
print(m2 * m2)  # Element-wise multiplication
print(m2 / 3 * m2)  # Element-wise division and multiplication
```

## Arrays

### Creating an array
```r
print(array(1:10))  # Simple array
print(array(1:10, dim = c(2,4)))  # Array with 2 rows and 4 columns
print(array(1:16, dim = c(2,4,2)))  # 3D array with 2 rows, 4 columns, and 2 matrices
rowname <- c("r1", "r2", "r3")
colname <- c("c1", "c2", "c3")
matrixname <- c("m1", "m2")
marray <- array(1:18, dim = c(3,3,2), dimnames = list(rowname, colname, matrixname))  # 3D array with names
print(marray)  # Print the 3D array
```

### Accessing array elements
```r
print(marray[2, 3, 1])  # Access an element in a 3D array
print(marray[,,1])  # Access the first matrix of the 3D array
print(marray[2,,1])  # Access the second row of the first matrix
```

## Factors

### Creating and manipulating factors
```r
fator <- factor(1:5, levels=1:10, labels = c("a"))  # Create a factor with custom levels and labels
print(fator)
```

### Create and manipulate factors with different levels and labels
```r
data <- c("a", "c", "b", "c", "a")  # Data for the factor
fator <- factor(data)  # Convert to factor
print(fator)  # Print the factor

fator <- factor(1:5, levels = 1:3, labels = c("a", "b", "c"))  # Factor with mismatched levels
print(fator)  # Print the factor

# Custom labels and levels
fator <- factor(c("A", "C", "B", "B", "C", "A"), labels=c("maçã", "banana", "uva"))
print(fator)  # Print the factor with custom labels

# Ordered factors
fator <- factor(c("A", "B", "C"), levels = c("C", "B", "A"))  # Ordered factor
print(fator)  # Print the ordered factor
```

### Generating factor sets with gl()
```r
L <- gl(4,2, labels = c("A", "B", "C", "D"))  # Generate a factor with 4 levels
print(L)  # Print the factor
```

### Factor levels and ordering
```r
L <- gl(4,5, labels = c("A", "B", "C", "D"))
print(L)

sexo <- factor(c("macho", "femea", "femea", "macho"))
levels(sexo)
nlevels(sexo)

food <- factor(c("low", "high", "medium", "high", "low", "medium", "high"))
levels(food)

food <- factor(food, levels = c("low", "medium", "high"))
levels(food)

food <- factor(food, levels = c("low", "medium", "high"), ordered = TRUE)
levels(food)
```

### Physical activity levels
exercise <- factor(c("l", "n", "n", "i", "l"), levels = c("n", "l", "i"), ordered = TRUE)
print(exercise)

## Data Frames

### Create a data frame
```r
df <- data.frame(
  id = c(1:5),
  name = c("Silvana", "João", "Maria", "Roberto", "Carla"),
  score = c(85, 99, 95, 92, 96),
  year = c("2009", "2002", "2008", "2006", "2007"),
  stringsAsFactors = FALSE  # Prevents strings from being converted to factors
)
print(df)
str(df)  # View structure of the data frame
summary(df)  # Summary statistics of the data frame
```

### Accessing specific columns of the data frame
```r
print(df$id)
print(df$name)
print(df$score)
print(df$year)
```

### Adding a new column to the data frame
```r
df$age <- c(21, 22, 23, 24, 25)
print(df)
newRows <- data.frame(
 id = c(6,7),
 name = c("Rui", "Alana"),
 score = c(100, 33),
 year = c("1999", "1997"),
 idade = c(43, 33),
 stringsAsFactors = FALSE
)
df <- rbind(df, newRows)
print(df)

```

### Subsetting a data frame based on conditions
```r
df[df$score > 90, ]
df[df$score > 90, c("name", "score")]  # Display name and score columns
```

### Sorting by one or more columns
```r
sorted_df <- df[order(df$score),]
print(sorted_df)
```

### Removing a column
```r
df$age <- NULL
print(df)
```

## Tables

### Create a table to summarize the frequency of categorical data
gender <- c("male", "female", "male", "female", "male")
table(gender)