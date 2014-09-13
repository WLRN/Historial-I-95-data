require(shiny)
require(eotr)
require(data.table)
require(ggplot2); require(ggthemes)
shinyServer(function(session, input, output) {
  load("site_data.rda")
  source("jams.R", local = T)
})
