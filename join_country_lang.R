library(readr)
library(sqldf)
library(dplyr)
library(tidyr)

country <- read_delim("GitHub/hackforgood/country.csv", 
                      ";", escape_double = FALSE, trim_ws = TRUE)

country_alpha <- read_delim("GitHub/hackforgood/country_alpha.csv", 
                            ";", escape_double = FALSE, trim_ws = TRUE)

country <- as.data.frame(country) %>% separate(Language, into = paste("Lang", 1:3, sep = "_"))

country_capitals <- read_csv("GitHub/hackforgood/country-capitals.csv")

languagesshortname <- read_delim("GitHub/hackforgood/languagesshortname.csv", 
                                 ";", escape_double = FALSE, trim_ws = TRUE)



joined_ds <- sqldf::sqldf("SELECT country.*, country_alpha.* FROM country
                          left Join country_alpha
                          On country.Country = country_alpha.[country name]")

joined_ds <- sqldf::sqldf("Select country_capitals.*, joined_ds.* from country_capitals
                          left join joined_ds
                          on Country = CountryName")
joined_ds_lang <- sqldf::sqldf("Select joined_ds.*, languagesshortname.* from joined_ds
                               left join languagesshortname
                               on Lang_1 = [English name of Language]")

write.csv(joined_ds, file="joined_country_coords.csv")
write.csv(joined_ds_lang, file = "joined_country_coords_lang.csv")


hackforgood_dataset <- read_csv("C:/Users/Gins - SI/Desktop/hackforgood_dataset.csv")
