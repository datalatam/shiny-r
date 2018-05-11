library(shiny)
library(dplyr)
library(babynames)

# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel("Cual problema tenemos aqui?"),

   # Representa la seleccion que generamos en server()
   sidebarLayout(
      sidebarPanel(
         uiOutput("opciones_nombre"),
         uiOutput("opciones_sexo"),
         uiOutput("opciones_anyo")
      ),

      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$opciones_nombre <- renderUI({

    selectInput(inputId = "opciones_nombre",
                label = "Escoje un Nombre",
                choices = sort(unique(babynames$name)))

  })

  output$opciones_sexo <- renderUI({
    selectInput(inputId = "opciones_sexo",
                label = "Escoje Sexo",
                choices = c("F", "M"))

  })

  output$opciones_anyo <- renderUI({
    selectInput(inputId = "opciones_anyo",
                label = "Escoje un Anyo",
                choices = sort(unique(babynames$year)))

  })

   output$distPlot <- renderPlot({

     seleccion <- babynames %>%
       filter(name == input$opciones_nombre)

     ggplot(data = seleccion, aes(x = year, y = n, group = sex, color = sex)) +
       geom_line()
   })
}

# Run the application
shinyApp(ui = ui, server = server)

