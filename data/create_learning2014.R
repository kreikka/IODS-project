# Kerttu Uusimäki, 13.11.2023
# IODS-course, Assignment 2
# Data from Kimmo Vehkalahti, http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt
# More information about the data: https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-meta.txt

# access the dplyr library
library(dplyr)
library(tidyverse)

# Reading the data into  memory (the separator is a tab: "\t" and the file includes a header: header=TRUE)
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Looking at the structure of the data:
str(lrn14)
# Age, Attitude, Points and gender differ from the other variables which are points from each questions asked

# Looking at the dimensions of the data
dim(lrn14)
# 60 variables and 183 observations


# questions related to deep, surface and strategic learning
deep_questions <- c("D03","D11","D19","D27","D07","D14","D22","D30","D06","D15","D23","D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(lrn14, one_of(deep_questions))
# and create column 'deep' by averaging
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(lrn14, one_of(surface_questions))
# and create column 'surf' by averaging
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(lrn14, one_of(strategic_questions))
# and create column 'stra' by averaging
lrn14$stra <- rowMeans(strategic_columns)

# choosing variables to new dataset
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# select rows where points is greater than zero
learning2014 <- filter(learning2014, Points > "0")

# see the structure of the new dataset
str(learning2014)

# Setting the working directory to the IODS Project folder using write_csv() function. 
# I don't have a writing access by default to the folders because I'm using my THL computer. 
# Writing only a folder path did not work, but writing absolute path worked.
write_csv(learning2014, file="C:\\Users\\kuud\\Work Folders\\IODS\\IODS-project\\data\\learning2014.csv")

# Reading a .csv file
read_csv <- read_csv(file="C:\\Users\\kuud\\Work Folders\\IODS\\IODS-project\\data\\learning2014.csv")

str(read_csv)
head(read_csv)

