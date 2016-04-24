Capstone Project: Data Science Coursera, Johns Hopkins & Swiftkey
========================================================
author: Dheeraj Agarwal
date: April 22nd 2016
autosize: true

Overview
========================================================

The Coursera & Johns Hopkins University's (JHU) Data Science Specialization's final course, a Capstone project was created in partnership with a leading tech company - SwiftKey. 

The objective of this project is to apply learnings from the entire specialization and build a predective model based on **Natural Language Processing**.

The data used in the model is part of a corpus [HC Corpora] (www.corpora.heliohost.org) which is a body of blogs, news and tweets in multiple languages.  

Model Development
========================================================

The model was based on a popular technique called [*N-Gram*] (https://en.wikipedia.org/wiki/N-gram). The model uses *20%* sampling of the provided corpus as a training set and is based on [**Maximum Likelihood**] (https://en.wikipedia.org/wiki/Maximum_likelihood). It is by design not to remove **stop words** due to their contextual application in natural language. This makes the model a little less accurate. 

If the interpolation fails at any instance, **a part of speech** tagging [POST](https://en.wikipedia.org/wiki/Part-of-speech_tagging) was done using the **NLP packages**.

The model also has a by default filter on profane words and cannot be turned off. The profanity list is available [here](https://badwordslist.googlecode.com/files/badwords.txt).   

Web App (Shiny)
========================================================

A Shiny app that implements the above logic is availabe [here](). The app is built using the ***NavBar*** widget. Tab *Predictor* has the app and the tab *About* has links to other supplementary information like code repo. Using the application is fairly simple. Just type a phrase without any special symbols and the app will give you a predicted word.

Below is a screenshot of a sample prediction. 

![alt text](capture.png)

More Details
========================================================

The code repository for my prediction model is [here](https://github.com/DheerajAgarwal/datasciencecoursera/tree/master/10_Capstone) and the shiny app [here](https://dheerajagarwal.shinyapps.io/DSS_Capstone_2016) .

You can also find more details on the individual files as well link to the interim milestone reports and exploratory analysis.



