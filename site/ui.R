library(shiny)
shinyUI(fluidPage(
  titlePanel("End of the Road"),
  sidebarLayout(
    sidebarPanel(
      uiOutput("route_type_ui"),
      uiOutput("route_ui"),
      uiOutput("lane_ui")
    ),
    mainPanel(
      plotOutput("trafficPlot")
    )
  )
))
