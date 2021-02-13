library(ggplot2)
library(haven)
library(tidyverse)
library(dplyr)

str(base_completa_filtrada)

##Practica de graficas

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


ggplot(base_completa_filtrada, aes(factor(estrato), ing_trabajo, color = estrato)) +
  geom_point(position = position_jitter(width = 0.3)) + 
  labs(x = "Estrato", y = "Ingreso Trabajo")

ggplot(base_completa_filtrada, aes(factor(estrato), ing_trabajo, color = estrato)) +
  geom_point(position = position_jitterdodge(jitter.width = 0.3, dodge.width = 0.3)) + 
  labs(x = "Estrato", y = "Ingreso Trabajo")

ggplot(base_completa_filtrada, aes(vr_ahorro, ing_trabajo, color = estrato)) +
  geom_point(alpha = 0.7, shape = 16) + scale_x_continuous() + scale_y_continuous() + 
  labs(y = "Ingreso Trabajo", x = "Valor Ahorrado") 

ggplot(base_completa_filtrada, aes(vr_ahorro, ing_trabajo, color = estrato)) +
  geom_jitter(alpha = 0.4, width = 0.3) + scale_x_continuous() + scale_y_continuous() + 
  labs(y = "Ingreso Trabajo", x = "Valor Ahorrado") 

ggplot(base_completa_filtrada, aes(vr_ahorro, ing_trabajo, color = estrato)) +
  geom_point(alpha = 0.4, position = "jitter") + scale_x_continuous() + scale_y_continuous() + 
  labs(y = "Ingreso Trabajo", x = "Valor Ahorrado") 

ggplot(base_completa_filtrada, aes(vr_salario)) + geom_histogram(fill = "blue")

ggplot(base_completa_filtrada, aes(edad, fill = factor(sexo))) + geom_histogram() +
  scale_x_continuous()

ggplot(base_completa_filtrada, aes(ing_trabajo, fill = factor(informal))) + geom_histogram() +
  scale_x_continuous() 

ggplot(base_completa_filtrada, aes(informal, fill = factor(sexo))) + geom_histogram() +
  scale_x_discrete() 

ggplot(base_completa_filtrada, aes(informal, fill = factor(sexo))) + geom_bar() +
  scale_x_discrete() 

ggplot(base_completa_filtrada, aes(informal, fill = factor(sexo))) + 
  geom_bar(position = "fill") + scale_x_discrete() 

ggplot(base_completa_filtrada, aes(informal, fill = factor(sexo))) + 
  geom_bar(position = "dodge") + scale_x_discrete() 

ggplot(base_completa_filtrada, aes(informal, fill = factor(sexo))) + 
  geom_bar(position = position_dodge(width = 0.2)) + scale_x_discrete() 

ggplot(base_completa_filtrada, aes(informal, fill = factor(sexo))) + 
  geom_bar(position = position_dodge(width = 0.2), alpha = 0.6) + scale_x_discrete() 

ggplot(base_completa_filtrada, aes(informal, fill = factor(nivel_educ))) + 
  geom_bar(position = "fill") + scale_x_discrete() 

ggplot(base_completa_filtrada, aes(anio, ing_trabajo, color = factor(sexo))) + 
  geom_violin() + scale_x_continuous() + scale_y_continuous()

















