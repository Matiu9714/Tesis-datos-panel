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
         "etnia", "afiliacion", "afilia_porque", "beneficiario_sss","cotizando",
         "lee_escribe", "rzn_nocotiza", "estudia", "nivel_educ", "vr_salario","vr_ahorro")

Upersonas2016 <- read_dta("C:/Users/juanp/Downloads/Trabajo de grado/Urbano 2016/Bases/Upersonas.dta")

Upersonas_Filtrado_2016 <- Upersonas2016 %>%
  select("ola":"llaveper", "edad", "sexo", "parentesco", "educ_padre", "educ_madre", 
         "etnia", "afiliacion", "afilia_porque", "beneficiario_sss","cotizando",
         "lee_escribe", "rzn_nocotiza", "estudia", "nivel_educ", "vr_salario","vr_ahorro")

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


##Filtrar bases

base_2010 <- base_2010 %>%
  filter(poc == 1, edad >= 15) %>%
  filter(cotiza_fp == 3 | cotiza_fp == 4 | cotiza_fp == 6 | cotiza_fp == 7)


base_2010 <- base_2010 %>%
  mutate(base_2010, informal = ifelse(afiliacion == 2, 1, 
                               ifelse(cotiza_fp == 4, 1, 
                               ifelse(cotiza_fp == 6, 1, 
                               ifelse(cotiza_fp == 7, 1, 0)))))
