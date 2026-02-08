check_numeric <- function(x){
  if(!is.numeric(x)) stop("Variable ist nicht numerisch")
}

check_factor <- function(x){
  if(!is.factor(x)) stop("Variable ist kein Faktor")
}
