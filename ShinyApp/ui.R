shinyUI(fluidPage(
        titlePanel("Upload File for Analysis"),
        sidebarPanel(
                fileInput('file1', 'Choose file to upload',
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
                tags$hr()
        )
))