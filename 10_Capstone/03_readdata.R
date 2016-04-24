#############################################
          #SCRIPT NUMBER: 03
          #AUTHOR: Dheeraj Agarwal
          #PURPOSE: Read Source and profane data
          #DEPENDENCIES: None
          #DATE: April 18, 2016
#############################################
temp <- file("en_US.blogs.txt", open = "rb")
blogs <- readLines(temp, encoding= "UTF-8", warn = F)
close(temp)

temp <- file("en_US.news.txt", open = "rb")
news <- readLines(temp, encoding= "UTF-8", warn = F)
close(temp)

temp <- file("en_US.twitter.txt", open = "rb")
twitter <- readLines(temp, encoding= "UTF-8", warn = F)
close(temp)

rm(temp)
blogs <- iconv(blogs, from="UTF-8", to="latin1", sub=" ")
news <- iconv(news, from="UTF-8", to="latin1", sub=" ")
twitter <- iconv(twitter, from="UTF-8", to="latin1", sub=" ")

profanity_list <- readLines("http://badwordslist.googlecode.com/files/badwords.txt", warn = F)
profanity_list <- tolower(profanity_list)
profanity_list <- str_replace_all(profanity_list, "\\(", "\\\\(")
saveRDS(profanity_list, file = "profanity_list.rds")
rm(profanity_list)

save.image("allsource.RData")
rm(list = ls())