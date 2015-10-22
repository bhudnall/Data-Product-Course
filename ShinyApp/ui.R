shinyUI(fluidPage(
        titlePanel("Upload File for Analysis"),
        sidebarPanel(
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
                
                uiOutput("choose_depVars"),
                uiOutput("choose_indVars"),
                uiOutput("choose_factorVars"),
                actionButton("runLinearButton", "Run Linear Regression"),
                actionButton("runLogisticButton", "Run Logistic Regression")
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Data Table", tableOutput('contents')),
                tabPanel("Step-wise Linear Regression Results", tableOutput("linearRegressionTab")),
                tabPanel("Logistic Regression Results", tableOutput("logisticRegressionTab")),
                tabPanel("Plot")
            )
        )
))