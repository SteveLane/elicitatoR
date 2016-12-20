#' Beta matching for expert elicitations
#'
#' \code{betaMatch} This is the minimisation function for fitting a beta
#' distribution to expert elicited data using the IDEA protocol.
#'
#' @param pars Target of optimisation; not set by user.
#' @param elicited Data frame of elicited values.
#' @return No object is returned.

betaMatch <- function(pars, elicited){
    a <- exp(pars[1])
    b <- exp(pars[2])
    lp <- (1 - elicited[["confidence"]])/2
    up <- (1 - elicited[["confidence"]])/2 + elicited[["confidence"]]
    ll <- pbeta(elicited[["lower"]], a, b)
    ul <- pbeta(elicited[["upper"]], a, b)
    mode <- (a - 1) / (a + b - 2)
    (ll - lp)^2 + (ul - up)^2 + (mode - elicited[["best_guess"]])^2
}

fitOpt <- function(data){
    ps <- optim(runif(2, 0, 4), betaMatch, elicited = data,
                method = "L-BFGS-B", lower = 0)
    data.frame(alpha = exp(ps$par[1]), beta = exp(ps$par[2]))
}
