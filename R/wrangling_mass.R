boxplot_precipitated <- mass %>% 
  
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
  
  filter(fate == "precipitated") %>%  
  
  mutate(
    component = as.factor(component)
  ) %>% 
  
  ggplot(aes(y = percentage, x = component, fill = component)) + 
    geom_boxplot() + 
    geom_hline(yintercept = 0, color = "darkgreen", linetype = "dashed") + 
    geom_hline(yintercept = 100, color = "red", linetype = "dashed") + 
    theme(
      legend.position = "none",
      axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)
    )



boxplot_precipitated

ggsave('plots/boxplot_precipitated_vm.png')
