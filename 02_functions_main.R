library(dplyr)
library(ggplot2)

source("03_functions_helpers.R")

desc_numeric <- function(x){
  check_numeric(x)
  summary(x)
}

desc_categorical <- function(x){
  check_factor(x)
  table(x)
}

biv_cat_cat <- function(x,y){
  check_factor(x)
  check_factor(y)
  table(x,y)
}

biv_metric_dicho <- function(metric, dicho){
  check_numeric(metric)
  check_factor(dicho)
  tapply(metric, dicho, summary)
}

plot_multi_cat <- function(data, var1, var2, var3){
  ggplot(data, aes(x=.data[[var1]], fill=.data[[var2]])) +
    geom_bar() +
    facet_wrap(~ .data[[var3]])
}
