
salarios <- read_csv("datos/ccss_salarios.csv")

server <- function(input, output) {
        output$Profesiones <- renderValueBox({
                tipos <- salarios %>%
                        group_by(OCUPACION, OCUPACION.NOMBRE) %>%
                        n_distinct()
                
                valueBox(
                        paste0(tipos),"Profesiones totales", icon = icon("list"),
                               color = "purple"
                )
        })
}