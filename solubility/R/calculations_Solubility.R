#
# TITLE:
#
#
# DESCRIPTION:
#
#
#
#
# written by: Anil Axel Tellbuescher
#
# date written:: May 30th, 2022
# last modified: May 30th, 2022
#
#
#
###############################################################################
# LOAD PACKAGES



library(xlsx) # Excel - Reading and writing
library(XLConnect)
library(dplyr)
library(ggplot2)
library(tidyr)

options(digits = 2)



###############################################################################
# DATA IMPORT



# Read data
data <- read.xlsx(file = "/Users/anil/Library/CloudStorage/OneDrive-JihočeskáuniverzitavČeskýchBudějovicích/General/Aquaponics - Water Chemistry.xlsx"
                  ,sheetName = "rawdata"
                  ,colIndex = 1:12
                  )

# Rename columns
colnames(data) <- c(
  'name'
  ,'chemFormula'
  ,'cation'
  ,'anion'
  ,'coeffCation' # n(Cation) per n(Salt)
  ,'coeffAnion' # n(Anion) per n(Salt)
  ,'MSalt' # Molar mass of Salt in g/mol
  ,'MCation' # Molar mass of Cation in g/mol
  ,'MAnion' # Molar mass of Anion in g/mol
  ,'massPercent' # Mass percentage at 25 degrees Celsius (Handbook of Chemistry and Physics, 88th ed.)
  ,'Ks0' # Solubility product constant at 25 degrees Celsius (Handbook of Chemistry and Physics, 88th ed.)
  ,'densH2O' # Density of water at 25 degrees Celsius in kg/L
#  ,'solPrecalc'
#  ,'solSalt' # Solubility of salts that are well-soluble in g/L
)

rownames(data) <- data$name





###############################################################################
# TRANSFORMATIONS AND CALCULATIONS

# 1. Calculation of solubility of salts from Ks0; accounts for poorly soluble salts
data <- data %>%
  mutate(
    # Molar solubility of the Salt
    solSalt_mol = (Ks0 / (coeffCation^coeffCation * coeffAnion^coeffAnion))^(1/(coeffCation + coeffAnion)),
    # Mass solubility of the Salt
    solSalt_mg = solSalt_mol * MSalt * 1e3
  )

# 2. Filling up missing values by solubilities derived from Handbook of Chemistry and Physics, 88th ed. after conversion
#    into mg/L as unit
for(i in 1:nrow(data)){
  if(is.na(data$Ks0[i]) == TRUE){
    data$solSalt_mg[i] <- ((data$massPercent[i] * 1e-2) * data$densH2O[i]) / (1 - (data$massPercent[i]*1e-2)) * 1e6
    
    data$solSalt_mg2[i] <- data$solSalt[i] * 1e3
    
    data$solSalt_mol[i] <- data$solSalt_mg[i]*1e-3 / data$MSalt[i]
  }
}




plotdata <- data %>%
  mutate(
#
# TRANSFORMATIONS
#
cation = as.factor(cation),
anion = as.factor(anion),

    # Molar solubility of the Cation
    solCation_mol = solSalt_mol * coeffCation,
    # Mass solbility of the Cation
    solCation_mg = solCation_mol * MCation * 1e3,
    
    # Molar solubility of the Anion
    solAnion_mol = solSalt_mol * coeffAnion,
    # Mass solubility of the Anion
    solAnion_mg = solAnion_mol * MAnion * 1e3
  ) %>%
  
  select(
    c("chemFormula", "cation", "anion", "coeffCation", "coeffAnion", "MSalt", "MCation", "MAnion", "Ks0", "solSalt_mol", "solCation_mol", "solAnion_mol", "solSalt_mg", "solCation_mg", "solAnion_mg")
  ) %>%
  drop_na(solSalt_mol)
  


###############################################################################
# CREATE PLOTS


# Plots - Cations
plotdata %>%
  filter(anion != "Sulfid") %>%
  ggplot(aes(x = cation, y = solCation_mg, color = anion)) + 
  geom_point() + 
  scale_y_continuous(trans='log10') +
  facet_wrap(facets = vars(cation), scales = "free")

plotdata %>%
  filter(anion != "Sulfid") %>%
  ggplot(aes(x = cation, y = solCation_mg)) + 
  geom_boxplot() + 
  scale_y_continuous(trans='log10')



# Plots - Anions
plotdata %>%
  filter(anion != "Sulfid") %>%
  ggplot(aes(x = anion, y = solCation_mg, color = cation)) + 
  geom_point() + 
  scale_y_continuous(trans='log10') +
  facet_wrap(facets = vars(anion), scales = "free")

plotdata %>%
  filter(anion != "Sulfid") %>%
  ggplot(aes(x = anion, y = solCation_mg)) + 
  geom_boxplot() + 
  scale_y_continuous(trans='log10')





###############################################################################
