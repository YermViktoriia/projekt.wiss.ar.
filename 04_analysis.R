library(readr)
library(dplyr)

source("02_functions_main.R")

# Daten laden 

data <- read_csv("titanic_clean.csv", show_col_types = FALSE)
data <- data %>%
   mutate(
     Survived = factor(Survived),
     Sex = factor(Sex),
     Embarked = factor(Embarked),
     Anrede = factor(Anrede),
     Deck = factor(Deck),
     Seite = factor(Seite),
     Pclass = factor(Pclass, ordered = TRUE)
   )

# Analyse 
desc_numeric(data$Age)
desc_categorical(data$Sex)

biv_cat_cat(data$Sex, data$Survived)
biv_metric_dicho(data$Fare, data$Survived)

plot_multi_cat(data, "Sex", "Survived", "Pclass")
