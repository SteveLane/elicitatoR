library(magrittr)
source("dataFuns.R")

## Need this in the ui app as well?
fields <- c("round", "expert", "best_guess", "lower", "upper", "confidence")

shinyServer(function(input, output, session) {

    ## Enable input fields when database name is set
    observe({
        isDataSet <- !is.null(input[["dbName"]]) && input[["dbName"]] != ""
        shinyjs::enable("submitDBName")
    })
    
    ## Setup database on submit
    observeEvent(input$submitDBName, {
        ## saveData(formData())
        setupData(input[["dbName"]])
        shinyjs::disable("dbName")
        shinyjs::disable("submitDBName")
        ## sapply(fields, function(x) shinyjs::enable(x))
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
        data <- lapply(fields, function(x){
            dat <- data.frame(input[[x]])
            names(dat) <- x
            dat
        })
        as.data.frame(data)
    })
    
    ## When the Submit button is clicked, save the form data
    ## Not sure I need the save function above.
    observeEvent(input$submit, {
        fitPars <- fitOpt(formData())
        saveData(cbind.data.frame(formData(), fitPars), input[["dbName"]])
        ## Plot the last entered individual data.
        output$plotInd <- renderPlot({
            plot(function(p) dbeta(p, fitPars$alpha, fitPars$beta),
                 from = 0, to = 1, bty = "l")
        })
        shinyjs::reset("form")
    })

    ## Load data on submit for printing
    allData <- reactive({
        input[["submit"]]
        loadData(input[["dbName"]])
    })  
    
    ## Show the previous responses
    ## (update with current response when Submit is clicked)
    output$responses <- DT::renderDataTable({
        DT::datatable(
                allData(),
                rownames = FALSE,
                options = list(searching = FALSE, lengthChange = FALSE,
                               scrollX = TRUE)
            )
    })
        
})
