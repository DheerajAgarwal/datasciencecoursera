# Data SOURCE: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# *****************************************************************
#---------------------PURPOSE OF THIS SCRIPT-----------------------
# *****************************************************************
#Question: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

#This Script:
        ## Creates the Plot 4 as per course project
        ## Uses the gglpot2
        ## Displays the graph to the user (the visual may or may not be displayed correctly, depending on your screen settings and size of the plot area on screen)
        ## Saves the graph as 'plot4.png' in the working directory

# *****************************************************************
#---------------------------IMPORTANT NOTE:------------------------
#1. This script will download the data, unzip and extract it for reading
#2. The file will take time to read. Please be patient.
#3. ****If you already have the data downloaded, please comment the download and unzip commands before sourcing the code.

# *****************************************************************
#-----------------------------PLOT 4-------------------------------
# *****************************************************************
# Downloading and Reading Data --------------------------------------------
print("Depending on your network bandwidth, this might take a few minutes. Please be patient!")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "exdata-data-NEI_data.zip", quiet=TRUE)
unzip("exdata-data-NEI_data.zip")
print("Attempting to read data. This could take upto several minutes. Please wait!")
rm(list=ls())
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Coal_Code <- SCC[with(SCC,  grepl("Coal", EI.Sector)) , ]
index <- match(Coal_Code$SCC,NEI$SCC)
Coal_Emsn <- NEI[na.omit(index),]
Coal_Emsn <- merge(Coal_Emsn,Coal_Code)


input <- aggregate(Coal_Emsn$Emissions, by=list(Coal_Emsn$year,Coal_Emsn$SCC.Level.Three), FUN=sum)
names(input) <- c("Year","Coal_Source","Emissions")
input$Coal_Source <- sub("Bituminous/Subbituminous Coal","Bitumin", input$Coal_Source)
input$Coal_Source <- sub("Commercial/Institutional","Commercial", input$Coal_Source)

print("Data reading is complete! Saving plot in your working directory.")
# Preparing Graphs --------------------------------------------------------
library(ggplot2)
        #Displaying graph on Screen

print("Coal Combustion Sources have been derived using 'SCC' and 'SCC.Level.Three' fields for which the values existed in atleast one year.")

g <- ggplot(input,aes(x=Year, y=Emissions))
g1 <- g+geom_point()
g2 <- g1+facet_grid(. ~ Coal_Source)
g3 <- g2+geom_smooth(method="lm", se=FALSE)


        #Saving graph to disk
ggsave("./plot4.png", width = 8, height = 4.5, dpi = 120)
        # End of code.
print("All Done! Check out the plot in your working directory Thanks!")



