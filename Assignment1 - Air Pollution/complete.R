# Programming Assignment 1 - Part 2  of Air Pollution
complete <- function(directory, id = 1:332) {
        ## reading names of all files
        allfiles <- list.files(directory,full.names = TRUE)
        ##  declaring objects for ids and resultant vector
        a <- c()
        result <- c()
        # rul loop across specified files for complete cases
        for (i in id) {
                filedata <- read.csv(allfiles[i])
                totalcases <- complete.cases(filedata)
                nobs <- sum(totalcases)
                result <- c(result, nobs)
                a <- c(a,i)
        }
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
output <- c(a,result)
realoutput1 <- matrix(output,nrow = length(a),ncol = 2)
realoutput <- data.frame(realoutput1)
cnames <- c("id","nobs")
colnames(realoutput) <- cnames
print(realoutput)
}