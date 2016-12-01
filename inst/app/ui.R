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
            numericInput("best_guess", "Best guess", ""),
            numericInput("lower", "Lower limit", ""),
            numericInput("upper", "Upper limit", ""),
            numericInput("confidence", "Confidence", ""),
            actionButton("submit", "Submit")
        ),
        mainPanel(
            DT::dataTableOutput("responses")
        )
    ),
    shinyjs::useShinyjs()
))
