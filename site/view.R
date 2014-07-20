output$route_type_ui <- renderUI({
  selectInput("route_type",
              "Choose route type: ",
              choices = c("All route types",
                          sort(unique(munged_data$route_type
                          ))))
})

output$route_ui <- renderUI({
  selectInput("route",
              "Choose route: ",
              choices = c("All routes",
                          sort(unique(munged_data$route[munged_data$route_type == input$route_type]
                          ))))
})

output$lane_ui <- renderUI({
  selectInput("lane",
              "Choose lane: ",
              choices = c("All lanes",
                          sort(unique(munged_data$lane[munged_data$route_type == input$route_type &
                                                         munged_data$route == input$route]
                          ))))
})

final_selection <- reactive({
  list(route_type_to_choose = input$route_type,
       route_to_choose = input$route,
       lane_to_choose = input$lane)
})

output$trafficPlot <- renderPlot({
  if (is.null(input$route_type) |
        is.null(input$route) |
        is.null(input$lane))
    return()

  isolate({
    print(
      ggplot(munged_data[show_selection_based_on(final_selection()$route_type_to_choose,
                                                 item_to_test = munged_data$route_type) &
                           show_selection_based_on(final_selection()$route_to_choose,
                                                   item_to_test = munged_data$route) &
                           show_selection_based_on(final_selection()$lane_to_choose,
                                                   item_to_test = munged_data$lane)],
             aes(x = timestamp,
                 y = speed)) +
        geom_point(alpha = 0.2) +
        geom_smooth(method = "gam",
                    formula = y ~ s(x, bs = "ps"),
                    colour = "blue")
    )
  })
})
