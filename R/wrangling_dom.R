###----------------------------------------------------------------------------
###----------------------------------------------------------------------------
###----------------------------------------------------------------------------
#
# DOM - DISSOLVED ORGANIC MATTER
#


species %>% 
  
  rename(
    "component" = Component,
    "percentage_of_total_conc" = X..of.total.concentration,
    "species_name" = Species.name
  ) %>% 
  
  filter(
    grepl("DOM1", species_name) &
      species_name != "DOM1"
  ) %>% 
  
  mutate(
    species_name = as.factor(species_name)
  ) %>% 
  
  write_csv("results/dom.csv")

