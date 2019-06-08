# Modulo nube de palabras -------------------------------------------------

## Segmento del UI
nubeUI <- function(id) {
  ns <- NS(id)
  
  plotOutput(ns("grafico"))
  
}

## Segmento del server

nube <- function(input, output, session, frecuencia, maximo) {
  
  output$grafico <- renderPlot({
         wordcloud(words = datos_nube$word, freq = datos_nube$freq,
                   min.freq = frecuencia,
                   max.words = maximo, 
                   random.order = FALSE, rot.per = 0.35,
                   colors = brewer.pal(8, "Dark2"))
    
      })
  
}


