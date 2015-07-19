# Programming Assignment 3 - Part 4 of 4 of Hospital Quality

# OBJECTIVE - returns a 2-column data frame containing
 ##the hospital in each state that has the ranking specified in num.
  ###for a given outcome & num

#Example: rankall("heart attack", "best")
#Result of Example: A data frame containing the names of the hospitals that are
 ##the best in their respective states for 30-day heart attack death rates.
  ###The function should return a value for every state (some may be NA).

##NOTE 1: The first column in the data frame is named 'hospital' & and the second column is named 'state'

##Note 2: This function should notcall rankhospital function.

##NOTE 3: num argument can take values "best", "worst", or an integer indicating the ranking
 ##(smaller numbers are better)

rankall <- function(outcome, num = "best") {

        ## Read input data
        input <- read.csv("./Hospital_Qlty/outcome-of-care-measures.csv")

        ## Read outcome data
        validoutcomes <- c("heart attack","heart failure","pneumonia")
        updatedcols <- c("hospital", "state")
        ranks <- c("best","worst")

        ## changing the name of relevant columns for better readability and alignment w/ the objective

        colnames(input)[2] <- updatedcols[1]
        colnames(input)[7] <- updatedcols[2]
        colnames(input)[11] <- validoutcomes[1]
        colnames(input)[17] <- validoutcomes[2]
        colnames(input)[23] <- validoutcomes[3]

        ## Check that outcome is valid
        if(!is.element(outcome, validoutcomes)){
                stop("invalid outcome")
        }
        ## Check if num is invalid
        if(!is.numeric(num)){
                if(!any(ranks == num)) stop("invalid rank")
        }
        ## creating a data-frame for outcome argument
        outcomelist <- input[,c(updatedcols[1], updatedcols[2], outcome)]

        ## converting factor class for outcome to numeric and others to character
        outcomelist[] <- lapply(outcomelist, as.character)
        outcomelist[,3] <- suppressWarnings(as.numeric(outcomelist[,3]))

        ##filter records where outcome is NA
        outcomelist <- outcomelist[!is.na(outcomelist[outcome]),]

        ## Order first by state, then by outcome and finally by hospital name
        outcomelist <- outcomelist[order(outcomelist[updatedcols[2]], outcomelist[outcome],outcomelist[updatedcols[1]]),]

        ##Splitting data fro each state
        segg <- split(outcomelist, outcomelist[2])

        ##Assigning rank (statding in the table) within each state
        if (num == "best") {
                standing <- lapply(segg, function(i){i[1,]})
        } else if (num == "worst") {
                standing <- lapply(segg, function(i){i[nrow(i),]})
        } else {
                standing <- lapply(segg, function(i){i[num,]})
        }

        ##unsplitting the data
        tempoutput <-as.data.frame(do.call(rbind,standing))

        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        output <- tempoutput[,1:2]
        return(output)
}

# Sample output

#> head(rankall("heart attack", 20), 10)
#hospital state
#AK <NA> AK
#AL D W MCMILLAN MEMORIAL HOSPITAL AL
#AR ARKANSAS METHODIST MEDICAL CENTER AR
#AZ JOHN C LINCOLN DEER VALLEY HOSPITAL AZ
#CA SHERMAN OAKS HOSPITAL CA
#CO SKY RIDGE MEDICAL CENTER CO
#CT MIDSTATE MEDICAL CENTER CT
#DC <NA> DC
#DE <NA> DE
#FL SOUTH FLORIDA BAPTIST HOSPITAL FL

#> tail(rankall("pneumonia", "worst"), 3)
#hospital state
#WI MAYO CLINIC HEALTH SYSTEM - NORTHLAND, INC WI
#WV PLATEAU MEDICAL CENTER WV
#WY NORTH BIG HORN HOSPITAL DISTRICT WY

#> tail(rankall("heart failure"), 10)
#hospital state
#TN WELLMONT HAWKINS COUNTY MEMORIAL HOSPITAL TN
#TX FORT DUNCAN MEDICAL CENTER TX
#UT VA SALT LAKE CITY HEALTHCARE - GEORGE E. WAHLEN VA MEDICAL CENTER UT
#VA SENTARA POTOMAC HOSPITAL VA
#VI GOV JUAN F LUIS HOSPITAL & MEDICAL CTR VI
#VT SPRINGFIELD HOSPITAL VT
#WA HARBORVIEW MEDICAL CENTER WA
#WI AURORA ST LUKES MEDICAL CENTER WI