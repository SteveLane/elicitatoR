library(magrittr)
source("dataFuns.R")

## Need this in the ui app as well?
fields <- c("round", "expert", "best_guess", "lower", "upper", "confidence")

shinyServer(function(input, output, session) {

    ## Enable input fields when database name is set
    observe({
        isDataSet <- !is.null(input[["dbName"]]) && input[["dbName"]] != ""
        sapply(fields, function(x) shinyjs::toggleState(x, isDataSet))
        shinyjs::enable("submitDBName")
    })
    
    ## Setup database on submit
    observeEvent(input$submitDBName, {
        saveData(formData())
        shinyjs::disable("dbName")
        shinyjs::disable("submitDBName")
    })
    
    ## Enable the Submit button when all fields are filled out
    observe({
        fields_filled <-
            fields %>%
            sapply(function(x) !is.null(input[[x]]) && input[[x]] != "") %>%
            all
        shinyjs::toggleState("submit", fields_filled)
    })
    
    ## Whenever a field is filled, aggregate all form data
    formData <- reactive({
        data <- sapply(fields, function(x){input[[x]]})
        data
    })
    
    ## When the Submit button is clicked, save the form data
    ## Not sure I need the save function above.
    observeEvent(input$submit, {
        saveData(formData())
    })
    
    ## Show the previous responses
    ## (update with current response when Submit is clicked)
    output$responses <- DT::renderDataTable({
        input$submit
        loadData()
    })
})
