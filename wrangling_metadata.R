setwd('D:/Translators Without Borders')

library(dplyr)
library(readr)
library(sqldf)
library(ggplot2)
library(tidyr)
library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) #cluster algo + viz
library(dummies)
library(tibble)  # for `rownames_to_column` and `column_to_rownames`
library(actuar)

#load the main file
metadata <- read_delim("Hackathon-for-Good-2019_TWB-Challenge_Metadata.csv", ";", escape_double = FALSE, trim_ws = TRUE)

#select only the meaningful columns
metadata <- subset(metadata, select = 1:10)

#get the number of requests by each NGO
ngo_proc <- metadata %>% group_by(Date,
                                  Filename, 
                                  Source_lang,
                                  Target_lang,
                                  NGO) %>% summarise(n_reqs = length(Filename))

#get the name of all the ngos from the metadata
ngo <- unique(metadata$NGO)

#counts of NGOs
# counts
counts_ngos <- ngo_proc %>% group_by(NGO, word_) %>% summarise(n_reqs_total = length(Filename),
                                                        n_wordcounts_total = sum())

#make plot of counts of NGO
counts_NGO_plot <- counts_ngos %>% ggplot(aes(x = reorder(NGO, -n_reqs_total), y = n_reqs_total)) +
    geom_col(fill = 'skyblue') +
    ggtitle("Plot of counts of NGOs") +
    xlab("NGO name") + 
    ylab("no_rows") +
    theme_classic() +
    theme(axis.text.x=element_text(angle=45, hjust=1))






library(RCurl)
library(XML)
#ConnString <- "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.dividendhistory%20where%20symbol%20%3D%20%22KO%22%20and%20startDate%20%3D%20%222012-01-01%22%20and%20endDate%20%3D%20%222013-12-31%22&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"

directory <- "D:/Translators Without Borders/hackathon-for-good-2019_TWB-challenge_files/"
files <- list.files(directory,
                    pattern = "*.sdlxliff")

readin_df <- data.frame()
for (f in files) {
    df <- xmlParse(f)
    print(df)
}

x <- xmlParse("D:/Translators Without Borders/hackathon-for-good-2019_TWB-challenge_files/-_KeyMessages_GPDRR2017.docx.sdlxliff")  
xpathSApply(x,"//*[name()='source']", xmlValue)






