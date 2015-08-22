# Programming Assignment 3 - Part 3 of 4 of Hospital Quality

# OBJECTIVE - Find the name of the hospital that has the
 ##ranking specified and returns a character vector
  ###for a given state and outcome

#Example: rankhospital("MD", "heart failure", 5)
#Result of Example: the name of the hospital with the 5th lowest 30-day death rate
 ##for heart failure in Maryland

##NOTE: num argument can take values "best", "worst", or an integer indicating the ranking
 ##(smaller numbers are better)

rankhospital <- function(state, outcome, num = "best") {

        ## Read input data
        input <- read.csv("./Hospital_Qlty/outcome-of-care-measures.csv")

        ## Read outcome data
        validoutcomes <- c("heart attack","heart failure","pneumonia")

        ## if num > no of records return NA
        #if(num>nrow(input$State==state)){
        #        return(NA)
        #}

        ## changing the name of relevant columns for better readability and alignment w/ outcome
        colnames(input)[11] <- validoutcomes[1]
        colnames(input)[17] <- validoutcomes[2]
        colnames(input)[23] <- validoutcomes[3]
        name <- names(input)[2]

        ## Check that state and outcome are valid
        if(!is.element(state, input$State)) {
                stop("invalid state")
        }
        if(!is.element(outcome, validoutcomes)){
                stop("invalid outcome")
        }
        ## Return hospital name in the specified state an outcome
        statelist <- input[input$State==state,c(name,outcome)]

        ## sorting on outcome results by changing it to numeric
        variable <- as.character(statelist[, 2])
        variable <- suppressWarnings(as.numeric(variable))
        statelist["FactorCol"] <- NA
        statelist$FactorCol <- variable
        statelist <- statelist[order(statelist$FactorCol, statelist$Hospital.Name),]
        statelist <- na.omit(statelist)

        ## 30-day death rate for the hospital with the specified rank
        if(num=="best"){
                as.character(statelist$Hospital.Name[1])
        } else if (num=="worst"){
                as.character(statelist$Hospital.Name[nrow(statelist)])
        } else if(is.numeric(num)) {
                as.character(statelist$Hospital.Name[num])
        } else{
                return(NA)
        }
}

# Sample output
#> rankhospital("TX", "heart failure", 4)
##[1] "DETAR HOSPITAL NAVARRO"

#> rankhospital("MD", "heart attack", "worst")
##[1] "HARFORD MEMORIAL HOSPITAL"

#> rankhospital("MN", "heart attack", 5000)
##[1] NA