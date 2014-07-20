library(shiny)
library(eotr)

show_selection_based_on <- function(input_selection, item_to_test, comparison) {
  if (grepl("All ", input_selection)) {
    return(rep(comparison, length(item_to_test)))
  } else {
    return(ifelse(item_to_test %in% input_selection,
                  comparison, NA))
  }
}

shinyServer(function(session, input, output) {
  load("site_data.rda")

  source("view.R", local = T)
})
