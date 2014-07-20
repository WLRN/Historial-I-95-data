library(shiny)
shinyUI(fluidPage(
  titlePanel("End of the Road"),
  sidebarLayout(
    sidebarPanel(
      uiOutput("route_types"),
      uiOutput("routes"),
      uiOutput("lanes"),
      hr(),
      actionLink("add_another_comparison", "Add ..."),
      actionLink("remove_another_comparison", "Remove ...")
    ),
    mainPanel(
      plotOutput("trafficPlot")
    )
  )
))
