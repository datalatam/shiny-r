# example snippets

ui <- fluidPage(
  textInput("a","","A")
)


server <- function(input,output){
  rv <- reactiveValues()
  rv$number <- 5
}

shinyApp(ui, server)
