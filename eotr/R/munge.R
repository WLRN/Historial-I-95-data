munge_data <- function(input_data) {
  dt <- as.data.table(input_data)
  dt$timestamp <- as.POSIXct(dt$timestamp, tz = "America/New_York")
  dt$day_of_week <- factor(weekdays(dt$timestamp),
                           levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
                                      "Friday", "Saturday"))
  dt$time_of_day <- (as.numeric(format(dt$timestamp, "%H")) +
                       (as.numeric(format(dt$timestamp, "%M")) / 60) +
                         (as.numeric(format(dt$timestamp, "%S")) / 60 / 60))
  cbind(colsplit(dt$lane_id, "-",
                 names= c("detector_prefix",
                          "route",
                          "route_type",
                          "lane")),
        dt[ ,c(1:3) := rep(NULL, 3),])
}

