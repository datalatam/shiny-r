# server

server <- function(input, output, session) {
  
  deslizadores <- callModule(deslizador, "deslizador_nuevo")
  
  # Deslizadores lo tenemos como una lista con dos funciones
  print(deslizadores)
  
  observeEvent(
    (deslizadores$frec_input() | deslizadores$max_input()), {
      
      callModule(module = nube,
                 id = "nube_palabras",
                 frecuencia = deslizadores$frec_input(),
                 maximo = deslizadores$max_input())  
    }

  )
}