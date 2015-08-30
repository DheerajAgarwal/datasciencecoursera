# This is the complete solution for Quiz 4 of Getting & Cleaning Data Course at Coursera. The solution is for Questions 2,3 & 4.

#Source GDP: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

# Source Edu: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

#------------------------------------------------------------
# SECTION A - Sourcing the data

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

#------------------------------------------------------------
# SECTION B - Cleaning the data

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

#------------------------------------------------------------
# SECTION C - Quiz


        #********************************

#Ques2: Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

# Removing commas in GDP. This will coerce the values as characters
GDPInfo$GDP <- gsub(",","",GDPInfo$GDP)

# Caculating mean.

GDPMean <- mean(as.numeric(GDPInfo$GDP))

print("Answer to Ques2 is:"); print(GDPMean)

#********************************

#Ques3: In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

temp <- grep("^United",GDPInfo$Ctry.Name)

resultQ3 <- length(temp)

print("Answer to Ques3 is:"); print(resultQ3)

# removing the temporary variable(s)
rm(temp)

# NOTE: To view and validate the results use 'GDPInfo[temp,]'

#********************************

#Ques4: Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

# This question is tricky because the data that resembels year is present in several fields, however the one pertaining to this question is related to fiscal year. This is present in 'Special Notes'. You can identify this by searching for the word 'fiscal' in the entire dataset. At the wiring of this, I have not been able to figure out how to do that. I did visually inspect the data and identified the column.



# merging the two data frames
cons_data <- merge(x=GDPInfo,y=EduInfo, by.x="Ctry.Code",by.y = "CountryCode")

# sorting the result
cons_sorted <- arrange(cons_data,desc(Ranking))

#finding the logical vectors of the two critera
isFiscal <- grepl("[Ff]iscal", cons_sorted$Special.Notes)
isJune <- grepl("[Jj]une", cons_sorted$Special.Notes)

#assigning the result as a table
resultQ4 <- table(isFiscal, isJune)

print("Answer to Ques4 is:"); print(resultQ4[2,2])