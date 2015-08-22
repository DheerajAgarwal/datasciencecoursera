# Programming Assignment 3 - Part 2 of 4 of Hospital Quality
# OBJECTIVE - Find the best hospital(one with minimum mortality) for a given state and outcome


best <- function(state, outcome) {
        ## Read outcome data
        input <- read.csv("./Hospital_Qlty/outcome-of-care-measures.csv")

        ## Check that state and outcome are valid
        if(!is.element(state, input$State)) {
                stop("invalid state")
        }
        validoutcomes <- c("heart failure", "heart attack","pneumonia")
        if(!is.element(outcome, validoutcomes)){
                stop("invalid outcome")
        }
        if(outcome == "heart failure"){
                variable <- as.character(input$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
        }
        if(outcome == "heart attack"){
                variable <- as.character(input$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
        }
        if(outcome == "pneumonia"){
                variable <- as.character(input$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
        }
        ## Since character is saved as numeric, the below will suppress NA by coercion warning for "Not Available"
        variable <- suppressWarnings(as.numeric(variable))
        ## Adding the new column on which operations will be performed
        input["Factorcol"] <- NA
        ## copying the values in the new column
        input$Factorcol <- variable
        ## Sorting the input data on this new columns and the hospital name
        input <- input[order(input$Factorcol, input$Hospital.Name),]

        # filer for state agrument
        statefilter <- subset(input, State==state)

        ## Return hospital name in that state with lowest 30-day death rate
        ## Submit script expect it to be a character and hence returned as.character
        return(as.character(statefilter$Hospital.Name[1]))
}
# Sample output
#> source("best.R")
#> best("TX", "heart attack")
#[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
#> best("TX", "heart failure")
#[1] "FORT DUNCAN MEDICAL CENTER"
#> best("MD", "heart attack")
#[1] "JOHNS HOPKINS HOSPITAL, THE"
#> best("MD", "pneumonia")
#[1] "GREATER BALTIMORE MEDICAL CENTER"
#> best("BB", "heart attack")
#Error in best("BB", "heart attack") : invalid state
#> best("NY", "hert attack")
#Error in best("NY", "hert attack") : invalid outcome

