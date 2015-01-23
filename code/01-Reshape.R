### 01-Reshape.R
# install.packages("reshape2")
# library(reshape2)

## Tidy data

# Values in column names 

raw <- read.csv("data/pew.csv", check.names = F)

head(raw)

library(reshape2)
tidy <- melt(raw, id = "religion")

head(raw)
head(tidy)

names(tidy) <- c("religion", "income", "n")
tidy <- melt(raw, id = "religion", 
  variable.name = "income", value.name = "n")

# Variable names in cells

cat('\014')
getwd()
setwd("/prod/user/home/xtl476/ds_w_R/")

# check.names=F ensures that R does not change the column names
# if the column names contain $ sign, R may change the headers
# NAs are denoted by . in the dataset, na.strings tells R to treat
# . as NA

raw <- read.delim("data/weather.txt", check.names = F, na.strings = ".")

# Your Turn

# ------------------------------------------

#Pivot the data on multiple columns
#remove the NAs from the data

raw <- melt(raw, 
  id = c("year", "month", "element"),
  variable.name = "day", na.rm = TRUE)

#Convert the day to numeric
raw$day <- as.numeric(as.character(raw$day))

# Change the column order in the dataframe

raw <- raw[, c("year", "month", "day", "element", "value")]
# ------------------------------------------

head(raw)

#Change data from rows to columns
# Elements column values are used for column headers
# Value.var ="value" makes data re-distribute

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
tidy$rate <- round(tidy$survived / 
  (tidy$survived + tidy$perished), 2)
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