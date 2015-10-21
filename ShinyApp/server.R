# Things that need to be done:
#     - a way to convert independent variables to factor variables with text entry
#     - develop formula


library(shiny)

options(shiny.maxRequestSize = 9*1024^2)

shinyServer(function(input, output) {
        
    dataInput <- reactive({
            
            if(is.null(input$file)) return()
            inFile <- input$file
            data2 <- read.csv(inFile$datapath)
            assign('regress_data', data2, envir = .GlobalEnv)
        
    })
    output$choose_indVars <- renderUI({
            
            if(is.null(input$file)) return() 
            fields <- names(dataInput())
            checkboxGroupInput("indVars", "Choose Independent Variables",
                               choices = fields)
    })
    output$choose_depVars <- renderUI({
        
            if(is.null(input$file)) return() 
            fields <- names(dataInput())
            checkboxGroupInput("depVars", "Choose Dependent Variable",
                                choices = fields)
    })
    runRegression <- reactive({
            
    })
    output$contents <- renderTable({
            
            if(is.null(input$file)) return()
            df <- dataInput()
            print(head(df))
            if(is.null(input$indVars) || !(input$indVars) %in% names(df)) return()
            if(is.null(input$depVars) || !(input$depVars) %in% names(df)) return()
            final_cols <- c(input$indVars, input$depVars)
            df <- df[,final_cols, drop = FALSE]
            print(head(df))
            
    })
})