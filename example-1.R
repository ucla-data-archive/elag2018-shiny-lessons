#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Los Angeles Library Monthly Circulation Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        "sidebar panel",
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        "main panel",
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   circstats <- read_csv(file = "https://data.lacounty.gov/api/views/gf6j-sjun/rows.csv?accessType=DOWNLOAD")
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- circstats$Circulation
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white',
           xlab = "Monthly circulation count",
           main = "Histogram of individual library monthly circulation")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

