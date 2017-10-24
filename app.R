#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#Naomi Breslin
#17232617
#26/10/17
library(shiny)
if (interactive()) {
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Patient Data"),
   sidebarLayout(
     sidebarPanel(
  #Adding side bar applications(inputs) to the app
       #1:CSV file input, 2:A select input (based on the column names in the csv file) 3:Radio buttons
          fileInput("file1", "Choose CSV File",
                 accept = c(
                   "text/csv",
                   "text/comma-separated-values,text/plain",
                   ".csv")
       ),
       tags$hr(),
       checkboxInput("header", "Header", TRUE)
     ,
  
  selectInput("var", "Select a variable:",
              c("Age" = "age",
                "Height" = "height",
                "Weight" = "weight",
                "Bmi" = "bmi")),
  radioButtons("cols", "Colours", 
               c("Red",
                 "Blue",
                 "Green",
                 "Pink")))

,
mainPanel(
        tableOutput("data"),
        plotOutput("variables")
        )))
  

server <- function(input, output){
  #Rendering a table from the csv file data
  output$data <-renderTable({ 
    infile <-input$file1
    if (is.null(infile))
      return(NULL)
    c <-read.csv(infile$datapath, header = input$header)
    
  })
  #Using the select input and radio button inputs for boxplots
  output$variables <-renderPlot({
    (req(input$file1))
    infile <- input$file1
    data <-read.csv(infile$datapath, header=input$header)
    var <-input$var
    col <-input$cols
    boxplot(data[,var], col=col, main=paste("Selected Variable", var))
  })}
    
 
  


# Run the application 
shinyApp(ui = ui, server = server)

}