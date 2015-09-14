# Data SOURCE: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# *****************************************************************
#---------------------PURPOSE OF THIS SCRIPT-----------------------
# *****************************************************************

#This Script:
        ## Creates the Plot 1 as per course project
        ## Creates a histogram for Global Active Power
        ## Displays the graph to the user
        ## Saves the graph as 'plot1.png' in the working directory

# *****************************************************************
#---------------------------IMPORTANT NOTE:------------------------
#1. This script will download the data, unzip and extract it for reading
#2. The extracted file will have the name 'household_power_consumption.txt'
#3. If there is already a file by that name, it is highly recommended to remove or rename it.
#4. The file will take time to read. Please be patient.
#5. ****If you already have the data downloaded, please comment the download and unzip commands before sourcing the code.

# *****************************************************************
#--------PLOT 1: Global Active Power-------------------------------
# *****************************************************************

# Downloading and extracting the data from source

print("Depending on your network bandwidth, this might take a few minutes. Please be patient!")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "exdata-data-household_power_consumption.zip", quiet=TRUE)

unzip("exdata-data-household_power_consumption.zip")

print("Data successfuly downloaded and unzipped!")

print("Clearing any other objects in memory to avoid data integrity issues...")

rm(list=ls())

print("This is a huge data set, however needs only data for two days. To avoid straining the memory, R will attempt to read only relevant data. This may take time!")
filter <- c("1/2/2007","2/2/2007")

input <- subset(read.table("./household_power_consumption.txt",sep = ";", header = TRUE),read.table("./household_power_consumption.txt",sep = ";", header = TRUE)$Date %in% c("1/2/2007","2/2/2007"))

print("Data reading is complete!")

input$Global_active_power <- as.numeric(as.character(input$Global_active_power))

input$Date <- as.Date(input$Date, format = "%d/%m/%Y")

cat(rep("\n",2))
print("Creating histogram with device as screen as per the project objctives")
Sys.sleep(2)

hist(input$Global_active_power, xlab="Global Active Power (kilowatts)",col="red", main = "Global Active Power")

print("Saving histogram with device as png as per the project objctives")
dev.copy(png, file="plot1.png")
dev.off()