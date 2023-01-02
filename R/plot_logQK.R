boxplot_saturation <- read.csv("results/logQK.csv") %>% 
  
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