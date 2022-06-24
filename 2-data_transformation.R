## Data transformation using "dplyr" package

install.packages("nycflights13")
library(tidyverse)
library(dplyr) 
library(nycflights13)

view(flights)
data <- flights

#1. Filtering [kind of complicated if not understood properly]
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

# arrival delay of two or more hours
ArrDelay2hr <- filter(data, arr_delay>=120)
#Flew to Houston
Houston <- filter(data, dest == 'IAH' | dest == 'HOU')
#How many flights have a missing dep_time?
missingdep_time <- filter(data, is.na(data$dep_time))
