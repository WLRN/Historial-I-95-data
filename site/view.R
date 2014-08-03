output$jam_probability <- renderPlot({
  if(is.null(input$day_of_week) |
       is.null(input$time_of_day) |
       is.null(input$direction) |
       is.null(input$color_scheme))
    return()
  input_data <- subset(munged_data,
                       day_of_week == input$day_of_week &
                         hour_of_day == input$time_of_day &
                         north == ifelse(input$direction == "North", T, F),
                       c("speed", "express_lane"))
  input_data$bin <- ifelse(input_data$speed < 20, "lt_20",
                           ifelse(input_data$speed < 55, "gt_20_lt_55", "gt_55"))
  ggplot((d <- data.frame(round(prop.table(xtabs(speed ~ .,
                                                 data = input_data),
                                           1) * 100, 0), stringsAsFactors = F)),
         aes(x = factor(bin, levels = c("lt_20", "gt_20_lt_55", "gt_55")),
             y = factor(express_lane, levels = c(T, F)),
             label = paste(Freq, "%", sep = ""))) +
    scale_y_discrete(labels = c("Express lanes", "Free lanes")) +
    scale_x_discrete(labels = c("Less than\n20 MPH",
                                "20 - 55 MPH",
                                "55+ MPH")) +
    xlab("") +
    ylab("") +
    geom_tile(aes(fill = Freq), colour = "black", size = 2) +
    geom_text(size = 30) +
    facet_grid(express_lane ~ ., scales = "free") +
    scale_fill_gradient_tableau(input$color_scheme) +
    theme_fivethirtyeight(base_size = 30) +
    theme(legend.position = "none",
          strip.text = element_blank()) +
    ggtitle("Interstate 95 speed measurements\nby lanes (2010-2014)\n")
}, res = 54)
