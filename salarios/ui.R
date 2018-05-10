library(shinydashboard)
library(dplyr)
library(readr)
library(ggplot2)
library(lucr)

dashboardPage(
  skin = "red",
  dashboardHeader(title = "Salarios C.C.S.S."),
  
  # Definimos el sidebar menu
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
  # Definimos el body del dashboard
  dashboardBody(tabItems(
    
    tabItem(tabName = "dashboard",
            fluidRow(
              h1("Datos"),
              valueBoxOutput("Profesiones",
                             width = 6)
              ),
            
            fluidRow(
              valueBoxOutput("SalarioMayor", width = 6),
              valueBoxOutput("SalarioMenor", width = 6)
              )
            ),
    
    tabItem(tabName = "completo",
            fluidPage(
              h3("Distribuciones Profesiones mejor pagadas"),
              box(plotOutput("salarios_mayores"),
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





