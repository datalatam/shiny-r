
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
                salario_alto <- max(salarios$SALARIO)
                
                valueBox(
                        paste0(salario_alto),
                        "Salario mayor",
                        icon = icon("credit-card"),
                        color = "teal"
                )
        })
        
        output$SalarioMenor <- renderValueBox({
                salario_bajo <- min(salarios$SALARIO)
                
                valueBox(
                        paste0(salario_bajo),
                        "Salario menor",
                        icon = icon("credit-card"),
                        color = "green"
                )
        })
        
        # Figuras distribución salarios
        
        output$biologos <- renderPlot({
                
                biologos <- salarios %>% 
                        filter(OCUPACION == "2211") 
                
                ggplot(biologos, aes(x = OCUPACION,y = SALARIO,
                                     fill = OCUPACION)) +
                        geom_violin(aes(fill = OCUPACION)) +
                        geom_jitter(alpha = 0.8) +
                        xlab("Biólogos, citólogos, genetistas") +
                        theme_classic(base_size = 16) +
                        theme(legend.position = "none",
                              axis.text.x = element_blank())
        })
        
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
        
        # Cuadros profesiones
        
        output$menor_pagagas <- DT::renderDataTable({
                DT::datatable(salarios %>% 
                        group_by(OCUPACION.NOMBRE) %>% 
                        summarise(
                                promedio = mean(SALARIO) 
                        ) %>% 
                        arrange(promedio) %>%
                        slice(1:20)
                )
                
                
        })
        
        
}