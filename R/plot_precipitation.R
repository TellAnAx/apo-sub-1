library(rlang)


boxplot_precipitated <- read_csv("results/precipitation.csv") %>% 
  
  mutate(
    component = factor(
      component,
      levels = c(
        "NH4+1",
        "K+1",
        "Ca+2",
        "Mg+2",
        "Fe+3",
        "Mn+2",
        "Cu+2",
        "Zn+2",
        "CO3-2",
        "NO2-1",
        "NO3-1",
        "PO4-3",
        "SO4-2",
        "H3BO3",
        "DOM1"
      ),
      labels = c(
        expression(NH[4]^{"+"}),
        expression(K^{"+"}),
        expression(Ca^{2*"+"}), 
        expression(Mg^{2*"+"}), 
        expression(Fe^{3*"+"}), 
        expression(Mn^{2*"+"}), 
        expression(Cu^{2*"+"}), 
        expression(Zn^{2*"+"}),
        expression(CO[3]^{2*"-"}),
        expression(NO[2]^{"-"}),
        expression(NO[3]^{"-"}),
        expression(PO[4]^{3*"-"}),
        expression(SO[4]^{2*"-"}),
        expression(B(OH)[4]^{"-"}),
        expression(DOM^{"-"})
      ), 
      exclude = c(
        "DOC (Gaussian DOM)",
        "H+1"
      )
    ),
    cation_anion = factor(
      cation_anion,
      levels = c("cation", "anion"),
      labels = c("Cation", "Anion")
    )
  ) %>% 
  
  drop_na(component) %>%
  
  #print()
  
  ggplot(aes(x = percentage, y = reorder(component, desc(component)), fill = cation_anion)) + 
  geom_boxplot() + 
  
  scale_y_discrete(labels = rlang::parse_exprs) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  #scale_fill_manual(values = c("lightblue", "lightred")) + 
  facet_wrap(facets = vars(cation_anion), scales = "free") +
  
  labs(
    y = "",
    x = "% precipitation of total conc.",
    fill = ""
  ) + 
  
  theme_bw() + 
  theme(
    legend.position = "none"
    #axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)
  )


boxplot_precipitated


ggsave(here::here("plots", "boxplot_precipitated_vm.png"))
