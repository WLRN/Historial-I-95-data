require(shiny); require(rCharts);
shinyUI(fluidPage(
  titlePanel("End of the Road"),
  sidebarLayout(
    sidebarPanel(
      uiOutput("comparison_selections"),
      hr(),
      actionLink("add_another_comparison", "Add ..."),
      actionLink("remove_another_comparison", "Remove ..."),
      width = 3),
    mainPanel(
      fluidRow(
        showOutput("speedPlot", "nvd3")
      ),
      fluidRow(
        showOutput("volumeOccupancyPlot", "nvd3")
      )
    )
  )
))
