output$ternary_plot <- renderPlot({
  data <- munge_data(read_data("sample.csv"))
  ggplot(d[occupancy > 1 &
             day_of_week == input$day_of_week &
             hour_of_day == input$time_of_day &
             north == if( input$direction == "North") { TRUE } else { FALSE } ],
         aes(x = occupancy,
             y = speed,
             colour = factor(express_lane))) +
    geom_jitter(alpha = 0.7) +
    stat_ellipse(level = c(0.95),
                 type = "norm",
                 size = 2) +
    stat_ellipse(level = c(0.1),
                 type = "norm",
                 size = 4) +
    coord_cartesian(ylim = c(0, 90),
                    xlim = c(0, 30)) +
    theme_fivethirtyeight(base_size = 25) +
    ylab("Speed (mph)") +
    xlab("Occupancy: % of time that the lane under the detector is full") +
    scale_y_continuous(breaks = pretty_breaks(15)) +
    scale_color_tableau(name = "", labels = c("Free lanes", "Express lanes")) +
    theme(legend.position = "top",
          axis.title = element_text(size = 18),
          axis.title.y = element_text(vjust = 1),
          plot.margin = unit(c(1,1,1,1), "cm"))
})
