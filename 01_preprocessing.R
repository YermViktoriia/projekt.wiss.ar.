

# ============================
# Titanic preprocessing script
# ============================
install.packages(c("dplyr","stringr","readr"))  
library(dplyr)
library(stringr)
library(readr)

# Daten einlesen
titanic <- read_csv("titanic.csv")

# Funktion: Anrede extrahieren
extract_title <- function(name){
  title <- str_extract(name, ",\\s*([^\\.]+)\\.")
  title <- str_replace_all(title, ",|\\.", "")
  title <- str_trim(title)
  
  title <- case_when(
    title %in% c("Ms","Miss","Mlle") ~ "Miss",
    title %in% c("Mme","Mrs") ~ "Mrs",
    TRUE ~ title
  )
  
  return(title)
}

# Anrede Variable
titanic <- titanic %>%
  mutate(Anrede = sapply(Name, extract_title))

# Faktoren umwandeln
titanic <- titanic %>%
  mutate(
    Survived = factor(Survived),
    Sex = factor(Sex),
    Embarked = factor(Embarked),
    Pclass = factor(Pclass, ordered = TRUE)
  )

# Alter imputieren (Median nach Anrede)
titanic <- titanic %>%
  group_by(Anrede) %>%
  mutate(
    Age = ifelse(is.na(Age),
                 median(Age, na.rm = TRUE),
                 Age)
  ) %>%
  ungroup()

# Cabin Informationen extrahieren
titanic <- titanic %>%
  mutate(
    Cabin = na_if(Cabin, ""),
    Deck = str_extract(Cabin, "^[A-Za-z]"),
    CabinNum = as.numeric(str_extract(Cabin, "\\d+")),
    Seite = case_when(
      is.na(CabinNum) ~ NA_character_,
      CabinNum %% 2 == 1 ~ "Steuerbord",
      TRUE ~ "Backbord"
    )
  )

# Variablen entfernen
titanic_clean <- titanic %>%
  select(-PassengerId, -Name, -Ticket, -Cabin, -CabinNum)

# Datensatz speichern
write_csv(titanic_clean, "data/titanic_clean.csv")

print("Preprocessing erfolgreich abgeschlossen.")
print (titanic_clean)
