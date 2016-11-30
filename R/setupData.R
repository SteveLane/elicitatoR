#' Setup a new database
#'
#' \code{setupData} Sets up a new database to store the expert elicitations in.
#'
#' @param dbName The name of the database to store the elicitations in.
#' @return No object is returned, the database is created.

setupData <- function(dbName){
    myDB <- DBI::dbConnect(RSQLite::SQLite(),
                           paste0("../data/", dbName, ".sqlite"))
    DBI::dbSendQuery(myDB,
                     "CREATE TABLE elicitations (round INTEGER, expert TEXT, lower DOUBLE, best_guess DOUBLE, upper DOUBLE, confidence DOUBLE)")
}
