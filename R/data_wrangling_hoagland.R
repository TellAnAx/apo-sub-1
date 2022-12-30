data <- data_hoagland

data_long_hoagland <- data %>% 
  pivot_longer(cols = 5:6,names_to = 'reference', values_to = 'logQK') %>% 
  separate(reference, into = c("reference", "pH"), sep = "_pH") %>% 
  mutate(pH = as.factor(pH)) %>% 
  print(n = nrow(data))

rm(data)