munge_data <- function(input_data) {
  d <- data.table(input_data)
  d$day_of_week <- factor(weekdays(d$timestamp <- as.POSIXct(d$timestamp, tz = "UTC", origin = "1970-01-01")),
                          levels = c("Sunday", "Monday", "Tuesday",
                                     "Wednesday", "Thursday",
                                     "Friday", "Saturday"))

  trim.leading <- function (x)  sub("^\\s+", "", x)
  d$hour_of_day <- trim.leading(as.character(format(d$timestamp, "%l %p")))

  d$north <- grepl("N", d$detector_id)
  d$express_lane <- (grepl("EL", d$lane_id) | grepl("ML", d$lane_id))
  d[grep("DS-00", d$detector_id), c("day_of_week",
                                    "hour_of_day",
                                    "north",
                                    "express_lane",
                                    "speed",
                                    "occupancy",
                                    "volume")]
}

