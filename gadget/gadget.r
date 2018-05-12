library(shiny)
library(miniUI)
library(dplyr)
library(ggplot2)

explora_salarios <- function(datos) {

  ui <- miniPage(
    gadgetTitleBar("Explorador de salarios",
                   right = miniTitleBarButton("done", "Listo", primary = TRUE)
                   ),
        miniContentPanel(
          fillCol(flex = c(NA, 1),
            sliderInput(inputId = "numero_ocps", "Numero Ocupaciones",
                        min = 1, max = 60,
                        value = 10, step = 1),
            plotOutput("salarios", height = "100%")
      )
    )
  )

  server <- function(input, output, session) {

    top_descripciones <- datos %>%
      group_by(OCUPACION) %>%
      summarize(salario_promedio = mean(SALARIO, na.rm = TRUE)) %>%
      arrange(desc(salario_promedio))

    output$salarios <- renderPlot({


      top_descripciones <- head(top_descripciones, input$numero_ocps)

      plot <- ggplot(data = top_descripciones, aes(x = as.factor(OCUPACION),
                  color = OCUPACION, y = salario_promedio)) +
        geom_point() +
        theme(legend.position = "none") +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))

      return(plot)

    })

    observeEvent(input$done, {
      stopApp(TRUE)
    })
  }

runGadget(shinyApp(ui, server), viewer = paneViewer())

}
