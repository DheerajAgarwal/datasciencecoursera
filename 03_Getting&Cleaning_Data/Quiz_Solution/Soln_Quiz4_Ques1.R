# This is the complete solution for Quiz 4 of Getting & Cleaning Data Course at Coursera. The solution is for Questions 1.

#Source https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

#CodeBook: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

#------------------------------------------------------------
# SECTION A - Sourcing the data

#NOTE: The download feature is commented to avoid multiple downloads written in R for this exercise.

# Storing the source(s) in an object for easier use
WebSource_data <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

WebSource_codebook <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"

#defining the location and name of the file(s) that will be saved.
location_data <- file.path("./Getting_Cleaning_Data/Z_Source_Data", "Q4_Ques1_Data.csv")

location_codebook <- file.path("./Getting_Cleaning_Data/Z_Source_Data", "Q4_Ques1_CodeBook.pdf")

#downloading the files to the above loaction.
        #download.file(WebSource_data,location_data,mode="wb")
        #download.file(WebSource_codebook,location_codebook,mode="wb")

# Reading the csv
Housing_Rec <- read.csv(location_data,header = TRUE)

# Removing the temporary Source & location objects
rm(WebSource_data);rm(WebSource_codebook);rm(location_data);rm(location_codebook)

#------------------------------------------------------------
# SECTION B - Quiz


        #********************************

#Ques1: Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

#converting all columns into lower case
varNames <- tolower(names(Housing_Rec))

#splitting the names based on the string
splitnames <- strsplit(varNames,"wgtp")

print("The answer to question 1 is"); print(splitnames[[123]])

#removing temporary variables
rm(varNames); rm(Housing_Rec)

