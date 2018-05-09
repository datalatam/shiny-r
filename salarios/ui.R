library(shinydashboard)
library(dplyr)
library(readr)
library(ggplot2)
library(lucr)

dashboardPage(
        skin = "red",
        dashboardHeader(title = "Salarios C.C.S.S."),
        dashboardSidebar(sidebarMenu(
                id = "tabs",
                menuItem("Dashboard", tabName = "dashboard",
                         icon = icon("columns")),
                menuItem(
                        "Gráficos",
                        tabName = "Graficos",
                        icon = icon("bar-chart-o"),
                        menuSubItem("Espacio completo", tabName = "completo"),
                        menuSubItem("Espacio dividido", tabName = "dividido")
                ),
                menuItem("Cuadros", tabName = "Cuadros",
                         icon = icon("list"))
        )),
        dashboardBody(tabItems(
                tabItem(
                        tabName = "dashboard",
                        fluidRow(
                                h3("Datos"),
                                valueBoxOutput("Profesiones",
                                               width = 6),
                                valueBoxOutput("SalarioMayor",
                                               width = 6),
                                valueBoxOutput("SalarioMenor",
                                               width = 6)
                        )
                ),
                
                tabItem(tabName = "completo",
                        fluidPage(
                                h3("Distribuciones Salarios por Profesión"),
                                box(plotOutput("biologos"),
                                    width = 12)
                        ),
                        fluidPage(
                                box(
                                        title = "Promedio salarios por profesión",
                                        plotOutput("salarios_totales"),
                                        width = 12
                                )
                        )),
                
                tabItem(tabName = "dividido",
                        fluidPage(
                                h3("Distribuciones salariales"),
                                box(plotOutput("cantidad_profesion")),
                                box(plotOutput("auxiliares_enfermeria"))
                        )),
                
                tabItem(tabName = "Cuadros",
                        fluidRow(
                                h3("Profesiones por segmentos de salarios"),
                                box(
                                        title = "Profesiones menor pagadas",
                                        solidHeader = TRUE,
                                        DT::dataTableOutput("menor_pagagas"),
                                        width = 12
                                )
                        ))
        ))
)