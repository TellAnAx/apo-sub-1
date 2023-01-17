 mass %>% 
  
  rename(
    "component" = Component,
    "total_dissolved" = Total.dissolved,
    "dissolved" = X..dissolved,
    "total_precipitated" = Total.precipitated,
    "precipitated" = X..precipitated
  ) %>% 
  
  select(-c(Total.sorbed, X..sorbed)) %>% 
  
  pivot_longer(
    cols = c(dissolved, precipitated),
    names_to = "fate",
    values_to = "percentage"
  ) %>% 
  
  filter(fate == "precipitated") %>%  
  
  mutate(
    component = as.factor(component),
    cation_anion = if_else(grepl("\\+", component) == TRUE, "cation", "anion")
  ) %>% 
  
  write_csv("results/precipitation.csv")