library(shiny)

ui <- fluidPage(
  numericInput(inputId = "n", 
               "Tamaño muestra", value = 25),
  plotOutput(outputId = "hist")
)

server <- function(input, output) {
  output$hist <- renderPlot({
    hist(rnorm(input$n))
  })
}
