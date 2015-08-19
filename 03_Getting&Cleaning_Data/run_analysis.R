# Data SOURCE: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#---------------------------IMPORTANT NOTE:------------------------
#1. This script will download the data, unzip and extract it for reading
#2. The extracted folder should have the name 'UCI HAR Dataset'
#3. If there is already a folder by that name, it is highly recommended to remove or rename it.
#4. The entire file will take time to read. Please be patient.

# *****************************************************************
#---------------------PURPOSE OF THIS SCRIPT-----------------------
# *****************************************************************

#This Script:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# *****************************************************************
#----------------------------CODE BOOK-----------------------------
# *****************************************************************
#CODE BOOK: <>

# *****************************************************************
#---------------------RUN ANALYSIS---------------------------------
# *****************************************************************


#--------------DOWNLOADING & READING THE DATA FILES---------------
        #This operation will require changing the working directory and hence a value of the current path is stored so that it could be reverted back to its original state.
baseWD <- getwd()

#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "UCI HAR Dataset.zip", quiet=TRUE)

#unzip("UCI HAR Dataset.zip")

setwd("./UCI HAR Dataset/")

path1 <- "./test"
path2 <- "./train"

flist1 <- list.files(path1, "*txt$", full.names = TRUE)
flist2 <- list.files(path2, "*txt$", full.names = TRUE)

file.copy(flist1,"./")
file.copy(flist2,"./")

#Reading all necessary files from test and train folders.
library(utils)
print("Depending on your network bandwidth, this might take a few minutes. Please be patient!")

activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
features <- features["V2"]
features <- t(features)
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
X_test <- read.table("X_test.txt")

X_train <- read.table("X_train.txt")


y_test <- read.table("y_test.txt")
y_train <- read.table("y_train.txt")

print("Almost done!")

#Removing temporary variables & restoring the folders to original state
setwd(baseWD); rm(baseWD)
#file.remove(flist1); file.remove(flist2) --- incorrect command.
rm(path1);rm(path2)
rm(flist1);rm(flist2)

#-----------------------------MERGING THE DATA FILES-----------------------------
# Completes steps 1 to 4 of the question. Not necessariliy in the same order

#STEP A:
        #Merging the test & train files together & creating meaningful names
                #Step_A1: binding the data into columns
test_data <- cbind(subject_test,y_test, X_test)
train_data <- cbind(subject_train,y_train, X_train)
master_data <- rbind(test_data,train_data)

                #Step_A2: adding the columns names
names(master_data) <- c("Subject","Activity",features)
master_data$Activity <- as.factor(master_data$Activity)

                # Step_A3: adding descriptive activity to activity code.
levels(master_data$Activity) <- activity_labels$V2

        # The master_data file is now our base file on which all operations will be performed. Since the other individual data sets are no longer required, they are deleted
rm(features)
rm(subject_test); rm(X_test); rm(y_test)
rm(subject_train); rm(X_train); rm(y_train)
rm(test_data); rm(train_data)
rm(activity_labels)

#STEP B:
        # Extract mean and st. deviation columns from master data
inc_filter <- c("[Mm]ean\\(\\)","[Ss]td\\(\\)", "Subject", "Activity")
master_ms <- master_data[, grep(paste(inc_filter,collapse = "|"), names(master_data))]

#STEP C:
        #Subset and calculate mean for every column in the result of previous step.
group_by <- c("Subject","Activity")
datadim <- dim(master_ms)
totcol <- datadim[2]
result_unsorted <- aggregate(master_ms[3:totcol], by=master_ms[group_by], FUN=mean)


result <- result_unsorted[with(result_unsorted, order(Subject, Activity)), ]

        # deleting unnecessary variable
rm(master_data);rm(master_ms); rm(datadim); rm(totcol);
rm(inc_filter); rm(group_by); rm(result_unsorted)

cat(rep("\n",2))
print("Opening the TIDY data in view mode. Please check out source pane!")
View(result)
Sys.sleep(5)

cat(rep("\n",2))
print("The output has the following rows and columns")
print(dim(result))
Sys.sleep(3)

cat(rep("\n",2))
print("Displaying the first 6 rows and 4 columns")
print(head(result[1:4]))

cat(rep("\n",2))
print("You are all set to use this data for any further anlysis")

