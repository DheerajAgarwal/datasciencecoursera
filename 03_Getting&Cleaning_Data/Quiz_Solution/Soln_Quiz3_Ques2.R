#Source: https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

#Q: Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

##NOTE: Needs the package 'jpeg' for the solution to work.

#Reading the Source. readJPEG does not use URL as a source so the file needs to be downloaded first. The download feature is commented to avoid multiple downloads written in R for this exercise.
library(jpeg)

# Storing the source in an object for easier use
webSource <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

#defining the location and name of the file that will be saved.
location <- file.path("./Getting_Cleaning_Data/Z_Source_Data", "jeff.jpg")

#downloading the image file to the above loaction.
        #download.file(webSource,location,mode="wb")

# Reading the image
imgInfo <- readJPEG(location,native = TRUE)


# 30th & 80th quantile equate to probablities of 30% & 80% (.3,.8)
result <- quantile(imgInfo,c(.3,.8))

print(result)


