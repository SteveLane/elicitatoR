library(shiny)

## Name the fields required here - there will have to be a better way though. I
## think the database should have an experts table and an elicitations table
## fields should probably be read from the created database, and a consistent
## identifier field used.

shinyUI(fluidPage(
    sidebarLayout(
        sidebarPanel(
            textInput("dbName", "Database name", ""),
            actionButton("submitDBName", "Submit"),
            div(id = "form",
                textInput("round", "Round", ""),
                textInput("expert", "Expert", ""),
                numericInput("best_guess", "Best guess", "", min = 0, max = 1),
                numericInput("lower", "Lower limit", "", min = 0, max = 1),
                numericInput("upper", "Upper limit", "", min = 0, max = 1),
                numericInput("confidence", "Confidence", "", min = 0, max = 1),
                actionButton("submit", "Submit")
                )),
        mainPanel(
            tabsetPanel(
                id = "mainTabs", type = "tabs",
                tabPanel(
                    title = "Elicited plot",
                    id = "elicitedPlot", value = "elicitedPlot", br(),
                    div(id = "indPlot",
                        plotOutput("plotInd"))
                ),
                tabPanel(
                    title = "Elicited responses",
                    id = "elicitedTab", value = "elicitedTab", br(),
                    div(id = "responsesTable",
                        DT::dataTableOutput("responses"))
                )
            )
        )
    ),
    shinyjs::useShinyjs()
))
