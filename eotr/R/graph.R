theme_fivethirtyeight_statwonk <- function(base_size = 30, base_family = "sans") {
  (theme_foundation(base_size = 30, base_family = base_family) +
     theme(line = element_line(),
           rect = element_rect(fill = ggthemes_data$fivethirtyeight["ltgray"],
                               linetype = 0, colour = NA),
           text = element_text(colour = ggthemes_data$fivethirtyeight["dkgray"]),
           axis.title = element_blank(), axis.text = element_text(),
           axis.ticks = element_blank(), axis.line.y = element_blank(),
           legend.background = element_rect(), legend.position = "top",
           legend.direction = "horizontal", legend.box = "vertical",
           legend.text = element_text(size = base_size + 15, face = "bold"),
           legend.background = element_rect(fill="gray90", size = 0.5, colour = "black"),
           panel.grid = element_line(colour = NULL),
           panel.grid.major = element_line(colour = ggthemes_data$fivethirtyeight["medgray"]),
           panel.grid.minor = element_blank(),
           plot.title = element_text(hjust = 0,
                                     size = rel(1.5), face = "bold"),
           plot.margin = unit(c(1, 5, 1, 1), "lines"),
           panel.margin = unit(6, "lines"),
           strip.text = element_text(face = "bold", size = base_size + 16),
           strip.text.y = element_text(vjust = 2)))

}
