library(tidyverse)

scientific_10 <- function(x) {
  parse(text=gsub("e", " %*% 10^", scales::scientific_format()(x)))
}



read_csv("tests/data/FePO4_PO4_precip.csv") %>%
  
  select(c(`Fe+++`, `PO4---`, `-log H+`)) %>%
  
  pivot_longer(
    cols = c(`Fe+++`, `PO4---`),
    names_to = 'ion',
    values_to = 'concentration'
    ) %>% 
  
  rename('ph'= `-log H+`) %>% 
  
  filter(ph >= 5 & ph <= 8) %>% 
  
  mutate(ion = factor(ion, labels = c(bquote('Fe^3+'),'PO[4]^{3-}'))) %>% 
  
  ggplot(aes(x = ph, y = concentration, color = as.factor(ion))) + 
  geom_point(size = 4, shape = 4) +
  
  
  lims(x = c(5.5, 7.5), y = c(0, 1e-8)) + 
  labs(
    title = 'Iron and phosphate concentration in dependence of pH',
    subtitle = bquote(c[T]*(P)~'='~c[T]*(Fe)~'= 1 mmol'~L^{-1}),
    y = "log(conc)", 
    color = "") + 
  scale_y_log10() + 
  scale_color_hue(labels = c(expression(Fe^{3+""}), expression(PO[4]^{3-""}))) + 
  theme_minimal() + 
  theme(
    text = element_text(size = 24)
  )

ggsave(filename = 'tests/plot.png', width = 30, height = 18, units = "cm")