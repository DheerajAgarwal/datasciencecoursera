#QUIZ 1 - Getting & Cleaning Data
## This contains the steps to reporduce the quiz results

### PART 1: Source: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

####Q1: How many properties are worth $1,000,000 or more?
        # Assign URL to a objct for easy usage
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
        #Download the data in the path you want with a name you want
download.file(fileURL,destfile = "./Getting_Cleaning_Data/Z_Source_Data/Q1_Ques1n2_Data.csv")

        # Read the data into a variable
input <- read.csv("./Getting_Cleaning_Data/Z_Source_Data/Q1_Ques1n2_Data.csv")
        # Property Value defined in variable Val (from the support PDF)
        # filtering the val 24(code for $1mil and above)
output <- subset(input, input$VAL==24)
        # no of rows meeting the criteria
nrow(output)


####Q2: Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?

        # ANS: Watch the video 'Components of Tidy Data'.
                ##Slide 4. Time 2:43

### PART 2: Source: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx. Read rows 18-23 and columns 7-15 into R and assign to 'dat'. Don't forget to install xlsx. Make sure you have Java RunTime v6.45 installed on your machine, else the XL package will not load post install

####Q3: What is the value of: sum(dat$Zip*dat$Ext,na.rm=T)
        # Assign URL to a objct for easy usage
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

        #Download the data in the path you want with a name you want.
        #Mode="wb" required to read as ASCII (binary). Else it fails to open.
download.file(fileURL,destfile = "./Getting_Cleaning_Data/Z_Source_Data/Q1_Ques3_Data.xlsx", mode="wb")

filepath <- "./Getting_Cleaning_Data/Z_Source_Data/Q1_Ques3_Data.xlsx"



        #Defines rows & cols needed for the question
rowidx <- 18:23
colidx <- 7:15

library(xlsx)
        #Extract only necessary data. Assign to 'dat'
dat <- read.xlsx(filepath,sheetIndex = 1,rowIndex = rowidx,colIndex = colidx)

sum(dat$Zip*dat$Ext,na.rm=T)

### PART 3: Source: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml. Don't forget to install XML

####Q4: How many restaurants have zipcode 21231?
        # Assign URL to a objct for easy usage
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
filepath <- "./Getting_Cleaning_Data/Z_Source_Data/Q1_Ques4_Data.xml"

download.file(fileURL, filepath)

library(XML)
        # Read(Parse) XML document
doc <- xmlTreeParse(filepath,useInternal=T)
        #identify the Root node.
rootNode <- xmlRoot(doc)

        #Iterate each sub node. One example shown here.
rootNode[[1]][[1]][[2]]
        #add the value of 'zipcode' (a subnode) of rootnode to an object
a <- xpathSApply(rootNode,"//zipcode",xmlValue)
        #filter the object to retain only required value
b <- a==21231
        #find the count
sum(b)


### PART 4: Source: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv. Use the fread function to read into 'DT'. Dont forget data.table

####Q5: Which of the following is the fastest way to calculate the average value of the variable pwgtp15 broken down by sex using the data.table package? (Refer to options in the quiz)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

filepath <- "./Getting_Cleaning_Data/Z_Source_Data/Q1_Ques5_Data.csv"

download.file(fileURL, filepath)
