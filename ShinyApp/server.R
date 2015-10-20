options(shiny.maxRequestSize = 9*1024^2)

shinyServer(function(input, output) {
#         output$contents <- renderTable({
#                 inFile <- input$file1
#                 if(is.null(inFile))
#                         return(NULL)
#                 file <- read.csv(inFile$datapath, header = input$header,
#                          sep = input$sep, quote = input$quote)
#         })
    output$contents <- renderText({
        if(is.null(input$file1))
            return()
        inFile <- input$file1
        data2 <- read.csv(inFile$datapath)
        assign('data', data2, envir = .GlobalEnv)
        print(summary(data))
    })
})