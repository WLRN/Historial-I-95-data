library(shiny)
shinyUI(fluidPage(
  titlePanel("End of the Road"),
  sidebarLayout(
    sidebarPanel(
      uiOutput("number_of_comparisons"),
      actionLink("add_another_comparison", "Add ..."),
      actionLink("remove_another_comparison", "Remove ...")
    ),
    mainPanel(
      plotOutput("trafficPlot")
    )
  )
))
