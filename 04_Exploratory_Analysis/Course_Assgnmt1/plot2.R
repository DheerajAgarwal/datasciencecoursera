# Data SOURCE: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# *****************************************************************
#---------------------PURPOSE OF THIS SCRIPT-----------------------
# *****************************************************************

#This Script:
        ## Creates the Plot 2 as per course project
        ## Creates a line graph for Global Active Power against time
        ## Displays the graph to the user
        ## Saves the graph as 'plot2.png' in the working directory

# *****************************************************************
#---------------------------IMPORTANT NOTE:------------------------
#1. This script will download the data, unzip and extract it for reading
#2. The extracted file will have the name 'household_power_consumption.txt'
#3. If there is already a file by that name, it is highly recommended to remove or rename it.
#4. The file will take time to read. Please be patient.

#5. ****If you already have the data downloaded, please comment the download and unzip commands before sourcing the code.

# *****************************************************************
#--------PLOT 2: Global Active Power against time------------------
# *****************************************************************

# Downloading and extracting the data from source

print("Depending on your network bandwidth, this might take a few minutes. Please be patient!")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "exdata-data-household_power_consumption.zip", quiet=TRUE)

unzip("exdata-data-household_power_consumption.zip")

print("Data successfuly downloaded and unzipped!")

rm(list=ls())

print("The following solution uses 'sqldf' & 'dplyr' package. If it is not installed, please install. If present, no action is required. Attempting to read the data.")

suppressWarnings(library(sqldf)) ;suppressWarnings(library(dplyr))

input <- read.csv.sql("./household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')",header = TRUE, sep = ";")

closeAllConnections()

print("Data reading is complete!")

input$Global_active_power <- as.numeric(as.character(input$Global_active_power))

input$Date <- as.Date(input$Date, format = "%d/%m/%Y")

input <- mutate(input, DateTime = paste(input$Date,input$Time))
input$DateTime <- strptime(input$DateTime, format = "%Y-%m-%d %H:%M:%S")

print("Data formatting is complete. Creating graph.")

plot(input$DateTime,input$Global_active_power, xlab = " ", ylab = "Global Active Power (kilowatts)", type = "n")
lines(input$DateTime,input$Global_active_power)

print("Saving graph with device as png as per the project objctives")
dev.copy(png, file="plot2.png")
dev.off()



