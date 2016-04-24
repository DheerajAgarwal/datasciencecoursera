#############################################
          #SCRIPT NUMBER: 05
          #AUTHOR: Dheeraj Agarwal
          #PURPOSE: Load all necessary libraries
          #DEPENDENCIES: Script 3 & 4
          #DATE: April 18, 2016
#############################################


# Creating cleaned version of the data for processing
suppressMessages(source("01_libraries.R"))
source("03_cleaner.R")

load("allsource.RData")

blogs <- CleanR(blogs)
blogs <- Splitter(blogs)

news <- CleanR(news)
news <- splitter(news)

twitter <- CleanR(twitter)
twitter <- Splitter(blogs)

alldata <- c(blogs, twitter, news)
rm(blogs, twitter, news)
save(alldata, file = "cleandata.RData")


#Creating Traning data set

set.seed(42)
inFrame <- createDataPartition(y = 1:length(alldata), p = 0.15, list = F)
train <- alldata[inFrame]
rm(alldata, inFrame)

train <- CleanR(train)

save(train, file = "train.RData")
rm(list=ls())