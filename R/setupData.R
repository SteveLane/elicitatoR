#' Setup a new database
#'
#' \code{setupData} Sets up a new database to store the expert elicitations in.
#'
#' @param dbName The name of the database to store the elicitations in.
#' @return No object is returned, the database is created. Note: the database is
#'     created in the data directory (which is created if it doesn't exist).

setupData <- function(dbName){
    if(!(dir.exists("data"))){
        dir.create("data")
    }
    if(!file.exists(paste0("data/", dbName, ".sqlite"))){
        myDB <- DBI::dbConnect(RSQLite::SQLite(),
                               paste0("data/", dbName, ".sqlite"))
        DBI::dbExecute(myDB,
                        "CREATE TABLE elicitations (round INTEGER, expert TEXT, best_guess DOUBLE, lower DOUBLE, upper DOUBLE, confidence DOUBLE, alpha DOUBLE, beta DOUBLE)")
        DBI::dbDisconnect(myDB)
    }
}
