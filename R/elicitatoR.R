#' Run the elicitatoR
#'
#' \code{elicitatoR} Starts the elicitatoR shiny app.
#'
#' @return No objects are returned. Elicitations are stored in a database inside
#'     the data folder. Both the database and data folder will be created inside
#'     the working directory if they don't exist.
#' @examples
#' \dontrun{
#' elicitatoR()
#' }
#'
#' @export elicitatoR

elicitatoR <- function(){
    appDir <- system.file("shiny", "elicitator", package = "elicitatoR")
    if (appDir == "") {
        stop("Could not find app directory. Try re-installing `elicitatoR`.",
             call. = FALSE)
    }
    shiny::runApp(appDir, display.mode = "normal")
}
