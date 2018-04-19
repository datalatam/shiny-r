library(shinydashboard)
library(dplyr)
library(readr)

dashboardPage( skin = "red",
        dashboardHeader(title = "Salarios C.C.S.S."),
        dashboardSidebar(
                sidebarMenu(id = "tabs",
                            menuItem("Dashboard", tabName = "dashboard",
                                     icon = icon("columns")))
        ),
        dashboardBody(
                tabItems(
                        tabItem(tabName = "dashboard",
                                fluidRow(
                                        h3("Datos"),
                                        valueBoxOutput("Profesiones",
                                                       width = 6),
                                        valueBoxOutput("SalarioMayor",
                                                       width = 6),
                                        valueBoxOutput("SalarioMenor",
                                                       width = 6)
                                ))
                )
        )
)