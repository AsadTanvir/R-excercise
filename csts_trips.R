library(tidyverse)
library(readxl)
library(plyr)
library(dplyr)

df <- read.csv("FullDataset_LinkedTrips_merged_attributes.csv")   #65103

## drop few 'columns'
df <- select(df, -c(linked_tripid,  tourid))

## Rename some long column names to short ones
colnames(df)
df <- dplyr::rename(df, o_address=o_address_recode_2_linked,
                               o_lat = o_lat_recode_2_linked, o_lng = o_lng_recode_2_linked, 
                               o_county = origin_county_linked, o_town = origin_town_linked, 
                               o_bg = origin_bg_geoid_linked, d_address = d_address_recode_linked, 
                               d_lat = d_lat_recode_linked, d_lng = d_lng_recode_linked, 
                               d_county = destination_county_recode_linked, d_town = destination_town_recode_linked, 
                               d_bg = destination_bg_geoid_recode_linked, mode=primary_mode_linked,
                    mode_category=primary_mode_category_linked)

## subset/filter only the HA inbound trips: transit and Auto [rows = filter()]
df_HA <- filter(df, o_bg != -999 & d_bg != -999 & d_county == "Hartford County" & 
                  o_county != "New London County" & o_county != "Fairfield County" & 
                  o_county != "Litchfield County" & o_county != "Windham County")        #16059
df_HA_transit <- filter(df_HA, mode_category == 6)  #552
table(df_HA_transit$mode)
df_HA_transit <- filter(df_HA_transit, mode != 13)  #551
df_HA_auto <- filter(df_HA, mode_category !=4 & mode_category !=6 & mode_category != 97) #13468
table(df_HA_auto$mode)

## How many of them have license? 
# df_license <- filter(df_HA_transit, license == 1)  #Yes=237; No=282; NA=33
## vehicles?
#df_veh <- filter(df_HA_transit, numvehicle>0) #221

## Value counts of OD pairs from transit trips
df_transOD <- add_count(df_HA_transit, o_bg, d_bg)
#df_odcnt <- arrange(df_odcnt, desc(n))    # descending by value of "n"
df_transOD_uniq <- unique(df_transOD[c('o_bg', 'd_bg', "n")])


## extracting auto trips from 'df_HA_auto' by matching OD pairs from 'df_transOD_uniq'
df_autoOD <- df_HA_auto[df_HA_auto$o_bg %in% df_transOD_uniq$o_bg & 
                          df_HA_auto$d_bg %in% df_transOD_uniq$d_bg,]


df_autoOD_uniq <- unique(df_autoOD[c('o_bg', 'd_bg')])
df_mixed_odcnt <- add_count(df_mixed, o_bg, d_bg)

## counts number of each value in a column in df
table(df_mixed_odcnt$n)
#df_mixed_odcnt2 <- filter(df_mixed_odcnt, n>1)

table(df_mixed_odcnt$mode)
df_mixed_new <- filter(df_mixed_odcnt, mode==8 & mode==9 & mode==11 & mode==12 & mode==14 &
                         mode==2 & mode==3 & mode==4 & mode==5 & mode==6)
