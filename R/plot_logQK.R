library(rlang)

boxplot_saturation <- read_csv(here::here("results", "logQK.csv")) %>% 
  
  
  
  #filter(logQK > -1) %>% 
  
  
  
  mutate(
    cation = factor(
      cation,
      levels = c(
        "K+1",
        "Ca+2",
        "Mg+2",
        "Fe+3",
        "Mn+2",
        "Cu+2",
        "Zn+2"
      ),
      labels = c(
        expression(K^{"+"}), 
        expression(Ca^{2*"+"}), 
        expression(Mg^{2*"+"}), 
        expression(Fe^{3*"+"}), 
        expression(Mn^{2*"+"}), 
        expression(Cu^{2*"+"}),
        expression(Zn^{2*"+"})
      ),
      exclude = "H2O"
    ),
    anion = factor(
      anion,
      levels = c(
        "H+1",
        "PO4-3",
        "CO3-2",
        "SO4-2",
        "NO3-1"
      ),
      labels = c(
        expression(H^{"+"}),
        expression(PO[4]^{3*"-"}),
        expression(CO[3]^{2*"-"}),
        expression(SO[4]^{2*"-"}),
        expression(NO[3]^{"-"})
      ),
      exclude = c(
        "H2O",
        "H3BO3"
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