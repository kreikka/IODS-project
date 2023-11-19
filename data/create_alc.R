# Kerttu Uusimäki, 19.11.2023
# IODS-course, Assignment 3
# Data from: UCI Machine Learning Repository, Student Performance Data, 
# http://www.archive.ics.uci.edu/dataset/320/student+performance
# Student achievement in secondary education of two Portuguese schools

# accessing the libraries
library(dplyr); library(tidyverse)

# Reading the datasets into R
mat <- read.table("C:\\Users\\kuud\\Work Folders\\IODS\\IODS-project\\data\\student-mat.csv", sep = ";", header = TRUE)
por <- read.table("C:\\Users\\kuud\\Work Folders\\IODS\\IODS-project\\data\\student-por.csv", sep = ";", header = TRUE)

# Looking at the structure and dimensions of the data:
str(mat); str(por)
dim(mat); dim(por)
# Both have 33 variables named similarly. 
# 395 observations in mat and 649 in por. 
# Variable types: continuous (int) and categorical (chr)

# Joining the data sets:
# using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" as (student) identifiers
# Keeping only the students present in both data sets
free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)
mat_por <- inner_join(mat, por, by = join_cols, suffix = c(".mat", ".por"))

# Looking at the structure and dimensions of the combined data set:
str(mat_por); dim(mat_por)
# The joined dataset: 370 observations, 39 variables

# Removing the duplicate records in the joined data set
alc <- select(mat_por, all_of(join_cols))
for(col_name in free_cols) {
  two_cols <- select(mat_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}
# checking the structure and dimensions of alc
str(alc); dim(alc)
# There are now again 33 variables

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use' which is true when use is > 2
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse at the joined and modified data 
glimpse(mat_por); glimpse(alc)

write_csv(alc, file="C:\\Users\\kuud\\Work Folders\\IODS\\IODS-project\\data\\alc.csv")
