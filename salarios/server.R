
salarios <- read_csv("datos/ccss_salarios.csv")

server <- function(input, output) {
        
        # Cuadros color resumen
        output$Profesiones <- renderValueBox({
                tipos <- salarios %>%
                        group_by(OCUPACION, OCUPACION.NOMBRE) %>%
                        n_distinct()
                
                valueBox(
                        paste0(tipos),
                        "Profesiones totales", 
                        icon = icon("university"),
                        color = "purple"
                )
        })
        
        output$SalarioMayor <- renderValueBox({
                salario_alto <- max(salarios$SALARIO) %>% 
                  to_currency(currency_symbol = " ", symbol_first = TRUE,
                              group_size = 3, group_delim = " ", 
                              decimal_size = 2, decimal_delim = ".")
                
                valueBox(
                        paste0(salario_alto),
                        "Salario mayor",
                        icon = icon("credit-card"),
                        color = "teal"
                )
        })
        
  output$SalarioMenor <- renderValueBox({
    salario_bajo <- salarios %>%
      filter(SALARIO > 100000) 
            
          salario_bajo <- min(salario_bajo$SALARIO) %>% 
            to_currency(currency_symbol = " ", symbol_first = TRUE,
                        group_size = 3, group_delim = " ",
                        decimal_size = 2, decimal_delim = ".")
          
          valueBox(
                  paste0(salario_bajo),
                  "Salario menor",
                  icon = icon("credit-card"),
                  color = "green"
          )
  })
        
  # Figuras distribución salarios 4 profesiones mejor pagadas
 output$salarios_mayores <- renderPlot({
   salarios_mayores <- salarios %>%
     group_by(OCUPACION.NOMBRE) %>%
     summarise(
       promedio = mean(SALARIO)
       ) %>%
     arrange(desc(promedio)) %>%
     slice(1:4)
    
    salarios_mayores_completos <- semi_join(salarios, salarios_mayores,
                                            by = "OCUPACION.NOMBRE")
    
    salarios_mayores_completos$OCUPACION.NOMBRE[salarios_mayores_completos$OCUPACION.NOMBRE == "Gerentes y subgerentes generales, directores y subdirectores generales y coordinadores generales de instituciones públicas y de empresas privadas"] <- "Directores/Gerentes"
    salarios_mayores_completos$OCUPACION.NOMBRE[salarios_mayores_completos$OCUPACION.NOMBRE == "Personal de nivel directivo de la administración pública"] <- "Administrativos"
    

    ggplot(salarios_mayores_completos, aes(x = OCUPACION.NOMBRE, y = SALARIO,
                       color = OCUPACION.NOMBRE)) +
          geom_boxplot() +
          geom_jitter(alpha = 0.2) +
          xlab("Profesión") +
          theme_classic(base_size = 16) +
          theme(legend.position = "none",
                axis.text.x = element_text(angle = 90))
    
    })
 
 # 
  
  output$salarios_totales <-  renderPlot({
    promedios <- salarios %>%
      group_by(OCUPACION) %>%
      summarise(
        prom = mean(SALARIO)
        )
    
    ggplot(promedios, aes(x = factor(OCUPACION), y = prom,
                          fill = as.factor(OCUPACION))) +
      geom_bar(stat = "identity") +
      xlab("Código ocupación") + ylab("Promedio salario") +
      theme_classic(base_size = 16) +
      theme(legend.position = "none",
            axis.text.x = element_text(angle = 90))
      
    })
  
  # Plot cantidad de personas por profesión
  output$cantidad_profesion <- renderPlot({
    cantidad_por_profesion <- salarios %>%
      group_by(OCUPACION) %>%
      summarise(
        total = n()
        )
    
    ggplot(cantidad_por_profesion, aes(x = factor(OCUPACION),
                                       y = total, fill = as.factor(OCUPACION))) +
      geom_bar(stat = "identity") +
      xlab("Código ocupación") + ylab("Cantidad total") +
      theme_classic(base_size = 16) +
      theme(legend.position = "none", axis.text.x = element_text(angle = 90))
    
    })
  
  # Plot distribución salario auxiliares enfermería
  output$auxiliares_enfermeria <- renderPlot({
    auxiliares_enfermeria <- salarios %>%
      filter(OCUPACION.NOMBRE == "Auxiliares de enfermería")
    
    ggplot(auxiliares_enfermeria, aes(x = OCUPACION.NOMBRE, y = SALARIO,
                                      color = OCUPACION.NOMBRE)) +
      geom_boxplot() +
      geom_jitter(alpha = 0.1) +
      xlab("Auxiliares de enfermería") +
      theme_classic(base_size = 16) +
      theme(legend.position = "none",axis.text.x = element_blank())
    
    })
          
  
  # Cuadros profesiones peor pagadas
  output$menor_pagagas <- DT::renderDataTable({
    cuadro_menor_pagadas <- DT::datatable(salarios %>%
                    group_by(OCUPACION.NOMBRE) %>%
                    summarise(
                      promedio = mean(SALARIO)
                      ) %>%
                    arrange(promedio) %>%
                    slice(1:20)
                  )
    
      formatCurrency(cuadro_menor_pagadas, columns = "promedio", currency = "₡", 
                     interval = 3, mark = " ", digits = 2)
    })
  
        
}