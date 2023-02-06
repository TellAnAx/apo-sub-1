library(rlang)

boxplot_saturation <- read_csv(here::here("results", "logQK.csv")) %>%
  
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
        "OH-",
        "PO4-3",
        "CO3-2",
        "SO4-2",
        "NO3-1",
        "H3BO3",
        "O-2"
      ),
      labels = c(
        expression(OH^{"-"}),
        expression(PO[4]^{3*"-"}),
        expression(CO[3]^{2*"-"}),
        expression(SO[4]^{2*"-"}),
        expression(NO[3]^{"-"}),
        expression(B(OH)[4]^{"-"}),
        expression(O^{2*"-"})
      ),
      exclude = c(
        "H2O"
      )
    )
  ) %>% 
  
  filter(logQK > -25) %>% 
  
  ggplot(aes(x = anion, y = logQK, fill = anion)) +
  geom_boxplot() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  
  scale_x_discrete(labels = rlang::parse_exprs) + 
  facet_wrap(facets = vars(cation), labeller = label_parsed) +
  
  lims(
    y = c(-5, 1.5)
  ) + 
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





boxplot_saturation + 
  labs(
    title = paste("Mineral saturation indices"),
    subtitle = paste("Calculated using data from aquaponic studies")
  ) +
  theme(
    	text = element_text(size = 20) # change font size of all text
    #	axis.text = element_text(size = 20) # change font size of axis text
    # axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1), # rotate axis labels
    #	axis.title = element_text(size = 20), # change font size of axis title
    #	plot.title = element_text(size = 20) # change font size of plot titles
    # legend.position = "top", # change position of the legend
    #	legend.text = element_text(size = 20), # change font size of legend text
    #	legend.title = element_text(size = 20) # change font size of legend title
  )

ggsave(
  here::here("plots", "presentation_boxplot_empirical_saturation_vm.png"),
  width = 25, height = 15, units = "cm"
  )
