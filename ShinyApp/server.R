# Things that need to be done:
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
    getFields <- reactive({
            if(is.null(input$file)) return() 
            fields <- names(dataInput())
    })
    output$choose_indVars <- renderUI({
            
            indFields <- getFields()
            checkboxGroupInput("indVars", "Choose Independent Variables",
                               choices = setdiff(indFields, input$depVars), inline = TRUE)
    })
    output$choose_depVars <- renderUI({
        
            depFields <- getFields()
            checkboxGroupInput("depVars", "Choose One Dependent Variable",
                                choices = depFields, inline = TRUE)
    })
    output$choose_factorVars <- renderUI({
            
            checkboxGroupInput("factorVars", "Which Independent variables are factor variables?",
                               choices = input$indVars, inline = TRUE)
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
    runRegression <- eventReactive(input$runButton, {
        
        ## convert variables to factor after button click
        
        
    })
})