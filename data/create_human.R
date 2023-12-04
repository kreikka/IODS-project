# Kerttu Uusimäki, 27.11.2023
# IODS-course, Assignment 4
# Data: Human Development Index (HDI); Human development and Gender inequality
# Data; Human development: https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv
# Data; Gender inequality: https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv
# More about data: https://hdr.undp.org/data-center/human-development-index#/indicies/HDI
# Technical notes: https://hdr.undp.org/system/files/documents/technical-notes-calculating-human-development-indices.pdf

#accessing libraries
library(readr)
library(dplyr)

# ----------- Assignment 4; start the Data Wrangling:

# reading datasets "Human development" and "Gender inequality"
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Looking at the structure and dimensions of the data:
str(hd); str(gii)
dim(hd); dim(gii)
# Both datasets have 195 observations.
# There is 10 variables in gii and 8 variables in hd
# The 'Country' variable is categorical and other variables are numeric in both datasets.

# summaries of the variables
summary(hd); summary(gii)

# renaming variables
names(hd) <- c("HDI.Rank", "Country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", "GNI", "GNI.Minus.Rank")
names(gii) <- c("GII.Rank", "Country", "GII", "Mat.Mor", "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")

# mutate gii data by creating two new variables: 
# ratio of female and male populations with secondary education and ratio of labor force participation of females and males in each country
gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M, Labo.FM = Labo.F / Labo.M)

# join the two datasets using Country as identifier
human <- inner_join(hd, gii, by = "Country")

# check the dimensions and glimpse the data
dim(human)
glimpse(human)
# 195 observations and 19 variables

# save the data
write_csv(human, file="C:\\Users\\kuud\\Work Folders\\IODS\\IODS-project\\data\\human.csv")

# ----------- Assignment 5; continue the Data Wrangling:

# accessing the data
read_csv("C:\\Users\\kuud\\Work Folders\\IODS\\IODS-project\\data\\human.csv")

# Looking at the structure and dimensions of the data:
str(human)
dim(human)
# The joined data has 195 observations and 19 variables
# The data contains Human Development Index (HDI) and gender inequality (GII) related variables by country, 
# such as life expectancy at birth (Life.Exp), maternal mortality (Mat.Mor), adolescent birth rate (Ado.Birth),
# education (mean (Edu.Mean), expected years of education (Edu.Exp), population with secondary ed. (Edu2.F, Edu2.M, and ratio: Edu2.FM),
# income (GNI per Capita (GNI) and minus HDI Rank (GNI.Minus.Rank)) and
# Female Representation in Parliament (Parli.F) and Labour Force Participation Rate (Labo.F, Labo.M, and ratio: Labo.FM)

# Exclude unneeded variables: 
# Variables to keep "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"
keep_columns <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep_columns' to the dataset
human <- select(human, one_of(keep_columns))

# check the structure:
str(human)
# 195 observations and 9 variables 

# Let's identify the total number of NA's:
sum(is.na(human))
# There indeed is missing data; 55 na's

# Remove the rows with missing values:
human <- filter(human, complete.cases(human))

# Check the number of na's now
sum(is.na(human))
# There is no missing data anymore

# Let's look at the Country -variable
head(human, 20)
tail(human, 20)
# The last seven observations are regions, while others are countries

# Remove the observations which relate to regions instead of countries:
last <- nrow(human) - 7
human <- human[1:last, ]

# Let's see the last 10 observations now:
tail(human, 10)

# There are now 155 observations and 9 variables in the data:
dim(human)
str(human)

# save the data
write_csv(human, file="C:\\Users\\kuud\\Work Folders\\IODS\\IODS-project\\data\\human.csv")




