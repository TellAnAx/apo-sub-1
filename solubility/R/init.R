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
# last modified: June 15th, 2022
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
                  ,colIndex = 1:14
)

excel_workbook <- loadWorkbook("/Users/anil/Library/CloudStorage/OneDrive-JihočeskáuniverzitavČeskýchBudějovicích/General/Aquaponics - Water Chemistry.xlsx")

data <- readWorksheet(excel_workbook,
                      sheet = "rawdata",
                      endCol = 14)
                               
# Rename columns
colnames(data) <- c(
  'name'
  ,'chemFormula'
  ,'cation'
  ,'anion'
  ,'chemCation'
  ,'chemAnion'
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