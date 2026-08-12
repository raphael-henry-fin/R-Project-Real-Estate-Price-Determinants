library(dplyr)
library(readxl)

# ETAPE 1 : FICHIER PRIX (DVF)
df_prix <- read.csv("dvf2022.csv", 
                    sep = ",",
                    dec = ".", 
                    header = TRUE, 
                    colClasses = c("INSEE_COM" = "character")) 

df_prix_clean <- df_prix %>%
  filter(!grepl("^97", INSEE_COM)) %>%
  select(code_commun = INSEE_COM,
         Prix_m2 = Prixm2Moyen)

# ETAPE 2 : FICHIER SOCIO-ECO (INSEE)
df_insee <- read_excel("base_cc_comparateur.xlsx", 
                       sheet = "COM", 
                       skip = 5)

df_insee_clean <- df_insee %>%
  mutate(CODGEO = as.character(CODGEO)) %>%
  select(code_commun = CODGEO, 
         Population = P22_POP,
         Revenu_Median = MED21,
         Superficie = SUPERF,
         Chomage = P22_CHOM1564,
         Pop_Active = P22_ACT1564) %>%
  mutate(
    Densite = Population / Superficie,
    Taux_Chomage = (Chomage / Pop_Active) * 100
  )

# ETAPE 3 : FICHIER GRILLE DENSITÉ
df_grille <- read_excel("grille_densite_7_niveaux_2023.xlsx", 
                        sheet = 1,
                        skip = 4)

df_grille_clean <- df_grille %>%
  mutate(CODGEO = as.character(CODGEO)) %>%
  select(code_commun = CODGEO, 
         Niveau_Densite = DENS) %>%
  mutate(
    Type_Zone = ifelse(Niveau_Densite <= 3, "Urbain", "Rural")
  )

# ETAPE 4 : FUSION FINALE
base_temp <- merge(df_prix_clean, df_insee_clean, by = "code_commun")
#Ajout de l'autre fichier
base_finale <- merge(base_temp, df_grille_clean, by = "code_commun")

cat("Nombre de communes finales :", nrow(base_finale))
head(base_finale)