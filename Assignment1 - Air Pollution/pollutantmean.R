# Programming Assignment 1 - Part 1  of Air Pollution
pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1
        ## indicating the location of the CSV files
        allfiles <- list.files(directory,full.names = TRUE)

        ## 'pollutant' is a character vector of length 1
        ## indicating the name of the pollutant for which we will
        ## calculate the mean; either "sulfate" or "nitrate".
       polltype <- c(pollutant)

        ## 'id' is an integer vector indicating the monitor IDs
        ## to be used
        cons_file <- c()
        for (i in id){
                data <- read.csv(allfiles[i], header = T)
                cons_file <- rbind(cons_file, data)
        }
        ## Return the mean of the pollutant across all
        ## monitors list in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!
       # mean(cons_file[,polltype], na.rm = T)
        mean(cons_file[,polltype], na.rm = T)
}