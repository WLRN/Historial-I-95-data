require(shiny)
require(eotr)
require(data.table)
require(ggplot2); require(ggthemes); require(ggtern)
shinyServer(function(session, input, output) {
  source("ternary.R", local = T)
})
