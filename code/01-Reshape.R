### 01-Reshape.R
# install.packages("reshape2")
# library(reshape2)

## Tidy data

# Values in column names 

setwd("C:/Users/Rahul/Documents/Oreilly/Intro_to_DS_with_R/Introduction-to-Data-Science-with-R")
getwd()

raw <- read.csv("data/pew.csv", check.names = F)

head(raw)

library(reshape2)

#Melt makes the data tidy by transposing the data, pivoting the data
#id is the column which should be kept the same
#It will be kept as the column on which the data is pivoted

tidy <- melt(raw, id = "religion")

#The columns of melt return the names as 
#"variable"- Variable which is kept the same
#"value"- Value is the column which is re-distributed

head(raw)
head(tidy)

#Rename the columns after melt
names(tidy) <- c("religion", "income", "n")

#Renae the column in the melt statement
tidy <- melt(raw, id = "religion", 
  variable.name = "income", value.name = "n")



# Variable names in cells
#Each column is labeled with a day number
cat('\014')
#rm(list=ls(all=TRUE))
rm(list=ls())
# Your Turn
raw <- read.delim("data/weather.txt", check.names = F, na.strings = ".")

# ------------------------------------------
raw <- melt(raw, 
  id = c("year", "month", "element"),
  variable.name = "day", na.rm = TRUE)

str(raw)
#day is a character factor with levels
#convert day to numeric
raw$day <- as.numeric(as.character(raw$day))
raw <- raw[, c("year", "month", "day", "element", "value")]
# ------------------------------------------

head(raw)

tidy <- dcast(raw, year + month + day ~ element, 
  value.var = "value")

tidy <- dcast(raw, ... ~ element, value.var = "value")

titanic2 <- read.csv("data/titanic2.csv",
  stringsAsFactors = FALSE)

head(titanic2)

# Your Turn
# ------------------------------------------
tidy <- melt(titanic2, id = c("class", "age", "fate"), 
  variable.name = "gender")
head(tidy)
tidy <- dcast(tidy, class + age + gender ~ fate, 
  value.var = "value")
head(tidy)
titanic$rate <- round(titanic$survived / 
  (titanic$survived + titanic$perished), 2)
head(tidy)
# ------------------------------------------

# Data split across many files

df1 <- data.frame(color = "white", value = c(3, 4))
df2 <- data.frame(color = "blue", value = c(3, 4, 5))
rbind(df1, df2)

df1 <- data.frame(color = "white", value = c(1, 2, 3))
df2 <- data.frame(x = c("a", "b", "c"), n = c(3, 4, 5))
cbind(df1, df2)

# Saving Data

write.csv(tidy, file = "tidy.csv", row.names = FALSE)
saveRDS(tidy, "tidy.rds")
tidy2 <- readRDS("tidy.rds")

write.csv(tidy, file = bzfile("tidy.csv.bz2"), row.names = FALSE)
tidy3 <- read.csv("tidy.csv.bz2")