# Kerttu Uusimäki, 27.11.2023
# IODS-course, Assignment 4
# Data: Human Development Index (HDI); Human development and Gender inequality
# Data; Human development: https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv
# Data; Gender inequality: https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv
# More about data: https://hdr.undp.org/data-center/human-development-index#/indicies/HDI
# Technical notes: https://hdr.undp.org/system/files/documents/technical-notes-calculating-human-development-indices.pdf

#accessing libraries
library(readr)

#reading datasets "Human development" and "Gender inequality"
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
names(gii) <- c("GII.Rank", "Country", "GII", "Mat.Mor", "Ado.Birth", "Parli", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")

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
