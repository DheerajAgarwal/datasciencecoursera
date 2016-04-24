# Codebook - Capstone Word Predictor
This codebook lists all the R scripts and provides a brief decsription of its functionlity. It also recommends the order in which the scripts must be executed in order to reproduce the results.

## Main Code Files  
| **File Name**  | **Decsription** |
| ------------- | ------------- |
| 01_libraries.R  | List of libraries used as part of the project  |
| 02_download.R | Getting the data from over the web |
| 03_readdata.R | Reading downloaded data and also profanity words for later filtering|
| 04_cleaner.R| Creating a common function for regex cleaning|
| 05_tidytraindata.R| Creating training data set|
| 06_ngrams.R| Creating N-Grams (Uni, Bi, Tri)|
| 07_freqtables.R| Frequency table for word combinations and their appearnance |
| 08_shinyfunctions.R| Creating functions to be used within the server file|
| server.R| Creating the server file for Shiny App|
| ui.R| Creating a UI to sit on top of the server|

## Supplemental Code Files  
| **File Name**  | **Decsription** |
| ------------- | ------------- |
| Capstone.Rpres  | Final Presentation  |
| explo_analysis1.R | Initial exploratory analysis |
| explo_analysis2.R | Exploratory analysis on the sampled corpus |

## Initial Analysis & Modeling Approach
The final model surprisingly turned out to be very different from my initial approach, primarily because of system limitations.
The initial analysis was performed using **tm** and **quanteda**, however due to excessive amount taken to train the model even after completing the exploratory analysis, the packages were abondoned and an enirely new approach to solve using **NLP** was adopted. Given the change in approach, the code files may not lead the reproducible exploratory analysis.

The model using maximum likelihood estimation, retains the stop words and filters any profanity while relying on the populat N-Gram technique.
It also uses the smoothing process [Jelinek - Mercer] (http://nlp.stanford.edu/~wcmac/papers/20050421-smoothing-tutorial.pdf) for interpolation on the 20% sample of the corpora.


## R-Presentation
The R Presentation using *rpres* is available [here](http://rpubs.com/DheerajAgarwal/Capstone_Prediction)
