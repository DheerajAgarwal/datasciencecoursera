#Source: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

#Q: Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. which(agricultureLogical) What are the first 3 values that result?


#Reading the Source
        #Approach 1:
#URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
#download.file(URL,"./03.Getting_Cleaning_Data/Quiz3Ques1.csv")
#Source <- read.csv("Quiz3Ques1.csv")

        #Approach 2:
Source <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", header = T)

##NOTE: An alterntive way would be to download the file manually and save it to the local disk rather than reading from the web and then reading from the drive.

# Creating a logical vector meeting the criteria
agricultureLogical <- Source$ACR==3 & Source$AGS==6

#extracting the values using which
result <- which(agricultureLogical)

#printing the first 3 values
print(result[1:3])