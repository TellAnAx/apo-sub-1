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
  
  #filter(
  #  percentage > 0 &
  #    percentage < 100
  #) %>% 
  
  mutate(
    component = as.factor(component)
  ) %>% 
  
  ggplot(aes(x = percentage, y = component, fill = component)) + 
    geom_boxplot() + 
    facet_wrap(facets = vars(fate)) + 
  theme(
    legend.position = "none"
  )
