#############################################
          #SCRIPT NUMBER: 02
          #AUTHOR: Dheeraj Agarwal
          #PURPOSE: Download & Unzip data
          #DEPENDENCIES: None
          #DATE: April 18, 2016
#############################################
unzipped_folder <- "C:/Users/DrjNupurVihan/Documents/R/Coursera/10.Capstone/en_US/"
unzipped_blogs_file <- paste(unzipped_folder, "en_US.blogs.txt", sep = "")
unzipped_twitter_file <- paste(unzipped_folder, "en_US.twitter.txt", sep = "")
unzipped_news_file <- paste(unzipped_folder, "en_US.news.txt", sep = "")
rm(unzipped_folder)

if (!file.exists(unzipped_blogs_file) |
    !file.exists(unzipped_twitter_file) |
    !file.exists(unzipped_news_file)) {
  local_zipfile <- "./Coursera-SwiftKey.zip"
  if (!file.exists(local_zipfile)) {
    url <- download.file("http://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip",
                         destemp = local_zipfile, mode = "wb")
  }
  unzip(local_zipfile, exdir = "./Coursera-SwiftKey")
  rm(local_zipfile)
}
