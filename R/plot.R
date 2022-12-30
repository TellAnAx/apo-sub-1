# BARPLOT - Empirical data
barplot_empirical <- ggplot(data_long_max_empirical, aes(x = max, y = cation, fill = sample_ID)) +
  geom_col(position = position_dodge()) +
  labs(
    x = 'log(Q/K)',
    y = 'Cation',
    fill = 'Mineral'
  )

ggsave('plots/barplot_empirical_saturation.png')



# BOXPLOT - Empirical data
boxplot_empirical <- ggplot(data_long_empirical, aes(y = logQK, fill = anion)) +
  geom_boxplot() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  facet_wrap(facets = vars(cation), scales = "free") +
  labs(
    y = 'log(Q/K)',
    fill = 'Anion'
  ) +
  theme(
    legend.position = 'bottom',
    axis.ticks.x = element_blank(),
    axis.text.x = element_blank()
  )

ggsave('plots/boxplot_empirical_saturation.png')





###----------------------------------------------------------------------------
###----------------------------------------------------------------------------
###----------------------------------------------------------------------------

# BARPLOT - Hoagland solution at different pH
barplot_hoagland <- ggplot(data_long_hoagland, aes(x = cation, y = logQK, fill = anion)) +
  geom_col(position = position_dodge()) +
  facet_wrap(facets = vars(pH)) + 
  labs(
    x = 'Cation',
    y = 'log(Q/K)',
    fill = 'Anion'
  ) +
  theme(
    legend.position = 'bottom'
  )

ggsave('plots/barplot_hoagland_saturation.png')



# SCATTERPLOT - Hoagland solution at different pH
scatterplot_hoagland <- ggplot(data_long_hoagland, aes(x = pH, y = logQK, color = anion)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  facet_wrap(facets = vars(cation)) + 
  labs(
    x = 'pH',
    y = 'log(Q/K)',
    color = 'Anion'
  ) +
  theme(
    legend.position = 'bottom'
  )

ggsave('plots/scatterplot_hoagland_saturation.png')
