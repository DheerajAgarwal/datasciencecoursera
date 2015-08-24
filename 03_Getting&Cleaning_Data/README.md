# Instructions on how to use the run_analysis.R script

Most steps are listed even in greater detail within the R script itself. Please feel free to read through the script for any questions that may not be answered here.

## run_analysis.R
### Running the script
Please copy the entire run_analysis.R script in the RStudio Source. Click on the source button and the script will auto execute.
It attempts to download the data and unzip it for processing. If you already have the data as per course instructions, then you will need to comment out 
STEP 2 before sourcing.

###Unerstanding the script
#### STEP 1
Read and store the working directory in an object. This will be used to reset the working directory once all the steps in the script are completed.

#### STEP 2
Assumption: The user does not have the data available in the working directory. If the data (dowloaded and unzipped) is available then this step is redundant.

	1. Download the zip file from the specified source and unzip it in the working directory.
	2. Set the working directory as the newly unzipped folder.

#### STEP 3
	1. Get the list of files from the test and the train folders
	2. Copy those to the new working directory so that the new working directory has all the files in one place
	
#### STEP 4
	1. Since some of the data can take time to read, provide user friendly messaging
	2. Read the following files	
		A. activity_labels.txt
		B. features.txt
		C. subject_test.txt
		D. subject_train.txt
		E. X_test.txt
		F. X_train.txt
		G. y_test.txt
		H. y_train.txt
	3. After reading the features.txt file, filter out the first column and retain only the descriptive activities
	4. Set the working directory back to original using the object created in STEP 1
	5. Remove all unncessary (temporary) variables at this point.
	
#### STEP 5
	1. Merge the data sets from test folder
	2. Merge the data sets from train folder
	3. Merge the data sets created above into one large data set called 'master_data' - this is the merged data set but is not tidy yet
	4. Add column names to master_data
	5. Once the names are set, cast the $Activity column as a factor. This is needed to replace it with descriptive names later on.
	6. Rename the levels of $Activity column with descriptive names as saved in STEP 4, sub step 3
	7. Remove all unncessary (temporary) variables at this point.
	
#### STEP 6
	1. Define the columns that will be extracted from master_data
	2. Filter the master_data into a new variable called master_ms where ms signifies mean and standard deviation (the filter criteria)

#### STEP 7
	1. Define the variables, that the master_ms data will be grouped by
	2. Define the columns for which mean will be calculated. This is achieved by taking the total number of columns in the data set and setting the caluclation for column number 3 onwards. This is because the first two columns are the ones used for aggregation / group by criteria.
	3. Group the data into result. This result can be directly used for any operation and is the final output. Howvever is unsorted.
	4. Sort the unsorted data by subjects.
	5. Remove all unncessary (temporary) variables at this point.
	6. Write the result into a txt file called Tidy_Data.txt. This file is saved in the working directory of the user.

#### STEP 8 (OPTIONAL)
	1. This step was ceated primarily to allow the user to follow what the script is doing and what the sample output will be like.
	2. It opens the sorted result using View() command in the source pane.
	3. It also displays the dimension fo teh final result as well as a quick summary.
		


