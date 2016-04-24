#############################################
          #SCRIPT NUMBER: 09
          #AUTHOR: Dheeraj Agarwal
          #PURPOSE: Server file for Shiny App
          #DEPENDENCIES: Script 08 & server file
          #DATE: April 18, 2016
#############################################


library(markdown)
library(shiny)

shinyUI(
  navbarPage("Coursera DSS Capstone!",
    tabPanel("Predictor",
      sidebarLayout(
        sidebarPanel(
          h4("This application tries to predict the next word."),
          h4("Just type a phrase, (without special characters) in the box below."),
          br(),
          textInput("input_str", label = "Enter some text without punctuation:", value = " ")
        ),
        mainPanel(
          h4("Entered Phrase - with suggested completion of the last word", style = "color:green;"),
          verbatimTextOutput("text1"),
          h4("Next Word Prediction:", style = "color:red"),
          verbatimTextOutput("text2")
        )
      )
    ),
    tabPanel ("About",
      fluidRow(
        column(12,
          h3("Coursera Data Science Capstone!"),
          h5("This simple (and sometimes unreliable) text prediction application was created as a capstone project in partnership with swiftkey as part of the Coursera & Johns Hopkins University's specialization in Data Science"),
          h4("Purpose:"),
          h5("The purpose of this project is to mine through millions of lines of text sources from certain blogs, news articles and twitter feed and come up with a word prediction logic."),
          h5("This prediction model is available on the Predictor tab."),
          h4("Additional Details:"),
          a(href="https://github.com/DheerajAgarwal/datasciencecoursera/tree/master/10_Capstone", "Github Repo"),
        br(),
        a(href="http://www.rpubs.com/DheerajAgarwal/CapstoneMilestone", "Interim Report"),
        br(),
        a(href="http://commons.wikimedia.org/wiki/User:Sfoskett", "R-Presentation")
        )
      )
    )
  )
)
