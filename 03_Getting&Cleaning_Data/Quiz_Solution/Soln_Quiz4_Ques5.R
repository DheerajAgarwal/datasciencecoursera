# This is the complete solution for Quiz 4 of Getting & Cleaning Data Course at Coursera. The solution is for Questions 5.

# NOTE: Install 'quantmod' package to source the data.

#------------------------------------------------------------
# SECTION A - Sourcing the data

#Use the following code to download data on Amazon's stock price and get the times the data was sampled.
library(quantmod)
suppressMessages(library(quantmod))

# the code (provided by Coursera) generates a lot of warnings and messages and hencethey are suppressed for clean run.
options("getSymbols.warning4.0"=FALSE)
amzn = suppressWarnings(getSymbols("AMZN",auto.assign=FALSE))
sampleTimes = index(amzn)

#------------------------------------------------------------
# SECTION B - Quiz


        #********************************

#Ques5: How many values were collected in 2012? How many values were collected on Mondays in 2012?

# Part1: Number of entries for 2012
valYears <- format(sampleTimes,"%Y")
isYear2012 <- valYears=="2012"
total2012vals <- sum(isYear2012)

#Part2: Number of Mondays in 2012
valDay <- format(sampleTimes, "%d")
isMonday <- valDay=="Monday"

#removing temporary variables
rm(valYears); rm(valDay)

resultQ5 <- table(isYear2012, isMonday)

print("The answer to quesrtion 5 is:"); print(resultQ5[2,2])

