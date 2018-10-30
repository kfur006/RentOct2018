##Rent Data
library(tidyverse)
Rent <- read.csv("C:/Users/kfur006/Documents/GitHub/RentOct2018/detailed-mean-rents.csv",
  #"C:/Users/key_a/Desktop/Analysis/Rent Analysis/detailed-mean-rents.csv", 
                 header = T, stringsAsFactors = F) %>%
  filter(SAU != 0) %>% 
  left_join(., read.csv("C:/Users/kfur006/Documents/GitHub/RentOct2018/Geographical Table.csv",
    #"C:/Users/key_a/Desktop/Analysis/Rent Analysis/Geographical Table.csv", 
                     header = T, stringsAsFactors = F) %>% mutate(SAU = as.character(SAU)), 
            by = "SAU",na_matches = "never") %>% 
  select(., -starts_with("X19")) %>% 
  gather(Time, Rent, -SAU, -Property_Type, -Bedrooms, -SAU.Desc, -TA, -Region, -Water) %>% 
  mutate(Year = substr(Time, 2,5))

group_by(Rent, )