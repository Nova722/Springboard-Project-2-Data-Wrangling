##0 Load the data
titanic_original = read.csv("C:/Users/chris/Desktop/springboard/data-wrangling-project-2/titanic_original.csv", header = TRUE, sep = ",")
View(titanic_original)

##1 Port of embarkation - chamge missing values to "s"
###there are 914 "S", 3 unknowns
summary(titanic_original$embarked)
str(titanic_original$embarked)

###added a logical column, if embarked calue is "NA" it will state TRUE
library(dplyr)
titanic_original <- mutate(titanic_original, embarked_na = is.na(titanic_original$embarked))
summary(titanic_original$embarked_na)

###after viewing the summary there are only false objects which means the is.na function did not recognize the 3 empty cells, deleted the column
titanic_original$embarked_na <- NULL

###found the right method using a for/if statement, summarise now rendors 917 "S" which means the 3 unknowns have been converted correctly

for (i in 1:nrow(titanic_original)) 
  if (titanic_original$embarked[i] == "") {titanic_original$embarked[i] = "S" }
  summary(titanic_original$embarked)

##2 populate the missing age values with the mean of the age
###set na.arm to TRUE, mean is 29.8813 and replaced all NAs with the mean age, double checked it worked with is.na
age.mean <- mean(titanic_original$age, na.rm=TRUE)
titanic_original$age[is.na(titanic_original$age)] = age.mean
is.na(titanic_original$age)

##3 Fill in missing Lifeboat values with NA, converted boat to a chracter, replaced empty cells with "NA" and converted it back to a factor
class(titanic_original$boat)
titanic_original$boat <- as.character(titanic_original$boat)
titanic_original$boat[titanic_original$boat==""] <- "NA"
titanic_original$boat <- as.factor(titanic_original$boat)

##Created binary variable for has_cabin_number
titanic_original <- mutate(titanic_original, has_cabin_number = 0)

for (i in 1:nrow(titanic_original)) 
  if (titanic_original$cabin[i] != "") {titanic_original$has_cabin_number[i] = 1} 


