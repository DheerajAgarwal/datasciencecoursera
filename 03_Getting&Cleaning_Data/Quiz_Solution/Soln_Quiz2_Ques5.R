#Source: https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

# Q: Read this data set into R and report the sum of the numbers in the fourth of the nine columns? Hint: Fixed Width File

# Sample first few lines from the Source for easy recon
##Weekly SST data starts week centered on 3Jan1990

##Nino1+2      Nino3        Nino34        Nino4
##Week          SST SSTA     SST SSTA     SST SSTA     SST SSTA
##03JAN1990     23.4-0.4     25.1-0.3     26.6 0.0     28.6 0.3
##10JAN1990     23.4-0.8     25.2-0.3     26.6 0.1     28.6 0.3


#NOTE: Reading carefully, it tells that this is not a very clean data
# It has multiple columns names as classifications.
# for readability, the code ignores the column names - skip(4)--rows

# Width should include white spaces. So counting for each columns. Use Notepad++. Also note that the first columns has 2 spaces before it starts
input <- read.fwf(file=url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"), skip=4, widths = c(15,4,9,4,9,4,9,4,4))

#get the sum of the 4th Column
print(sum(input[,4]))
