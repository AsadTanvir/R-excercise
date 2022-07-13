### Data transformation using "dplyr" package

install.packages("nycflights13")
library(tidyverse)
library(dplyr) 
library(nycflights13)

view(flights)
data <- flights

##1. Filter ROWS with "filter()" 
# subset by a date
May2 = filter(data, month==5, day==2)
Sep2 = filter(data, month==9, day==2)

# flights departing March or April
Mar_Apr <- filter(data, month==3 | month==4)
# flights not more than 2hrs delay
hrs2delay <- filter(data, dep_delay<=120 & arr_delay<=120)

# missing values ["is.na()" is used to determine if a value is missing]
df <- tibble(x = c(1, NA, 3))
(filter(df, x>=1))
is.na(df) # TRUE means NA

#arrival delay of two or more hours
ArrDelay2hr <- filter(data, arr_delay>=120)
#Were delayed by at least an hour, but made up over 30 minutes in flight
y <- filter(data, dep_delay>=60 & dep_delay-arr_delay >30)
#How many flights have a missing dep_time?
missing_deptime <- filter(data, is.na(data$dep_time))


## 2. Arrange rows with "arrange()"
?arrange() #sort in ascending order by default (all NA at the bottom)
depdel_asc <- arrange(data, dep_delay)
depdel_desc <- arrange(data, desc(dep_delay))

## 3. Select COLUMNS with "select()"
# Select all columns between year and day (inclusive)
select(data, year:day)

#Select all columns except those from year to day (inclusive)
select(data, -(year:day))

#"rename()" can be used to rename a column
data <- dplyr::rename(data, dist = distance) 
# When two or more packages (that are loaded) contain functions with the same name, 
# a double-colon operator :: needs to be used to get the version of the function 
# from the package that was not the last loaded package (in this case 'dplyr' and 'plyr' packages).

# Select helpers:: These functions allow selecting variables based on their names.
# "everything()" is used to bring specific column(s) in front
data <- select(data, time_hour, air_time, everything())

# "any_of()"
vars <- select(data, any_of(c("year", "month", "day", "dep_delay", "arr_delay")))

# contains()
select(flights, contains("TIME"))

# Adding new column by arithmetic operations of existing columns
data$gain <- data$dep_delay - data$arr_delay
data$speed <- data$distance / data$air_time * 60

# "x / sum(x)" calculates the proportion of a total
# "y - mean(y)" computes the difference from the mean
# Logs: log(), log2(), log10()
#Offsets: lead(), lag() allow to refer to leading or lagging values
#Cumulative & rolling aggr: cumsum(),cumprod(),cummin(),cummax()

## 4. summarise()