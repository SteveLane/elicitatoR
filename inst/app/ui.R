library(shiny)

## Name the fields required here - there will have to be a better way though. I
## think the database should have an experts table and an elicitations table
## fields should probably be read from the created database, and a consistent
## identifier field used.

shinyUI(fluidPage(
    sidebarLayout(
        sidebarPanel(
            textInput("round", "Round", ""),
            textInput("expert", "Expert", ""),
            numericInput("best_guess", "Best guess", "", min = 0, max = 1),
            numericInput("lower", "Lower limit", "", min = 0, max = 1),
            numericInput("upper", "Upper limit", "", min = 0, max = 1),
            numericInput("confidence", "Confidence", "", min = 0, max = 1),
            actionButton("submit", "Submit")
        ),
        mainPanel(
            DT::dataTableOutput("responses")
        )
    ),
    shinyjs::useShinyjs()
))
