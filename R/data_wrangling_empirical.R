data <- data_empirical

# Conversion to longtable for plotting
data_long_empirical <- data %>% 
  pivot_longer(cols = 5:ncol(data), names_to = 'reference', values_to = 'logQK') %>%
  print(n = nrow(data))


# Conversion to longtable (maxima) for plotting
data_long_max_empirical <- data %>% 
  pivot_longer(cols = 5:ncol(data), names_to = 'reference', values_to = 'logQK') %>%
  group_by(cation, sample_ID) %>%
  summarise(max = max(logQK, na.rm = TRUE)) %>%
  arrange(desc(max), .by_group = TRUE) %>%
  ungroup() %>%
  print(n = nrow(data))


rm(data)