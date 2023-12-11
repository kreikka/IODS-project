# Kerttu Uusimäki, 11.12.2023
# IODS-course, Assignment 6, Data Wrangling
# Dataset 1; BPRS: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
# Dataset 2; RATS: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt 

# ------------------------------------------------------------------------------

# ---- Accessing the needed libraries

library(readr)
library(dplyr)


# ------ Reading and exploring the datasets ------------------------------------

# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
# Read the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Look at the (column) names of BPRS
names(BPRS)
# Column names are "treatment", "subject" and weeks 1 to 8

# Look at the structure of BPRS
str(BPRS)
# There are 40 observations and 11 variables

# Print out summaries of the variables
summary(BPRS)

# Look at the (column) names of RATS
names(RATS)
# Column names are "ID", "Group" and "WD" + 1, 8, 15, 29, 36, 43, 44, 50, 57 and 64

# Look at the structure of RATS
str(RATS)
# There are 16 observations and 13 variables

# Print out summaries of the variables
summary(RATS)


# ------ Converting the categorical variables of both data sets to factor ------

# Factor treatment & subject in BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Factor variables ID and Group in RATS
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# ------ Converting the data sets to long form ---------------------------------

# Convert BPRS to long form and create new variable weeks
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", 
                       values_to = "bprs") %>%
  mutate(week = as.integer(substr(weeks,5,5))) %>%
  arrange(weeks) #order by weeks variable
  
# Convert RATS data to long form and create new Time variable
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD,3,4))) %>%
  arrange(Time) #order by Time variable


# ------ Checking the new datasets ---------------------------------------------

# Let's look at the variable names, data structure and summaries of some variables 

# Look at the (column) names of and structure of BPRSL
names(BPRSL); str(BPRSL)
# There is now 5 columns in the BPRSL dataset: treatment, subject, weeks, bprs and 
# week. The wide data column names were "treatment", "subject" and weeks 1 to 8.
# In the wide data set the 40 observations (40 males in this data) appeared once
# in the rows and there was one column for each week. Whereas in the new long 
# form dataset there is only one column for weeks, and the 40 males appear 
# once for each of the 8 weeks in the rows, creating 360 rows.

# The same can be seen in the RATS and RATSL datasets:
names(RATSL); str(RATSL)
# There is columns "ID", "Group", "WD", "Weight" and "Time" in the new long form 
# dataset and instead of 16 observations, there are now 176 observations (one
# time for each of the eleven time points)

# Print out summaries of the variables
summary(BPRSL); summary(RATSL)

# save the data
write_csv(BPRSL, file="C:\\Users\\kuud\\Work Folders\\IODS\\IODS-project\\data\\bprsl.csv")
write_csv(RATSL, file="C:\\Users\\kuud\\Work Folders\\IODS\\IODS-project\\data\\ratsl.csv")
write_csv(RATS, file="C:\\Users\\kuud\\Work Folders\\IODS\\IODS-project\\data\\rats.csv")


