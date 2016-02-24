library(shiny)

# Rely on the 'mtcars' dataset which should be preloaded, however loading it here as a fail safe.
library(datasets); data("mtcars")
param1 <- c(8,9,10,11)
param2 <- c(3,4,5,6,7)

# Define the overall UI
shinyUI(
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
)
