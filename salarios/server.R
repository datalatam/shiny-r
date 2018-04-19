
salarios <- read_csv("datos/ccss_salarios.csv")

server <- function(input, output) {
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
        
        
}