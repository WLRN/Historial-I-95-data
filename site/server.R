require(shiny)
require(eotr)
require(data.table)

# store_data(munge_data(read_data("sample.csv")))
shinyServer(function(session, input, output) {
  load("site_data.rda")
  source("view.R", local = T)
})
