 saturation %>% 
  
  rename(
    "logQK" = Sat..index
  ) %>% 
  
  mutate(
    cation = if_else(Col5 == "H+1", if_else(Col8 > Col6 & Col9 != "H2O", Col9, Col7), Col5),
    anion = if_else(is.na(Col11) == TRUE & is.na(Col9) == TRUE, Col7, Col11),
    anion = if_else(is.na(anion) == TRUE & is.na(Col11) == TRUE, if_else(Col7 %in% c("H+1", "Mg+2", "Ca+2", "Fe+3"), Col9, Col7), anion),
    anion = if_else(anion == "H2O", if_else(Col9 %in% c("H+1", "Mg+2", "Ca+2", "Fe+3"), anion, Col9), anion)
  ) %>% 
   
   write_csv(here::here("results", "logQK.csv"))