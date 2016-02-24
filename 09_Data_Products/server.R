library(shiny)

# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(datasets); library(ggplot2)

# Define a server for the Shiny app
shinyServer(function(input, output) {
        
        # Fill in the spot we created for a plot
        output$mpgPlot <- reactivePlot(
                function() {
                        input$update
                # check for the input variable
                        mpgData <- data.frame(
                                                mpg = mtcars$mpg, 
                                                cyl = as.factor(mtcars$cyl), 
                                                TechParam = mtcars[[input$attrib1]], 
                                                CarAttrib = as.factor(mtcars[[input$attrib2]])
                                        )
                        p <- ggplot(mpgData, aes(TechParam, mpg)) + 
                                geom_point(shape = 3, aes(colour = CarAttrib),alpha = 0.9, size = 4) + 
                                labs(title = "Fuel Consumption for various Car Attributes", y = "Miles Per Gallon", x = input$attrib1) +
                                facet_grid(CarAttrib ~ cyl)
                        print(p)
                }
        )
        output$table <- renderTable({
                cols <- c("mpg", "cyl", input$attrib1, input$attrib2)
                head(mtcars[,cols], 5)
        })
})