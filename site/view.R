output$number_of_comparisons <- renderUI({
  number_of_comparisons <- 1 + input$add_another_comparison -  input$remove_another_comparison

  inputs <- lapply(1:number_of_comparisons, function(i) {
    for_each_series_for_the_type_of  <- function(x) {
      paste(x, "_comparison_order_num_", i, sep = "")
    }
    fluidRow(
      selectInput(for_each_series_for_the_type_of("route_type"),
                  "Choose route type: ",
                  choices = c("All route types",
                              sort(unique(munged_data$route_type
                              ))),
                  selected = "All route types"),
      selectInput(for_each_series_for_the_type_of("route"),
                  "Choose route: ",
                  choices = c("All routes",
                              sort(unique(munged_data$route[munged_data$route_type == input$route_type]
                              ))),
                  selected = "All routes"),
      selectInput(for_each_series_for_the_type_of("lane"),
                  "Choose lane: ",
                  choices = c("All lanes",
                              sort(unique(munged_data$lane[munged_data$route_type == input$route_type &
                                                             munged_data$route == input$route]
                              ))),
                  selected = "All lanes"),
      hr()
    )
  })
  do.call(tagList, inputs) # Put the inputs into a taglist
})

output$trafficPlot <- renderPlot({
  if(is.null(input[["route_type_comparison_order_num_1"]]))
    return()
  data_prepared_for_graphing <- tbl_df(graph_controller())

  print(
    ggplot() +
      geom_smooth(data = data_prepared_for_graphing,
                  aes(x = time_of_day,
                      y = value,
                      colour = factor(comparison)),
                  method = "gam",
                  formula = y ~ s(x, bs = "ps")) +
      facet_grid(variable ~ ., scales = "free_y")
  )
})

graph_controller <- reactive({
  if(is.null(input[["route_type_comparison_order_num_1"]]))
    return()
  number_of_comparisons <- 1 + input$add_another_comparison - input$remove_another_comparison
  for_each_series_for_the_type_of  <- function(some_type, and_row) {
    input[[paste(some_type, "_comparison_order_num_", and_row, sep = "")]]
  }
  selection_container <- list()
  data_to_show <- list()
  for(i in 1:number_of_comparisons) {
    all_input_types <- c("route_type", "route", "lane")
    selection_container[[i]] <- as.data.frame(list(comparison = i,
                                                   route_type = "",
                                                   route = "",
                                                   lane = ""),
                                              stringsAsFactors = F)
    for(each_type in all_input_types) {
      selection_container[[i]][1 , each_type] <- for_each_series_for_the_type_of(each_type, and_row = i)
    }

    indexed_for_comparison <- function(given_comparison_number, container) {
      return(show_selection_based_on(input_selection = container$route_type[[1]],
                                     item_to_test = munged_data$route_type,
                                     comparison = given_comparison_number) &
               show_selection_based_on(container$route[[1]],
                                       munged_data$route,
                                       given_comparison_number) &
               show_selection_based_on(container$lane[[1]],
                                       munged_data$lane,
                                       given_comparison_number))
    }
    data_to_show[[i]] <- munged_data[indexed_for_comparison(given_comparison_number = i,
                                                            container = selection_container[[i]])]
    data_to_show[[i]]$comparison <- i
  }
  data_to_show <- as.data.frame(rbindlist(data_to_show))
  data_to_show <- melt(data_to_show[ , c("comparison", "time_of_day", "speed", "volume", "occupancy")],
                       c("comparison", "time_of_day"))
  return(data_to_show)
})

