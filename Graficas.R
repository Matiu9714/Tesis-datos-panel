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

ggplot(base_completa_filtrada, aes(factor(region), ing_trabajo, fill = factor(sexo),
                                   na.rm = TRUE)) + 
  geom_point(shape = 21, alpha = 0.6) + scale_y_log10()


ggplot(base_completa_filtrada, aes(factor(region), ing_trabajo)) +
  geom_point(position = "jitter")

ggplot(base_completa_filtrada, aes(vr_ahorro, ing_trabajo)) +
  geom_point() + scale_x_continuous() + scale_y_continuous() + 
  labs(y = "Ingreso Trabajo", x = "Valor Ahorrado")


ggplot(base_completa_filtrada, aes(factor(estrato), fill = mean(ing_trabajo))) +
  geom_bar(position = "dodge") + labs(x = "Estrato", y = "Ingreso Trabajo")





