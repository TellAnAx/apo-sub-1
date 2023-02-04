
library(rlang)

boxplot_dom <- read_csv("results/dom.csv") %>% 
  
  mutate(
    species_name = factor(
      species_name,
      levels = c(
        "Ca DOM1", 
        "Mg DOM1", 
        "Fe DOM1", 
        "Cu DOM1", 
        "Zn DOM1"
        ),
      labels = c(
        expression(Ca^{2*"+"}), 
        expression(Mg^{2*"+"}), 
        expression(Fe^{3*"+"}), 
        expression(Cu^{2*"+"}), 
        expression(Zn^{2*"+"})
        ),
      exclude = "H DOM1"
    )
  ) %>% 
  
  drop_na(species_name) %>% 
  
  ggplot(aes(x = percentage_of_total_conc, y = reorder(species_name, desc(species_name)), fill = species_name)) + 
  geom_boxplot() + 
  
  scale_y_discrete(labels = rlang::parse_exprs) + 
  scale_fill_brewer(palette = "Set1", direction = -1) +
  
  labs(
    x = "Percentage of total conc. complexed",
    y = "Complexed cation"
  ) + 
  
  theme_bw() + 
  theme(
    legend.position = "none"
  )



boxplot_dom

ggsave(here::here("plots", "boxplot_species_dom_vm.png"))





boxplot_dom +
  labs(
    title = paste("Complexation by dissolved organic matter (DOM)")
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
  here::here("plots", "presentation_boxplot_species_dom_vm.png"),
  width = 25, height = 15, units = "cm"
  )
