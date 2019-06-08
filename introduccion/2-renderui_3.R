library(shiny)
library(dplyr)
library(babynames)
library(ggplot2)

babynames <- babynames::babynames %>%
  filter(n > 500) %>%
  sample_frac(.2)

# Temas:
# Pre-Seleccionar la seleccion
# reactiveVal
# Require (req)

ui <- fluidPage(

   # Application title
   titlePanel("Usar renderUI"),

   # Representa la seleccion que generamos en server()
   sidebarLayout(
      sidebarPanel(
         uiOutput("opciones_sexo"),
         uiOutput("opciones_nombre")
      ),

      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$opciones_sexo <- renderUI({
    selectInput(inputId = "opciones_sexo",
                label = "Escoje Sexo",
                choices = c("F/M", "F", "M"),
                selected = "F/M")
  })


  output$opciones_nombre <- renderUI({
    names <- seleccion() %>%
      select(name) %>%
      distinct() %>%
      unlist() %>% unname()

    selectInput(inputId = "opciones_nombre",
                label = "Escoje un Nombre",
                choices = sort(names))
  })

  seleccion <- reactiveVal(babynames)

# observeEvent(input$opciones_sexo, {
#   req(input$opciones_sexo)
#
#   contenido_actual <- seleccion()
#
#  # contenido_actual <- babynames
#   if (input$opciones_sexo == "F/M") {
#       nueva_seleccion <- contenido_actual
#   } else {
#     nueva_seleccion <- contenido_actual %>%
#       filter(sex == input$opciones_sexo)
#   }
#   seleccion(nueva_seleccion)
# })


   output$distPlot <- renderPlot({
#     req(input$opciones_nombre)
     plot_data <- seleccion() %>%
       dplyr::filter(name == input$opciones_nombre)

     ggplot(data = plot_data, aes(x = year, y = n, color = sex)) +
       geom_line()
   })
}

# Run the application
shinyApp(ui = ui, server = server)

