library(shiny)

options(shiny.maxRequestSize = 9*1024^2)

shinyServer(function(input, output) {
        
    dataInput <- reactive({
            if(is.null(input$file))
              return()
            inFile <- input$file
            data2 <- read.csv(inFile$datapath)
            assign('regress_data', data2, envir = .GlobalEnv)
        
    })
    runRegression <- reactive({
            
    })
    output$contents <- renderTable({
            myDF <- dataInput()
            print(myDF)
    })
})