#' Beta matching for expert elicitations
#'
#' \code{betaMatch} This is the minimisation function for fitting a beta
#' distribution to expert elicited data using the IDEA protocol.
#'
#' @param par Target of optimisation; not set by user.
#' @param elicited Data frame of elicited values.
#' @return No object is returned.

betaMatch <- function(par, elicited){
    b <- exp(par)
    a <- (elicited[["best_guess"]] * (2 - b) - 1) /
        (elicited[["best_guess"]] - 1)
    lp <- (1 - elicited[["confidence"]])/2
    up <- (1 - elicited[["confidence"]])/2 + elicited[["confidence"]]
    ll <- pbeta(elicited[["lower"]], a, b)
    ul <- pbeta(elicited[["upper"]], a, b)
    (ll - lp)^2 + (ul - up)^2
}

fitOpt <- function(data){
    ps <- optim(runif(1, 0, 4), betaMatch, elicited = data,
                method = "L-BFGS-B", lower = 0)
    b <- exp(ps$par)
    a <- (data[["best_guess"]] * (2 - b) - 1) /
        (data[["best_guess"]] - 1)
    data.frame(alpha = a, beta = b)
}
