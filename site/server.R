require(shiny)
require(eotr)
require(data.table)

# store_data(munge_data(read_data("sample.csv")))
load("site_data.rda")
shinyServer(function(session, input, output) {
  source("view.R", local = T)
})
