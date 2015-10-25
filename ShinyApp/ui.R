library(shiny)
library(DT)

shinyUI(fluidPage(
        titlePanel("Regression Analysis"),
        sidebarPanel(
                tags$head(
                    tags$style(type="text/css", ".well { max-width: 200px; }")
                ),
                fileInput('file', 'Choose file to upload',
                          accept = c(
                                  'text/csv',
                                  'text/comma-seperated-values',
                                  'text/tab-seperated-values',
                                  'text/plan',
                                  '.csv',
                                  '.tsv'
                                  )
                ),
                tags$hr(),
                checkboxInput('header', 'Header', TRUE),
                radioButtons('sep', 'Seperator',
                             c(Comma=',',
                               Semicolon=';',
                               Tab='\t'),
                             ','),
                radioButtons('quote', 'Quote',
                             c(None='',
                               'Double Quote'='"',
                               'Single Quote'="'"),
                             'Double Quote'),
                
                conditionalPanel("output.fileUploaded", 
                    uiOutput("choose_depVars"),
                    uiOutput("choose_indVars"),
                    uiOutput("choose_factorVars"),
                    actionButton("runLinearButton", "Run Linear Regression"),
                    actionButton("runLogisticButton", "Run Logistic Regression")
            )
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Data Table",
                         br(),
                         dataTableOutput('contents')),
                tabPanel("Step-wise Linear Regression Results",
                         br(),
                         dataTableOutput("linearRegressionTab")),
                tabPanel("Logistic Regression Results",
                         br(),
                         dataTableOutput("logisticRegressionTab")),
                tabPanel("Plot",
                         h3("Linear Regression Plot"),
                         plotOutput("linearPlot"),
                         h3("Logistic Regression Plot"),
                         plotOutput("logisticPlot"))
            )
        )
))