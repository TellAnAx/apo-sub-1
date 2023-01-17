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
# date written:: July 6th, 2022
# last modified: July 6th, 2022
#
#
#
###############################################################################



calc_OH <- function(pH){
  
  
  OH <- 10^(-(14 - pH))
 
  return(OH) 
}