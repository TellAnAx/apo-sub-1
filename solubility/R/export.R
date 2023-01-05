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

# EXPORT DATA

###############################################################################

# SOLUBILITY DATA - LaTeX
#
# Create dataset with solubility data for export to LaTeX (csvsimple)
exportdata <- data %>%
  select(
    c(chemFormula, chemCation:chemAnion, solSalt_mol:solAnion_mg)
  ) %>%
  arrange(solCation_mg)

# Remove special characters to make the file readibe by csvsimple
colnames(exportdata) <- sub("_", "", colnames(exportdata))

# Replace "x" in chemical formulae by "*" to make it readible by mhchem
exportdata$chemFormula <- sub(" x ", " * ", exportdata$chemFormula)

# Add function wrapper for mhchem
exportdata$chemFormula <- paste("\\", "ce{", exportdata$chemFormula, "}", sep = "")

# Reduce number of digits
exportdata <- format(exportdata, digits=2, nsmall=2)



# Write dataset to .csv
write.csv(exportdata,
          file = "data/Solubility_calculated.csv",
          quote = FALSE
)


# Export for further processing in R
write.csv(exportdata,
          file = "data/solubilityCalculated.csv",
          quote = FALSE
)


###############################################################################

# Create dataset with solubility data for sharing with Hana Kocour Kroupova
exportdata <- data %>%
  select(
    c(chemFormula, MSalt:solAnion_mg)
  ) %>%
  arrange(solCation_mg)



# Write dataset to .xlsx
#write.xlsx(exportdata, file = "data/forSharing-Solubility_calculations.xlsx")




# Write results to initial .xlsx
createSheet(water_chemistry, "solubilityResults")
writeWorksheet(water_chemistry, exportdata, sheet = "solubilityResults")
saveWorkbook(water_chemistry)


###############################################################################



