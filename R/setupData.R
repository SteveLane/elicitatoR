setupData <- function(dbName){
    myDB <- DBI::dbConnect(RSQLite::SQLite(),
                           paste0("../data/", dbName, ".sqlite"))
    DBI::dbSendQuery(myDB,
                     "CREATE TABLE elicitations (round INTEGER, expert TEXT, lower DOUBLE, best_guess DOUBLE, upper DOUBLE, confidence DOUBLE)")
}
