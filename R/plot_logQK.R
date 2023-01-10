library(rlang)

boxplot_saturation <- read_csv(here::here("results", "logQK.csv")) %>% 
  
  mutate(
    cation = factor(
      cation,
      levels = c(
        "Ca+2",
        "Fe+3",
        "Mn+2",
        "Cu+2"
      ),
      labels = c(
        expression(Ca^{2*"+"}), 
        expression(Fe^{3*"+"}), 
        expression(Mn^{2*"+"}), 
        expression(Cu^{2*"+"})
      )
    ),
    anion = factor(
      anion,
      levels = c(
        "H+1",
        "H2O",
        "PO4-3"
      ),
      labels = c(
        expression(H^{"+"}),
        expression(H[2]*O),
        expression(PO[4]^{3*"-"})
      )
    )
  ) %>% 
  
  ggplot(aes(x = anion, y = logQK, fill = anion)) +
  geom_boxplot() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  
  scale_x_discrete(labels = rlang::parse_exprs) + 
  facet_wrap(facets = vars(cation), labeller = label_parsed) +
  
  labs(
    x = "Anion",
    y = 'log(Q/K)'
  ) +
  
  theme_bw() + 
  theme(
    legend.position = 'none',
    #axis.ticks.x = element_blank(),
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)
  )



boxplot_saturation

ggsave(here::here("plots", "boxplot_empirical_saturation_vm.png"))