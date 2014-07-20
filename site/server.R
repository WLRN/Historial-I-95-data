library(shiny)
library(eotr)
shinyServer(function(session, input, output) {
  load("site_data.rda")

  source("view.R", local = T)
})
