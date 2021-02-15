library(haven)
Upersonas2010 <- read_dta("C:/Users/juanp/Downloads/Trabajo de grado/Urbano 2010/Bases/Upersonas.dta")

library(dplyr)
install.packages("plm")
library(plm)
install.packages("zoo")
library(zoo)
library(data.table)

Upersonas_Filtrado_2010 <- Upersonas2010 %>%
  select("ola":"llave_ID_lb", "edad", "sexo", "parentesco", "educ_padre", "educ_madre", 
         "etnia", "afiliacion", "sss", "regimen", "sss_porque", "cotiza_fp", "lee_escribe", 
         "estudia", "nivel_educ", "poc", "vr_salario", "tam_empresa", "n_empleados","vr_ahorro")

Upersonas2013 <- read_dta("C:/Users/juanp/Downloads/Trabajo de grado/Urbano 2013/Bases/Upersonas.dta")

Upersonas_Filtrado_2013 <- Upersonas2013 %>%
  select("ola":"llaveper", "edad", "sexo", "parentesco", "educ_padre", "educ_madre", 
         "etnia", "segsoc_salud", "afiliacion_fp",  "afiliacion", "afilia_porque", "beneficiario_sss","cotizando",
         "lee_escribe", "rzn_nocotiza", "estudia","poc", "nivel_educ", "vr_salario","vr_ahorro")

Upersonas2016 <- read_dta("C:/Users/juanp/Downloads/Trabajo de grado/Urbano 2016/Bases/Upersonas.dta")

Upersonas_Filtrado_2016 <- Upersonas2016 %>%
  select("ola":"llaveper", "edad", "sexo", "parentesco", "educ_padre", "educ_madre", 
         "etnia", "segsoc_salud", "afiliacion_fp",  "afiliacion", "afilia_porque", "beneficiario_sss","cotizando",
         "lee_escribe", "rzn_nocotiza", "estudia","poc", "nivel_educ", "vr_salario","vr_ahorro")

#Este codigo de Uhogar sirve para los 3 años. 

Uhogar2010 <- read_dta("C:/Users/juanp/Downloads/Trabajo de grado/Urbano 2010/Bases/Uhogar.dta")

Uhogar_Filtrado_2010 <- Uhogar2010 %>%
  select("ola":"id_depto", "estrato", "consecutivo", "t_personas",
         "familias_accion":"otro_programa_cual", "ing_trabajo", "vr_gtos_mensuales")

Uhogar2013 <- read_dta("C:/Users/juanp/Downloads/Trabajo de grado/Urbano 2013/Bases/Uhogar.dta")

Uhogar_Filtrado_2013 <- Uhogar2013 %>%
  select("ola":"id_depto", "estrato", "consecutivo", "t_personas",
         "familias_accion":"otro_programa_cual", "ing_trabajo", "vr_gtos_mensuales")

Uhogar2016 <- read_dta("C:/Users/juanp/Downloads/Trabajo de grado/Urbano 2016/Bases/Uhogar.dta")

Uhogar_Filtrado_2016 <- Uhogar2016 %>%
  select("ola":"id_depto", "estrato", "consecutivo", "t_personas",
         "familias_accion":"otro_programa_cual", "ing_trabajo", "vr_gtos_mensuales")

#Unir bases de datos

base_2010 <- Upersonas_Filtrado_2010 %>%
  full_join(Uhogar_Filtrado_2010, by = "consecutivo")

base_2013 <- Upersonas_Filtrado_2013 %>%
  full_join(Uhogar_Filtrado_2013, by = "consecutivo")

base_2016 <- Upersonas_Filtrado_2016 %>%
  full_join(Uhogar_Filtrado_2016, by = "consecutivo")


##Filtrar bases  --- Formal == 1, Informal == 0

base_2010 <- base_2010 %>%
  filter(poc == 1, edad >= 15) %>%
  filter(cotiza_fp == 3 | cotiza_fp == 4 | cotiza_fp == 6 | cotiza_fp == 7)


base_2010 <- base_2010 %>%
  mutate(base_2010, informal = ifelse(afiliacion == 2, 0, 
                                      ifelse(cotiza_fp == 4, 0, 
                                             ifelse(cotiza_fp == 6, 0, 
                                                    ifelse(cotiza_fp == 7, 0, 1)))))

