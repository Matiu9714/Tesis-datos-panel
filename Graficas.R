library(ggplot2)
library(haven)
library(tidyverse)
library(dplyr)

str(base_completa_filtrada)

ggplot(base_completa_filtrada, aes(estrato, ing_trabajo)) +
  geom_point()

ggplot(base_completa_filtrada, aes(factor(informal), ing_trabajo)) +
  geom_point()

ggplot(base_completa_filtrada, aes(edad, ing_trabajo, na.rm = TRUE, color = region)) +
  geom_point() + geom_smooth()

ggplot(base_completa_filtrada, aes(factor(region), ing_trabajo, size = estrato)) +
  geom_point()







