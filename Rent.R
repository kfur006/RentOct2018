##Rent Data
library(tidyverse)
Rent <- read.csv("C:/Users/key_a/Desktop/Analysis/Rent Analysis/detailed-mean-rents.csv", 
                 header = T, stringsAsFactors = F) %>%
  filter(SAU != 0) %>% 
  left_join(., read.csv("C:/Users/key_a/Desktop/Analysis/Rent Analysis/Geographical Table.csv", 
                     header = T, stringsAsFactors = F) %>% mutate(SAU = as.character(SAU)), 
            by = "SAU") %>% 
  gather(Time, Rent, -SAU, -Property_Type, -Bedrooms, -SAU.Desc, -TA, -Region, -Water)

