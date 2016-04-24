#############################################
          #SCRIPT NUMBER: 01
          #AUTHOR: Dheeraj Agarwal
          #PURPOSE: Load all necessary libraries
          #DEPENDENCIES: None
          #DATE: April 18, 2016
#############################################

require(doParallel) # memory efficient processing
require(dplyr) # user function creation for cleaning
require(stringr) # regex cleanup
require(tau) # pattern counting on text documents
require(caret) # to create data partition and prediction model
require(data.table) # to perform memory efficient table operations
require(NLP) # for natural language processing ;)
require(openNLP)


registerDoParallel(makeCluster(4))
