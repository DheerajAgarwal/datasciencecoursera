# Programming Assignment 1 - Part 3  of Air Pollution
corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        allfiles <- list.files(directory, full.names = T)
        totalfiles <- length(allfiles)
        results <- c()

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        for (i in 1:totalfiles) {
                filedata <- read.csv(allfiles[i])
                compobs <- complete.cases(filedata)
                data <- filedata[compobs,]
                if(nrow(data)>threshold){
                        results <- c(results,cor(data$nitrate, data$sulfate, use = "complete.obs"))
                }
        }
        print(results)
        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
}
# output examples are in the below URL
# https://d396qusza40orc.cloudfront.net/rprog%2Fdoc%2Fcorr-demo.html