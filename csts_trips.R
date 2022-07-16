library(tidyverse)
library(readxl)
library(plyr)
library(dplyr)

df <- read.csv("FullDataset_LinkedTrips_merged_attributes.csv")   #65103

## drop few 'columns'
df <- select(df, -c(linked_tripid,  tourid, primary_mode_category_linked_recode))

## Rename some long column names to short ones
colnames(df)
df <- dplyr::rename(df, o_address=o_address_recode_2_linked,
                               o_lat = o_lat_recode_2_linked, o_lng = o_lng_recode_2_linked, 
                               o_county = origin_county_linked, o_town = origin_town_linked, 
                               o_bg = origin_bg_geoid_linked, d_address = d_address_recode_linked, 
                               d_lat = d_lat_recode_linked, d_lng = d_lng_recode_linked, 
                               d_county = destination_county_recode_linked, d_town = destination_town_recode_linked, 
                               d_bg = destination_bg_geoid_recode_linked, mode=primary_mode_linked,
                    mode_category=primary_mode_category_linked, dep_time=departure_time_hhmm_linked,
                    arr_time=arrival_time_hhmm_linked,duration=reported_duration_linked_recode, transit_line=transit_line_linked,
                    o_addr=o_address_recode_2_linked, d_addr=d_address_recode_linked,transfer=transit_transfers_llinked)

## subset/filter only the HA inbound trips: transit and Auto [rows = filter()]
df_HA <- filter(df, o_bg != -999 & d_bg != -999 & d_county == "Hartford County" & 
                  o_county != "New London County" & o_county != "Fairfield County" & 
                  o_county != "Litchfield County" & o_county != "Windham County")     #16059
df_HA_transithh <- filter(df_HA, df_HA$transithh==1)  # HH used transit on travel day = 1351

#df_HA_transit1 <- filter(df_HA, mode_category == 6)  #552
df_HA_transit <- filter(df_HA_transithh, mode_category==6) #552
table(df_HA_transit$mode)
df_HA_transit <- filter(df_HA_transit, mode != 13)  #551 

df_HA_auto <- filter(df_HA_transithh, mode_category !=4, mode_category !=6, mode_category != 97) #502
table(df_HA_auto$mode)

## How many of them have license? 
# df_license <- filter(df_HA_transit, license == 1)  #Yes=237; No=282; NA=33
## vehicles?
#df_veh <- filter(df_HA_transit, numvehicle>0) #221

## Value counts of OD pairs from transit trips
df_transOD <- add_count(df_HA_transit, o_bg, d_bg)
df_transOD <- select(df_transOD,o_bg,d_bg,dep_time,arr_time,duration,n,o_addr,d_addr,transit_line,transfer,everything())
df_transOD <- arrange(df_transOD, desc(n))
#df_odcnt <- arrange(df_odcnt, desc(n))    # descending by value of "n"
df_transOD_uniq <- unique(df_transOD[c('o_bg', 'd_bg', "n")])


## extracting auto trips from 'df_HA_auto' by matching OD pairs from 'df_transOD_uniq'
df_autoOD <- df_HA_auto[df_HA_auto$o_bg %in% df_transOD_uniq$o_bg & 
                          df_HA_auto$d_bg %in% df_transOD_uniq$d_bg,]
df_autoOD_uniq <- unique(df_autoOD[c('o_bg', 'd_bg')])

## Export the data as csv
write.csv(df_HA_transit, 
          file = "C:/Users/aht17001/Documents/MEGA/UCONN/CSTS Data/DataDriven_csts/csts_HA_transit.csv", row.names=F)
write.csv(df_HA_auto, file = "C:/Users/aht17001/Documents/MEGA/UCONN/CSTS Data/DataDriven_csts/csts_HA_auto.csv",
          row.names = F)
