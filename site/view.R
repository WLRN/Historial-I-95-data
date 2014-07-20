output$route_types <- renderUI({
  number_of_comparisons <- 1 + input$add_another_comparison - input$remove_another_comparison
  inputs <- lapply(1:number_of_comparisons, function(i) {
    for_each_series_for_the_type_of  <- function(x) {
      paste(x, "_comparison_order_num_", i, sep = "")
    }
    start_route_type <- isolate(input[[for_each_series_for_the_type_of("route_type")]])
    if (is.null(start_route_type)) {
      start_route_type <- "All route types"
    }
    selectInput(for_each_series_for_the_type_of("route_type"),
                "Choose route type: ",
                choices = c("All route types",
                            sort(unique(munged_data$route_type
                            ))),
                selected = start_route_type)
  })
})

output$routes <- renderUI({
  number_of_comparisons <- 1 + input$add_another_comparison - input$remove_another_comparison
  inputs <- lapply(1:number_of_comparisons, function(i) {
    for_each_series_for_the_type_of  <- function(x) {
      paste(x, "_comparison_order_num_", i, sep = "")
    }
    start_route <- isolate(input[[for_each_series_for_the_type_of("route")]])
    if (is.null(start_route)) {
      start_route <- "All routes"
    }
    selectInput(for_each_series_for_the_type_of("route"),
                "Choose route: ",
                choices = c("All routes",
                            sort(unique(munged_data$route[munged_data$route_type == input[[for_each_series_for_the_type_of("route_type")]]]
                            ))),
                selected = start_route)
  })
})

output$lanes <- renderUI({
  number_of_comparisons <- 1 + input$add_another_comparison - input$remove_another_comparison
  inputs <- lapply(1:number_of_comparisons, function(i) {
    for_each_series_for_the_type_of  <- function(x) {
      paste(x, "_comparison_order_num_", i, sep = "")
    }
    start_lane <- isolate(input[[for_each_series_for_the_type_of("lane")]])
    if (is.null(start_lane)) {
      start_lane <- "All lanes"
    }
    selectInput(for_each_series_for_the_type_of("lane"),
                "Choose lane: ",
                choices = c("All lanes",
                            sort(unique(munged_data$lane[munged_data$route == input[[for_each_series_for_the_type_of("route")]]]
                            ))),
                selected = start_lane)
  })
})

validated_data <- reactive({
  validate(
    need(length(graph_controller()$value) > 50, "Darn! Not enough data available to plot for this lane.")
  )
  graph_controller()
})

output$trafficPlot <- renderPlot({
  if(is.null(input[["lane_comparison_order_num_1"]]) |
       is.null(validated_data()))
    return()

  isolate({
    print(
      ggplot() +
        geom_smooth(data = validated_data(),
                    aes(x = time_of_day,
                        y = value,
                        colour = factor(comparison)),
                    method = "gam",
                    formula = y ~ s(x, bs = "ps")) +
        facet_grid(variable ~ ., scales = "free_y")
    )
  })
})

graph_controller <- reactive({
  if(is.null(input[["route_type_comparison_order_num_1"]]) &
       is.null(input[["route_comparison_order_num_1"]]) &
       is.null(input[["lane_comparison_order_num_1"]]) &
       input$add_another_comparison == 0 &
       input$remove_another_comparison == 0)
    return()

  isolate({
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
})

