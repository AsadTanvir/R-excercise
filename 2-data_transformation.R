## Data transformation using "dplyr" package

install.packages("nycflights13")
library(tidyverse)
library(dplyr) 
library(nycflights13)

view(flights)
data <- flights

#1. Filtering [complicating to use if not understood]
# subset by a date
May2 = filter(data, month==5, day==2)
Sep2 = filter(data, month==9, day==2)

# flights departing March or April
Mar_Apr <- filter(data, month==3 | month==4)

# flights not more than 2hrs delay
hrs2 <- filter(data, dep_delay<=120 & arr_delay<=120)

# missing values