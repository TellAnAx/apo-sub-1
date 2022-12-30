###----------------------------------------------------------------------------
###----------------------------------------------------------------------------
###----------------------------------------------------------------------------
#
# DOM - DISSOLVED ORGANIC MATTER
#


boxplot_dom <- species %>% 
  
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
  
  ggplot(aes(x = percentage_of_total_conc, y = species_name, fill = species_name)) + 
    geom_boxplot() + 
    theme(
      legend.position = "none"
    )



boxplot_dom

ggsave('plots/boxplot_species_dom_vm.png')



###----------------------------------------------------------------------------
###----------------------------------------------------------------------------
###----------------------------------------------------------------------------