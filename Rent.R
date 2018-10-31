##Rent Data
library(tidyverse)
Rent <- read.csv("C:/Users/kfur006/Documents/GitHub/RentOct2018/detailed-mean-rents.csv",
  #"C:/Users/key_a/Desktop/Analysis/Rent Analysis/detailed-mean-rents.csv", 
                 header = T, stringsAsFactors = F) %>%
  filter(SAU != 0 & SAU != "529360") %>% 
  left_join(., read.csv("C:/Users/kfur006/Documents/GitHub/RentOct2018/Geographical Table.csv",
    #"C:/Users/key_a/Desktop/Analysis/Rent Analysis/Geographical Table.csv", 
                     header = T, stringsAsFactors = F) %>% mutate(SAU = as.character(SAU)), 
            by = "SAU", na_matches = "never") %>% 
  select(., -starts_with("X19")) %>% 
  gather(Time, Rent, -SAU, -Property_Type, -Bedrooms, -SAU.Desc, -TA, -Region, -Water) %>% 
  mutate(Year = substr(Time, 2,5),
         Month = substr(Time, 7,8),
         TA = case_when(is.na(TA) ~ "National Total",
                        TRUE ~ TA),
         SAU.Desc = case_when(is.na(SAU.Desc) ~ "National Total",
                              TRUE ~ SAU.Desc),
         Region = case_when(is.na(Region) ~ "National Total",
                            TRUE ~ Region))

names(Rent)
unique(Rent$Region)
glimpse(Rent)

glimpse(Rent[is.na(Rent$Water),])

group_by(Rent, Property_Type, Bedrooms, Region, Time, Year) %>% summarise(., Mean.Rent = mean(Rent, na.rm = T)) %>% 
  ggplot(., aes(x = Region, y = Mean.Rent, fill = Property_Type)) +
  geom_boxplot()
