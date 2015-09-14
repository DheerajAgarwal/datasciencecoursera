# Data SOURCE: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# *****************************************************************
#---------------------PURPOSE OF THIS SCRIPT-----------------------
# *****************************************************************
#Question: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

#This Script:
        ## Creates the Plot 5 as per course project
        ## Uses the gglpot2
        ## Displays the graph to the user (the visual may or may not be displayed correctly, depending on your screen settings and size of the plot area on screen)
        ## Saves the graph as 'plot5.png' in the working directory

# *****************************************************************
#---------------------------IMPORTANT NOTE:------------------------
#1. This script will download the data, unzip and extract it for reading
#2. The file will take time to read. Please be patient.
#3. ****If you already have the data downloaded, please comment the download and unzip commands before sourcing the code.

# *****************************************************************
#-----------------------------PLOT 5-------------------------------
# *****************************************************************
# Downloading and Reading Data --------------------------------------------
print("Depending on your network bandwidth, this might take a few minutes. Please be patient!")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "exdata-data-NEI_data.zip", quiet=TRUE)
unzip("exdata-data-NEI_data.zip")
print("Data successfuly downloaded. Attempting to read data. Please wait!")
rm(list=ls())
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Baltimore <- NEI[NEI$fips=="24510",]
Baltimore$type <- as.factor(Baltimore$type)
Mobile <- SCC[with(SCC,  grepl("Mobile", SCC.Level.One)) , ]
Mobile <- Mobile[Mobile$EI.Sector!="Dust - Unpaved Road Dust",]
Mobile <- Mobile[Mobile$EI.Sector!="Dust - Paved Road Dust",]

index <- match(Mobile$SCC,Baltimore$SCC)
Blt_Mob <- Baltimore[na.omit(index),]
Blt_Mob$year <- as.factor(Blt_Mob$year)
print("Data reading is complete! Saving plot in your working directory.")
# Preparing Graphs --------------------------------------------------------
library(ggplot2)
        #Displaying graph on Screen

g <- ggplot(Blt_Mob,aes(x=year, y=Emissions))
g1 <- g+geom_point()+labs(title="Motor Vehicle Emissions in Baltimore")
print(g1)


        #Saving graph to disk
ggsave("./plot5.png", width = 8, height = 4, dpi = 120)
        # End of code.
print("All Done! Check out the plot in your working directory Thanks!")



