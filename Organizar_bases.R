library(haven)
Upersonas2010 <- read_dta("C:/Users/juanp/Downloads/Trabajo de grado/Urbano 2010/Bases/Upersonas.dta")

library(dplyr)

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
  filter(poc == 1, edad >= 15) %>%
  mutate(base_2013, informal = ifelse(afiliacion == 2, 0,
                                      ifelse(cotizando == 2, 0, 1))) %>%
  filter(informal == 1 | informal == 0)

base_2016 <- base_2016 %>%
  filter(poc == 1, edad >= 15) %>%
  mutate(base_2016, informal = ifelse(afiliacion == 2, 0,
                                      ifelse(cotizando == 2, 0, 1))) %>%
  filter(informal == 1 | informal == 0)

#balancear, o  medio balancear mas bien jajaja

base_2016 <- base_2016 %>%
  semi_join(base_2010, by = "llave_ID_lb")

base_2010 <- base_2010 %>%
  semi_join(base_2016, by = "llave_ID_lb")

base_2013 <- base_2013 %>%
  semi_join(base_2010, by = "llave_ID_lb")


#unir en una base los tres años

base_completa <- bind_rows(base_2010, base_2013)
base_completa <- bind_rows(base_completa, base_2016)

  






  
