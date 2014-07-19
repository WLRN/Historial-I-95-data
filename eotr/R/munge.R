munge_data <- function(input_data) {
  dt <- as.data.table(input_data)
  dt$timestamp <- as.POSIXct(dt$timestamp, tz = "America/New_York")
  cbind(dt,
        colsplit(dt$lane_id, "-",
                 names= c("detector_prefix",
                          "route",
                          "route_type",
                          "lane")))
}

