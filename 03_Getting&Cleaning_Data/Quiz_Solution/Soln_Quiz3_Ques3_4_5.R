#Source GDP: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

# Source Edu: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

#Ques3: Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?


#NOTE: The download feature is commented to avoid multiple downloads written in R for this exercise.

# Storing the source(s) in an object for easier use
GDPSource <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

EduSource <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

#defining the location and name of the file(s) that will be saved.
locationGDP <- file.path("./Getting_Cleaning_Data/Z_Source_Data", "Q3_Ques1_Data_GDP.csv")

locationEdu <- file.path("./Getting_Cleaning_Data/Z_Source_Data", "Q3_Ques1_Data_Edu.csv")

#downloading the csv files to the above loaction.
        #download.file(GDPSource,locationGDP,mode="wb")
        #download.file(EduSource,locationEdu,mode="wb")

# Reading the csv
GDPInfo <- read.csv(locationGDP,header = F)
EduInfo <- read.csv(locationEdu,header = T)

# Removing the temporary Source & location objects
rm(GDPSource);rm(EduSource);rm(locationGDP);rm(locationEdu)

#Using 'str' function and 'View', the following problems are noted for GDPInfo:
        # 1. Certain Columns are completely blank
        # 2. Certain rows are completely blank
        # 3. There are notes and comments present in data set.
        # 4. R may get confused reading the unstructured columns.
        # 5. The data is for multiple variable -  Countries & Income Groups. Income Groups are then broken down into further subgroups.

#NOTE: Next section needs 'dplyr' package installed.
library(dplyr)

##Cleaning dataset GDPInfo BEGINS.

##Step1: Renaming data set for cleaning steps and removing the original data set
BaseGDP_4 <- GDPInfo
rm(GDPInfo)

# Step2: creating columns names for easy filetring
colnames(BaseGDP_4) <- c("Ctry.Code","Ranking","V1","Ctry.Name","GDP")

# Step2: removing first 5 rows. 5 because that when the actual data starts
BaseGDP_3 <- BaseGDP_4[-c(1:5),]

#Step3: Removing unnecessary columns
BaseGDP_2 <- BaseGDP_3[,-c(3,6:10)]

#Step4: Removing rows where Rank is not defined.
        #Step4a: Mutating the class from factor to numeric. NAs will be introduced and is okay. Suppresswarning used
BaseGDP_1 <- suppressWarnings(mutate(BaseGDP_2,Ranking=as.numeric(levels(Ranking))[Ranking]))

        #Step4b: Removing rows with Rank as NA.
GDPInfo <- suppressWarnings(filter(BaseGDP_1,!is.na(Ranking)))

# Step5: Removing all temprary data.frames
rm(BaseGDP_4); rm(BaseGDP_3); rm(BaseGDP_2); rm(BaseGDP_1)

##Cleaning dataset GDPInfo ENDS.

#EduInfo is already structured based on str and View.

# merging the two data frames
cons_data <- merge(x=GDPInfo,y=EduInfo, by.x="Ctry.Code",by.y = "CountryCode")

# sorting the result
cons_sorted <- arrange(cons_data,desc(Ranking))

#Finding total records in the sorted results
num_records <- nrow(cons_sorted)

#Finding the name of the country at 13th position
record_num <- cons_sorted[13,3]

#Assigning the two temp objects as result
resultQ3 <- c(num_records, as.character(record_num))

#removing temporary variables
rm(num_records); rm(record_num)

#Printing results for Ques3
print("Answer to Ques3 is:"); print(resultQ3)

#--------------------------------------------------------------

##Ques4: What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

#Subsetting the data on income group as High income: OECD
a <- subset(cons_sorted, cons_sorted$Income.Group=="High income: OECD")

#Subsetting the data on income group as High income: nonOECD
b <- subset(cons_sorted, cons_sorted$Income.Group=="High income: nonOECD")

#Assigning the two temp objects as result
resultQ4 <- c(mean(a$Ranking),mean(b$Ranking))

#removing temporary variables
rm(a); rm(b)

#Printing results for Ques4
print("Answer to Ques4 is:"); print(resultQ4)

#--------------------------------------------------------------

##Ques5: Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

#Creating a smaller dataset for this question
#IncomeGrpData <- select(cons_sorted, 1:6)

# the next steps need 'Hmisc' installed

library(Hmisc)

#creating a new column that has 5groups based on rankings
cons_sorted$Groups <- cut2(cons_sorted$Ranking,g=5)

#Creating a temprary table of the above group vs Income.Group
temp <- table(cons_sorted$Groups, cons_sorted$Income.Group)

#Assigning the required output. Use row.names to get the row name.
resultQ5 <- temp["[  1, 39)","Lower middle income"]

#Printing results for Ques5
print("Answer to Ques5 is:"); print(resultQ5)











