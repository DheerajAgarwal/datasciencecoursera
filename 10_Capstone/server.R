#############################################
          #SCRIPT NUMBER: 09
          #AUTHOR: Dheeraj Agarwal
          #PURPOSE: Server file for Shiny App
          #DEPENDENCIES: Script 08 & UI file
          #DATE: April 18, 2016
#############################################

source("08_shinyfunctions.R")

library(shiny)

shinyServer(
  function(input, output) {
    output$text1 <- renderText({
      paste(profanity_filter(get_word(input$input_str)))
    })
    output$text2 <- renderText({
      paste(profanity_filter(get_pred(input$input_str)))
    })
  }
)