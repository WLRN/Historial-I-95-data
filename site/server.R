library(shiny)
library(eotr)

show_selection_based_on <- function(input_selection, item_to_test) {
  if (grepl("All ", input_selection)) {
    return(rep(TRUE, length(item_to_test)))
  } else {
    return(item_to_test %in% input_selection)
  }
}

shinyServer(function(session, input, output) {
  load("site_data.rda")

  source("view.R", local = T)
})
