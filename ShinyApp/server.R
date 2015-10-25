# Things that need to be done:
#     - develop formula


library(shiny)
library(leaps)
library(DT)

options(shiny.maxRequestSize = 9*1024^2)

shinyServer(function(input, output) {
        
    dataInput <- reactive({
            
            if(is.null(input$file)) return()
            inFile <- input$file
            data2 <- read.csv(inFile$datapath)
            assign('regress_data', data2, envir = .GlobalEnv)
        
    })
    output$fileUploaded <- reactive({
        return(!is.null(dataInput()))
    })
    outputOptions(output, 'fileUploaded', suspendWhenHidden=FALSE)
    getFields <- reactive({
            if(is.null(input$file)) return() 
            fields <- sort(names(dataInput()))
    })
    output$choose_indVars <- renderUI({
            
            indFields <- getFields()
            checkboxGroupInput("indVars", "Choose Independent Variables",
                               choices = setdiff(indFields, input$depVars), inline = TRUE)
    })
    output$choose_depVars <- renderUI({
        
            depFields <- getFields()
            selectInput("depVars", "Choose One Dependent Variable",
                                choices = depFields)
    })
    output$choose_factorVars <- renderUI({
            
            if(is.null(input$indVars)) return()
            selectInput("factorVars", "Which Independent variables are factor variables?",
                               choices = input$indVars, multiple = TRUE)
    })
    output$contents <- renderDataTable({
            
            if(is.null(input$file)) return()
            df <- dataInput()
            print(df)
            if(is.null(input$indVars) || !(input$indVars) %in% names(df)) return()
            if(is.null(input$depVars) || !(input$depVars) %in% names(df)) return()
            final_cols <- c(input$indVars, input$depVars)
            df <- df[,final_cols, drop = FALSE]
            print(df)
            
    })
    getDataForRegression <- reactive({
            
            datas <- dataInput()
            factors <- input$factorVars
            for (i in names(datas)) {
                    if (i %in% factors) {
                            datas[,i] <- as.factor(datas[,i])
                    } 
            }
            return(datas)
            
    })
    runLinearRegression <- eventReactive(input$runLinearButton, {
        
            ## convert variables to factor after button click
            datas <- getDataForRegression()
            lm_multi <- lm(print(as.formula(
                    paste(input$depVars," ~ ", 
                          paste(input$indVars, collapse="+")))), 
                    data=datas)
            step(lm_multi, direction="both")
            
    })
    output$linearRegressionTab <- renderDataTable({
            
            if(!is.null(input$indVars) || !is.null(input$depVars)) {
                    summary(runLinearRegression())$coefficients
            } else {
                    print(data.frame(Warning="Please select model parameters."))
            }
    })
    runLogisticRegression <- eventReactive(input$runLogisticButton, {
            
            datas <- getDataForRegression()
            lm_multi <- glm(print(as.formula(
                    paste(input$depVars," ~ ", 
                          paste(input$indVars, collapse="+")))), 
                    data=datas, 
                    family=binomial(link='logit'))
            step(lm_multi, direction="both")
            
    })
    output$logisticRegressionTab <- renderDataTable({
            
            if(!is.null(input$indVars) || !is.null(input$depVars)) {
                    summary(runLogisticRegression())$coefficients
            } else {
                    print(data.frame(Warning="Please select model parameters."))
            }
    })
    output$linearPlot <- renderPlot({
            
            model <- runLinearRegression()
            par(mfrow = c(2, 2))
            plot(model)
    })
    output$logisticPlot <- renderPlot({
        
            model <- runLogisticRegression()
            par(mfrow = c(2, 2))
            plot(model)
    })
})