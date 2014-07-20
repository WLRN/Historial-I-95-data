show_selection_based_on <- function(input_selection, item_to_test) {
  ifelse(grepl("All ", input_selection),
         rep(TRUE, length(item_to_test)),
         item_to_test %in% input_selection)
}

output$route_type_ui <- renderUI({
  selectInput("route_type",
              "Choose route type: ",
              choices = c("All route types", sort(unique(munged_data$route_type))),
              selected = "All route types")
}); selected_route_type <- reactive({ input$route_type })

output$route_ui <- renderUI({
  selectInput("route",
              "Choose route: ",
              choices = c("All routes",
                          sort(unique(
                            munged_data[show_selection_based_on(selected_route_type(), route)]$route
                          ))),
              selected = "All routes")
}); selected_route <- reactive({ input$route })

output$lane_ui <- renderUI({
  selectInput("lane",
              "Choose lane: ",
              choices = c("All lanes",
                          sort(unique(munged_data[show_selection_based_on(selected_route_type(), route_type) &
                                                  show_selection_based_on(selected_route(), route)]$lane
                          ))),
selected = "All lanes")
}); selected_lane <- reactive({ input$lane })

output$trafficPlot <- renderPlot({
  print(
    ggplot(munged_data[show_selection_based_on(selected_route_type(), item_to_test = route_type) &
                         show_selection_based_on(selected_route(), item_to_test = route) &
                         show_selection_based_on(selected_lane(), item_to_test = lane)],
           aes(x = timestamp,
               y = speed)) +
      geom_point(alpha = 0.2) +
      geom_smooth(method = "gam",
                  formula = y ~ s(x, bs = "ps"),
                  colour = "blue")
  )
})
