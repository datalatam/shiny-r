library(shiny)
library(dplyr)
library(babynames)

# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel("Usar renderUI"),

   # Representa la seleccion que generamos en server()
   sidebarLayout(
      sidebarPanel(
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

  output$opciones_nombre <- renderUI({

    selectInput(inputId = "opciones_nombre",
                label = "Escoje un Nombre",
                choices = sort(unique(babynames$name)))

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

