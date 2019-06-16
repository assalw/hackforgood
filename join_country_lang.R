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


hackforgood_dataset <- read_delim("C:/Users/Gins - SI/Desktop/hackforgood_dataset.csv", 
                                  "~", escape_double = FALSE, trim_ws = TRUE)
train <- read_delim("C:/Users/Gins - SI/Desktop/train_labels.csv", ";")
train <- subset(train, select = c(-3))

join <- sqldf::sqldf("Select  hackforgood_dataset.sourcetext, train.* From train
                     left join hackforgood_dataset on train.filename = hackforgood_dataset.filename
                     ")
join_subset <- subset(join, select = c(-2))

write.csv(join_subset, "train_label_better.csv")


hackforgood_classification <- read_delim("C:/Users/Gins - SI/Desktop/hackforgood_classification.csv", 
                                         ";", escape_double = FALSE, trim_ws = TRUE)
#remap 1 and 0 to text

hackforgood_classification$Agriculture <- ifelse(0, " ", "Agriculture")

#[1] "filename"                                   "Agriculture"                               
#[3] "communities_and_human_settlements"          "conflict_and_development"                  
#[5] "culture_and_development"                    "education"                                 
#[7] "energy"                                     "environment"                               
#[9] "finance_and_financial_sector_development"   "gender"                                    
#[11] "governance"                                 "health_and_nutrition_and_population"       
#[13] "industry"                                   "informatics"                               
#[15] "information_and_communication_technologies" "infrastructure_economics_and_finance"      
#[17] "international_econmomics_and_trade"         "law_and_development"                       
#[19] "macroeconomics_and_economic_growth"         "poverty_reduction"                         
#[21] "private_sector_development"                 "public_sector_development"                 
#[23] "rural_development"                          "science_and_technology_development"        
#[25] "social_development"                         "social_protections_and_labor"              
#[27] "transport"                                  "urban_development"                         
#[29] "water_resource"                             "water_supply_and_sanitation"



for(i in 1:12136){
    hackforgood_classification$Agriculture[i] <- ifelse(hackforgood_classification$Agriculture[i] == 1,
                                                        names(hackforgood_classification)[2],
                                                        NA)
    
    hackforgood_classification$communities_and_human_settlements[i] <- ifelse(hackforgood_classification$communities_and_human_settlements[i] == 1,
                                                        names(hackforgood_classification)[3],
                                                        NA)
    
    hackforgood_classification$conflict_and_development[i] <- ifelse(hackforgood_classification$conflict_and_development[i] == 1,
                                                                              names(hackforgood_classification)[4],
                                                                              NA)
    
    hackforgood_classification$culture_and_development[i] <- ifelse(hackforgood_classification$culture_and_development[i] == 1,
                                                                     names(hackforgood_classification)[5],
                                                                     NA)
    
    hackforgood_classification$education[i] <- ifelse(hackforgood_classification$education[i] == 1,
                                                                    names(hackforgood_classification)[6],
                                                                    NA)
    hackforgood_classification$energy[i] <- ifelse(hackforgood_classification$energy[i] == 1,
                                                      names(hackforgood_classification)[7],
                                                      NA)
    hackforgood_classification$environment[i] <- ifelse(hackforgood_classification$environment[i] == 1,
                                                   names(hackforgood_classification)[8],
                                                   NA)
    hackforgood_classification$finance_and_financial_sector_development[i] <- ifelse(hackforgood_classification$finance_and_financial_sector_development[i] == 1,
                                                   names(hackforgood_classification)[9],
                                                   NA)
    hackforgood_classification$gender[i] <- ifelse(hackforgood_classification$gender[i] == 1,
                                                                                     names(hackforgood_classification)[10],
                                                                                     NA)
    hackforgood_classification$governance[i] <- ifelse(hackforgood_classification$governance[i] == 1,
                                                                                     names(hackforgood_classification)[11],
                                                                                     NA)
    hackforgood_classification$health_and_nutrition_and_population[i] <- ifelse(hackforgood_classification$health_and_nutrition_and_population[i] == 1,
                                                       names(hackforgood_classification)[12],
                                                       NA)
    hackforgood_classification$industry[i] <- ifelse(hackforgood_classification$industry[i] == 1,
                                                                                names(hackforgood_classification)[13],
                                                                                NA)
    hackforgood_classification$informatics[i] <- ifelse(hackforgood_classification$informatics[i] == 1,
                                                     names(hackforgood_classification)[14],
                                                     NA)
    hackforgood_classification$information_and_communication_technologies[i] <- ifelse(hackforgood_classification$information_and_communication_technologies[i] == 1,
                                                        names(hackforgood_classification)[15],
                                                        NA)
    hackforgood_classification$infrastructure_economics_and_finance[i] <- ifelse(hackforgood_classification$infrastructure_economics_and_finance[i] == 1,
                                                                                       names(hackforgood_classification)[16],
                                                                                       NA)
    hackforgood_classification$international_econmomics_and_trade[i] <- ifelse(hackforgood_classification$international_econmomics_and_trade[i] == 1,
                                                                                 names(hackforgood_classification)[17],
                                                                                 NA)
    hackforgood_classification$law_and_development[i] <- ifelse(hackforgood_classification$law_and_development[i] == 1,
                                                                               names(hackforgood_classification)[18],
                                                                               NA)
    hackforgood_classification$macroeconomics_and_economic_growth[i] <- ifelse(hackforgood_classification$macroeconomics_and_economic_growth[i] == 1,
                                                                names(hackforgood_classification)[19],
                                                                NA)
    hackforgood_classification$poverty_reduction[i] <- ifelse(hackforgood_classification$poverty_reduction[i] == 1,
                                                                names(hackforgood_classification)[20],
                                                                NA)
    hackforgood_classification$private_sector_development[i] <- ifelse(hackforgood_classification$private_sector_development[i] == 1,
                                                                names(hackforgood_classification)[21],
                                                                NA)
    hackforgood_classification$public_sector_development[i] <- ifelse(hackforgood_classification$public_sector_development[i] == 1,
                                                                names(hackforgood_classification)[22],
                                                                NA)
    hackforgood_classification$rural_development[i] <- ifelse(hackforgood_classification$rural_development[i] == 1,
                                                                names(hackforgood_classification)[23],
                                                                NA)
    hackforgood_classification$science_and_technology_development[i] <- ifelse(hackforgood_classification$science_and_technology_development[i] == 1,
                                                                names(hackforgood_classification)[24],
                                                                NA)
    hackforgood_classification$social_development[i] <- ifelse(hackforgood_classification$social_development[i] == 1,
                                                                               names(hackforgood_classification)[25],
                                                                               NA)
    hackforgood_classification$social_protections_and_labor[i] <- ifelse(hackforgood_classification$social_protections_and_labor[i] == 1,
                                                               names(hackforgood_classification)[26],
                                                               NA)
    hackforgood_classification$transport[i] <- ifelse(hackforgood_classification$transport[i] == 1,
                                                               names(hackforgood_classification)[27],
                                                               NA)
    hackforgood_classification$urban_development[i] <- ifelse(hackforgood_classification$urban_development[i] == 1,
                                                               names(hackforgood_classification)[28],
                                                               NA)
    hackforgood_classification$water_resource[i] <- ifelse(hackforgood_classification$water_resource[i] == 1,
                                                               names(hackforgood_classification)[29],
                                                               NA)
    hackforgood_classification$water_supply_and_sanitation[i] <- ifelse(hackforgood_classification$water_supply_and_sanitation[i] == 1,
                                                               names(hackforgood_classification)[30],
                                                               NA)
    
    
    #[25] "social_development"                         "social_protections_and_labor"              
    #[27] "transport"                                  "urban_development"                         
    #[29] "water_resource"                             "water_supply_and_sanitation"
    
}

hackforgood_classification
#make one column with all categories
hackforgood_classification$label <- paste0(hackforgood_classification$Agriculture,
                                   hackforgood_classification$communities_and_human_settlements,
                                   hackforgood_classification$conflict_and_development,
                                   hackforgood_classification$education,
                                   hackforgood_classification$energy,
                                   hackforgood_classification$environment,
                                   hackforgood_classification$finance_and_financial_sector_development,
                                   hackforgood_classification$gender,
                                   hackforgood_classification$governance,
                                   hackforgood_classification$health_and_nutrition_and_population,
                                   hackforgood_classification$industry,
                                   hackforgood_classification$informatics,
                                   hackforgood_classification$information_and_communication_technologies,
                                   hackforgood_classification$infrastructure_economics_and_finance,
                                   hackforgood_classification$international_econmomics_and_trade,
                                   hackforgood_classification$law_and_development,
                                   hackforgood_classification$macroeconomics_and_economic_growth,
                                   hackforgood_classification$poverty_reduction,
                                   hackforgood_classification$private_sector_development,
                                   hackforgood_classification$public_sector_development,
                                   hackforgood_classification$rural_development,
                                   hackforgood_classification$science_and_technology_development,
                                   hackforgood_classification$social_development,
                                   hackforgood_classification$social_protections_and_labor,
                                   hackforgood_classification$transport,
                                   hackforgood_classification$urban_development,
                                   hackforgood_classification$water_resource,
                                   hackforgood_classification$water_supply_and_sanitation,
                                   sep=",")

#remove NAs
hackforgood_classification$label <- gsub("NA, ","",hackforgood_classification$label)
#df.apply(lambda x: x.astype(str).str.upper())

hackforgood_classification.apply(lambda x: x.astype(str).str.lower())

#map the 10 catgeories to the 30 from UN
twb_categories <- read_delim("C:/Users/Gins - SI/Desktop/Mapping29_11categories.csv", 
                                     ";", escape_double = FALSE, trim_ws = TRUE)

library(reshape2)

hack_long <- melt(hackforgood_classification, id.vars = c("filename"))

joined_mapp <- sqldf::sqldf("Select twb_categories.*, hack_long.* from hack_long
                            left join twb_categories on categories = value")




         