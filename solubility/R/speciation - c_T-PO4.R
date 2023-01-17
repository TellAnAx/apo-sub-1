#
# TITLE:        Conversion c_t -> PO4^3-
#
#
# DESCRIPTION:
#
#
#
#
# written by: Anil Axel Tellbuescher
#
# date written:: July 2nd, 2022
# last modified: July 7th, 2022
#
#
#
###############################################################################



calc_PO4 <- function(c_tot, pH, form_P = c("po4-p", "po4"), unit = c("mg", "mol")){
  
  # Define constants
  Ka1 <- 7.52e-3
  Ka2 <- 6.23e-8
  Ka3 <- 3.5e-13
  
  # Convert Species
  if(form_P == "po4"){
    c_tot_conv <- c_tot * 0.33 # Conversion of [PO4] into [PO4-P]
  } else {
    c_tot_conv <- c_tot
  }

  # Convert mass into mol
  if(unit == "mg"){
    c_tot_conv <- c_tot_conv * 1e-3 / 30.974  # conversion into g/L / molar mass = mol/L
  } else {
    c_tot_conv <- c_tot_conv
  }
  

  # Equation according to Snoeyink and Jenkins (1980): "Water Chemistry" p.131
  PO4 <- c_tot_conv * (1 / (((10^(-pH))^3/Ka1*Ka2*Ka3) + ((10^(-pH))^2/Ka2*Ka3) + (10^(-pH)/Ka3) + 1))
  
  return(PO4)
}