base_2013 <- base_2013 %>%
  filter(poc == 1, edad >= 15) 

base_2013 <- base_2013 %>%
  mutate(base_2013, informal = ifelse(afiliacion == 2, 0,
                                      ifelse(cotizando == 2, 0, 1))) %>%
  filter(informal == 1 | informal == 0)

base_2016 <- base_2016 %>%
  filter(poc == 1, edad >= 15) 

base_2016 <- base_2016 %>%
  mutate(base_2016, informal = ifelse(afiliacion == 2, 0,
                                      ifelse(cotizando == 2, 0, 1))) %>%
  filter(informal == 1 | informal == 0)

#balancear

base_2013 <- base_2013 %>%
  group_by(consecutivo) %>%
  slice(1)

base_2010 <- base_2010 %>%
  group_by(consecutivo) %>%
  slice(1)

base_2016 <- base_2016 %>%
  group_by(consecutivo) %>%
  slice(1)

base_2016 <- base_2016 %>%
  semi_join(base_2010, by = "llave_ID_lb")

base_2016 <- base_2016 %>%
  semi_join(base_2013, by = "llave_ID_lb")

base_2013 <- base_2013 %>%
  semi_join(base_2010, by = "llave_ID_lb")

base_2010 <- base_2010 %>%
  semi_join(base_2016, by = "llave_ID_lb")

base_2013 <- base_2013 %>%
  semi_join(base_2016, by = "llave_ID_lb")


#unir en una base los tres años

base_completa <- bind_rows(base_2010, base_2013)
base_completa <- bind_rows(base_completa, base_2016)

base_completa_filtrada <- base_completa %>%
  select("ola.x", "consecutivo", "edad", "sexo", "educ_padre":"etnia", 
         "lee_escribe":"nivel_educ", "vr_salario", "vr_ahorro", "region", "estrato", 
         "familias_accion":"caja_saludrec", "ayu_desplazados", "otro_programa", "ing_trabajo":"informal")

base_completa_filtrada <- base_completa_filtrada %>%
  rename("anio" = "ola.x")

base_completa_filtrada$anio[base_completa_filtrada$anio == 1] <- 2010
base_completa_filtrada$anio[base_completa_filtrada$anio == 2] <- 2013
base_completa_filtrada$anio[base_completa_filtrada$anio == 3] <- 2016

##rellenar educ_madre y educ_padre y arreglar los datos

base_completa_filtrada <- base_completa_filtrada %>%
  arrange(consecutivo)

base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "educ_madre")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "educ_padre")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "educ_madre")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "etnia")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "region")
base_completa_filtrada$educ_padre[base_completa_filtrada$educ_padre == 99] <- 4 ##Reemplazo por la media 
base_completa_filtrada$educ_padre[base_completa_filtrada$educ_padre == 98] <- 4
base_completa_filtrada$educ_madre[base_completa_filtrada$educ_madre == 98] <- 4
base_completa_filtrada$educ_madre[base_completa_filtrada$educ_madre == 99] <- 4
base_completa_filtrada$region[base_completa_filtrada$region == 0] <- 2
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "familias_accion")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "jovenes_accion")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "sena")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "red_juntos")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "icbf")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "sub_desempleo")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "caja_subsprest")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "caja_saludrec")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "ayu_desplazados")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "otro_programa")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "vr_gtos_mensuales")
base_completa_filtrada <- setnafill(base_completa_filtrada, type = "locf", cols = "ing_trabajo")


base_completa_filtrada$anio <- as.factor(base_completa_filtrada$anio)
base_completa_filtrada$informal <- as.(base_completa_filtrada$informal)
                                             
## Hasta aqui la base de datos esta balanceada


modelo <- plm(informal ~ familias_accion + sexo + educ_padre + educ_madre + 
                jovenes_accion + sena + red_juntos + icbf + sub_desempleo +
                caja_subsprest + caja_saludrec + ayu_desplazados + otro_programa, 
              data = base_completa_filtrada, 
              index = c("consecutivo", "anio"), model = "random")

modelo <- plm(informal ~ familias_accion + sexo + educ_padre + educ_madre + 
                sub_desempleo + caja_subsprest + caja_saludrec, 
              data = base_completa_filtrada, 
              index = c("consecutivo", "anio"))


summary(modelo)

str(base_completa_filtrada)







  
