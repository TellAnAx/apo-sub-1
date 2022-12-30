boxplot_saturation <- saturation %>% 
  
  rename(
    "logQK" = Sat..index
  ) %>% 
  
  mutate(
    cation = if_else(Col5 == "H+1", if_else(Col8 > Col6 & Col9 != "H2O", Col9, Col7), Col5),
    anion = if_else(is.na(Col11) == TRUE & is.na(Col9) == TRUE, Col7, Col11),
    anion = if_else(is.na(anion) == TRUE & is.na(Col11) == TRUE, if_else(Col7 %in% c("H+1", "Mg+2", "Ca+2", "Fe+3"), Col9, Col7), anion),
    anion = if_else(anion == "H2O", if_else(Col9 %in% c("H+1", "Mg+2", "Ca+2", "Fe+3"), anion, Col9), anion)
  ) %>% 
  
  filter(logQK > -5) %>% 
  
  ggplot(aes(x = anion, y = logQK, fill = anion)) +
    geom_boxplot() +
    geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
    facet_wrap(facets = vars(cation)) +
    labs(
      x = "Anion",
      y = 'log(Q/K)'
    ) +
    theme(
      legend.position = 'none',
      #axis.ticks.x = element_blank(),
      axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)
    )




boxplot_saturation

ggsave('plots/boxplot_empirical_saturation_vm.png')



###----------------------------------------------------------------------------
###----------------------------------------------------------------------------
###----------------------------------------------------------------------------
