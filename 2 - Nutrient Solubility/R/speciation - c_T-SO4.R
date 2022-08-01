#
#  TITLE: XXX
#
#  DESCRIPTION:
#
#
#
# written by: Anil Axel Tellbuescher
#
# date written:   July 6th, 2022
# last modified:  July 7th, 2022
#
#
#
###############################################################################



calc_SO4 <- function(c_tot, pH, form_S = c("SO4-S", "SO4"), unit = c("mg", "mol")){
  
  # Define constants
  Ka1 <- 1e3 # Rechentafeln für die chemische Analytik
  Ka2 <- 1.2e-2 # Rechentafeln für die chemische Analytik
    
  # Convert Species
  if(form_S == "SO4"){
      c_tot_conv <- c_tot * 0.33 # Conversion of [SO4] into [SO4-S]
    } else {
      c_tot_conv <- c_tot
    }
  
  # Convert mass into mol
  if(unit == "mg"){
    c_tot_conv <- c_tot_conv * 1e-3 / 32.06 # conversion into g/L / molar mass = mol/L
  } else {
    c_tot_conv <- c_tot_conv
  }
    
  # Equation according to Snoeyink and Jenkins (1980): "Water Chemistry" p.128
  SO4 <- c_tot_conv * (1 / (((10^(-pH))^2 / Ka1*Ka2 ) + ((10^(-pH) / Ka2) + 1)))
  
  return(SO4)
}