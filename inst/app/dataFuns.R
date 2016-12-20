saveData <- function(data, dbName){
    ins <-
        "INSERT INTO elicitations (round, expert, best_guess, lower, upper, confidence, alpha, beta) VALUES (:round, :expert, :best_guess, :lower, :upper, :confidence, :alpha, :beta)"
    myDB <- DBI::dbConnect(RSQLite::SQLite(),
                           paste0("data/", dbName, ".sqlite"))
    DBI::dbGetQuery(myDB, ins, params = data)
    DBI::dbDisconnect(myDB)
}

loadData <- function(dbName){
    myDB <- DBI::dbConnect(RSQLite::SQLite(),
                           paste0("data/", dbName, ".sqlite"))
    data <- DBI::dbGetQuery(myDB, "SELECT * FROM elicitations")
    DBI::dbDisconnect(myDB)
    data
}
