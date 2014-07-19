read_data <- function(file) {
  read.csv("sample.csv", header = F,
           col.names = c("timestamp", "detector_id", "lane_id",
                         "speed", "volume", "occupancy"),
           stringsAsFactors = F)
}
