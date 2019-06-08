# Modulo deslizador -------------------------------------------------

## Segmento del UI
deslizadorUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    sliderInput(ns("frec_input"),
                "Frecuencia:",
                min = 1,  max = 50, value = 15),
    
    sliderInput(ns("max_input"),
                "Máximo de palabras:",
                min = 1,  max = 300,  value = 100)
  )
}

## Segmento del server
deslizador <- function(input, output, session) {
  return(
    list(
      frec_input = reactive({ input$frec_input }),
      max_input = reactive({ input$max_input })
    )
  )
}


