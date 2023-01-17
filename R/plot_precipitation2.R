library(rlang)


violinplot_precipitated <- read_csv(here::here("results", "precipitation.csv")) %>% 
  
  mutate(
    component = factor(
      component,
      levels = c(
        "Ca+2",
        "Fe+3",
        "Mn+2",
        "Cu+2",
        "PO4-3"
      ),
      labels = c(
        expression(Ca^{2*"+"}), 
        expression(Fe^{3*"+"}), 
        expression(Mn^{2*"+"}), 
        expression(Cu^{2*"+"}), 
        expression(PO[4]^{3*"-"})
      ), 
      exclude = c(
        "DOC (Gaussian DOM)",
        "H+1",
        "DOM1",
        "NH4+1",
        "K1+",
        "Mg+2",
        "Zn+2",
        "CO3-2",
        "NO2-1",
        "NO3-1",
        "SO4-2",
        "H3BO3"
      )
    ),
    cation_anion = factor(
      cation_anion,
      levels = c("cation", "anion"),
      labels = c("Cation", "Anion")
    )
  ) %>% 
  
  drop_na(component) %>%
  
  ggplot(aes(x = component, y = percentage, color = component)) + 
  geom_violin() +
  #geom_dotplot(binaxis = "y", stackdir = "center", dotsize = 0.2) + 
  geom_jitter(shape=16, position=position_jitter(0.2)) +
  
  scale_x_discrete(labels = rlang::parse_exprs) +
  scale_color_brewer(palette = "Set1", direction = -1) +
  
  labs(
    y = "% precipitation of total conc.",
    x = "",
    fill = ""
  ) + 
  
  theme_bw() + 
  theme(
    legend.position = "none"
  )


violinplot_precipitated

ggsave(here::here("plots", "violinplot_precipitated2_vm.png"))