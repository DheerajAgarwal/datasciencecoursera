# Data SOURCE: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# *****************************************************************
#---------------------PURPOSE OF THIS SCRIPT-----------------------
# *****************************************************************
#Question: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#This Script:
        ## Creates the Plot 1 as per course project
        ## Uses the base plotting
        ## Displays the graph to the user (the visual may or may not be displayed correctly, depending on your screen settings and size of the plot area on screen)
        ## Saves the graph as 'plot1.png' in the working directory

# *****************************************************************
#---------------------------IMPORTANT NOTE:------------------------
#1. This script will download the data, unzip and extract it for reading
#2. The file will take time to read. Please be patient.
#3. ****If you already have the data downloaded, please comment the download and unzip commands before sourcing the code.

# *****************************************************************
#-----------------------------PLOT 1-------------------------------
# *****************************************************************
# Downloading and Reading Data --------------------------------------------
print("Depending on your network bandwidth, this might take a few minutes. Please be patient!")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "exdata-data-NEI_data.zip", quiet=TRUE)
unzip("exdata-data-NEI_data.zip")
print("Data successfuly downloaded. Attempting to read data. Please wait!")
rm(list=ls())
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Total_Emmisssions <- aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum)
names(Total_Emmisssions) <- c("Year","Tot_Emssn")
print("Data reading is complete! Saving plot in your working directory.")
# Preparing Graphs --------------------------------------------------------
        #Displaying graph on Screen
with(Total_Emmisssions,plot(Year,Tot_Emssn, ylab = "Total Annual Emission", pch=20,cex=2,col="blue", main="Yearly Trend of Pm2.5 across US", xaxt='n'))
axis(side = 1, at=Total_Emmisssions$Year)
lin_model <- with(Total_Emmisssions,lm(Tot_Emssn~Year))
abline(lin_model)
        #Saving graph to disk
png("plot1.png")
with(Total_Emmisssions,plot(Year,Tot_Emssn, ylab = "Total Annual Emission", pch=20,cex=2,col="blue", main="Yearly Trend of Pm2.5 across US", xaxt='n'))
axis(side = 1, at=Total_Emmisssions$Year)
lin_model <- with(Total_Emmisssions,lm(Tot_Emssn~Year))
abline(lin_model)
dev.off()
        # End of code.
print("All Done! Check out the plot in your working directory Thanks!")



