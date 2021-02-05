library(haven)
Upersonas <- read_dta("C:/Users/juanp/Downloads/Trabajo de grado/Urbano 2010/Bases/Upersonas.dta")
view(Upersonas)

library(dplyr)

Upersonas_Filtrado <- Upersonas %>%
  select("ola":"llave_ID_lb", "edad", "sexo", "parentesco", "educ_padre", "educ_madre", 
         "etnia", "afiliacion", "sss", "cotiza_fp", "beneficiario_sss", "lee_escribe", 
         "estudia", "nivel_educ", "vr_salario", "tam_empresa", "n_empleados", "estaba_sss",
         "estaba_fp", "tamano_tenia", "n_empleados_tenia", "vr_ganaba_in", "vr_ahorro")

