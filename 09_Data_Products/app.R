library(shiny)
library(datasets); data("mtcars")
library(ggplot2)

# Rely on the 'mtcars' dataset which should be preloaded, however loading it here as a fail safe.
param1 <- c(8,9,10,11)
param2 <- c(3,4,5,6,7)

# Define the overall UI
UI <- 
        # Use a fluid Bootstrap layout
        pageWithSidebar(    
                # Give the page a title
                headerPanel("Fuel consumption & Technical Parameters"),
                # Generate a row with a sidebar
                sidebarPanel(      
                        # Define the sidebar with one input
                        selectInput("attrib1", "Technical Parameter:", 
                                    choices=names(mtcars[param2])),
                        selectInput("attrib2", "Car Factor Attribute:", 
                                    choices=names(mtcars[param1])),
                        hr(),
                        helpText("Source: 1974 Motor Trend US magazine")
                ),
                
                # Create a spot for the barplot
                mainPanel(
                        plotOutput("mpgPlot"),
                        h4("Sample Data:"),
                        tableOutput("table")
                )
                
                
        )



# Define a server for the Shiny app
SERVER <- function(input, output) {
        
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
}

shinyApp(ui = UI, server = SERVER)