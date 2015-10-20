library(readr)

options(shiny.maxRequestSize = 9*1024^2)

shinyServer(function(input, output) {
        output$contents <- renderTable({
                inFile <- input$file1
                if(is.null(inFile))
                        return(NULL)
                file <- read_csv(inFile$datapath, header = input$header,
                         sep = input$sep, quote = input$quote)
        })
})