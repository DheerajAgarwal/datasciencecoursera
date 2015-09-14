# Data SOURCE: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# *****************************************************************
#---------------------PURPOSE OF THIS SCRIPT-----------------------
# *****************************************************************
#Question: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

#This Script:
        ## Creates the Plot 3 as per course project
        ## Uses the gglpot2
        ## Displays the graph to the user (the visual may or may not be displayed correctly, depending on your screen settings and size of the plot area on screen)
        ## Saves the graph as 'plot3.png' in the working directory

# *****************************************************************
#---------------------------IMPORTANT NOTE:------------------------
#1. This script will download the data, unzip and extract it for reading
#2. The file will take time to read. Please be patient.
#3. ****If you already have the data downloaded, please comment the download and unzip commands before sourcing the code.

# *****************************************************************
#-----------------------------PLOT 3-------------------------------
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
Total_Emmisssions <- aggregate(Baltimore$Emissions, by=list(Baltimore$year,Baltimore$type), FUN=sum)
names(Total_Emmisssions) <- c("Year","Type","Emissions")
print("Data reading is complete! Saving plot in your working directory.")
# Preparing Graphs --------------------------------------------------------
library(ggplot2)
        #Displaying graph on Screen

g <- ggplot(Total_Emmisssions,aes(x=Year, y=Emissions, colour=Type))
g1 <- g+geom_point()
g2 <- g1+facet_grid(. ~ Type)
g3 <- g2+geom_smooth(method="lm", se=FALSE)


        #Saving graph to disk
ggsave("./plot3.png", width = 8, height = 4.5, dpi = 120)
        # End of code.
print("All Done! Check out the plot in your working directory Thanks!")



