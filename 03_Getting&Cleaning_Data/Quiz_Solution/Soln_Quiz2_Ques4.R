#Source: http://biostat.jhsph.edu/~jleek/contact.html

#Q: How many characters are in the 10th, 20th, 30th and 100th lines of HTML from the above page?

#Using the right packages
library(XML)

# Using the source in an object for better code readability
Source <- "http://biostat.jhsph.edu/~jleek/contact.html"

# Reading the source
html.doc <- url(Source)

# Parsing the html in an object for easy extraction
parseddoc <- readLines(html.doc)

# Creating a numm variable to store values of lenghts later on
output <- c()

#  10th, 20th, 30th & 100th Line set as a vector
linenum <- c(10,20,30,100)

# Looping to find the output
for (i in linenum){

        linechar <- parseddoc[i] # Reading nth line
        tot_char <- nchar(linechar) # finding the number of characters in that line
        output <- c(output,tot_char) # creating a vector with the length of each specified line
}
print(output)
#Make sure all conections (in this case using URL) are closed
closeAllConnections()