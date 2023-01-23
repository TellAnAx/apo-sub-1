 saturation %>% 
  
  rename(
    "logQK" = Sat..index
  ) %>% 
  
  mutate(
    cation = if_else(
      Col5 == "H+1" | Col5 == "H2O",
      if_else(
        Col7 == "H+1" | Col7 == "H2O",
        Col9,
        if_else(
          Col8 > Col6,
          if_else(
            Col9 == "H+1" | Col9 == "H2O",
            Col7,
            Col9            
          ),
          Col7
        ),
        Col7
        ), 
      Col5
      ),
    anion = if_else(
      grepl("-", Col7) != TRUE,
      if_else(
        grepl("-", Col9) != TRUE,
        Col11,
        Col9
      ),
      Col7
    ),
    anion = if_else(
      is.na(anion) == TRUE,
      "OH-",
      anion
    ),
    anion = if_else(
      anion == "H2O",
      "O-2",
      anion
    )
  ) %>% 
   
   
   write_csv(here::here("results", "logQK.csv")) %>% 
   
   group_by(cation) %>% 
   
   summarise(n())