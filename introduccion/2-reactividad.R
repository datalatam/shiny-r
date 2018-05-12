library(shiny)
ui <- fluidPage(
  textInput("a","","A"),
  textOutput("b")
)

server <- function(input,output){
  output$b <-  
    renderText({
      isolate({input$a})
    })
}

shinyApp(ui, server)