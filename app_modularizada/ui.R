# ui

library(shiny)

# Encabezado --------------------------------------------------------------

header <- dashboardHeader(
  title = "Wordcloud"
)

# Sidebar -----------------------------------------------------------------

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Nube de palabras", tabName = "nube", icon = icon("dashboard")),
    menuItem("Texto", tabName = "texto", icon = icon("align-left"))
  )
)

# Cuerpo ------------------------------------------------------------------
body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "nube",
      fluidRow(
        # box(
          nubeUI("nube_palabras")
        # )
      ),
      
      fluidRow(
        box(
          deslizadorUI("deslizador_nuevo")
        )
      )
    )
  )
)

## App completo ----------------------------------------------------------------
dashboardPage(
  skin = "black",
  header,
  sidebar,
  body
)