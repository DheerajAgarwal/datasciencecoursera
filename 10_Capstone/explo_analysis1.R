# *********************************************
#     Script 4
#     Author: Dheeraj Agarwal
#     Purpose: Perform some exploratory analysis on full data
#     Dependency: Script 3
#*********************************************
load("allsource.RData")

file.size("en_US.blogs.txt")
length(blogs) # no of lines in the file

file.size("en_US.news.txt")
length(news) # no of lines in the file

file.size("en_US.twitter.txt")
length(twitter) # no of lines in the file

summary(nchar(blogs))[6] # max characters in a line of the file
summary(nchar(news))[6] # max characters in a line of the file
summary(nchar(twitter))[6] # max characters in a line of the file

# sample size to be used for prediction
blogs_sample_size   <- round(.002 * length(blogs), 0)
news_sample_size    <- round(.002 * length(news), 0)
twitter_sample_size <- round(.002 * length(twitter), 0)

list <- c(blogs_sample_size, news_sample_size, twitter_sample_size)
save(list, file="samplesize.RData")

rm(list = ls())

