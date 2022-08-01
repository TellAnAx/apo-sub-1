#
# TITLE:
#
#
# DESCRIPTION:
#               Default values:
#                               - Partial pressure of CO2 in the atmosphere
#                                 p(CO2) = 0.054 atm
#                               - Henry constant of CO2 at 25 degree C
#                                 Kh = 3.4e-2 mol/(L atm)
#                               - Temperature
#                                 T = q25 degree Celsius
#
#
#
# written by: Anil Axel Tellbuescher
#
# date written:: July 6th, 2022
# last modified: July 6th, 2022
#
#
#
###############################################################################

# ToDo
# - Consider different temperatures
# - define output (which species to return)


calc_CO3 <- function(pH, pCO2 = 0.054, Kh = 3.4e-2, logK1 = 6.35, logK2 = 10.33, T = 25){
  
  H2CO3 <- Kh * pCO2
  HCO3 <- 10^(-logK1) * H2CO3 / 10^(-pH)
  CO3 <- 10^(-logK2) * HCO3 / 10^(-pH)
  
  #species_carbonate <- c(H2CO3, HCO3, CO3)
  #names(species_carbonate) <- c("H2CO3", "HCO3", "CO3")
  
  #return(species_carbonate)
  return(CO3)
}