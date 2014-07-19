devtools::load_all("eotr")
df <- read.csv("sample.csv", header = F,
               col.names = c("timestamp", "detector_id", "lane_id",
                             "speed", "volume", "occupancy"),
               stringsAsFactors = F)
dt <- as.data.table(df)
dt <- cbind(dt,
            colsplit(dt$lane_id, "-",
                     names=c("detector_prefix", "route", "route_type", "lane"))
            )
dt$timestamp <- as.POSIXct(dt$timestamp, tz = "America/New_York")

ggplot(dt[route_type == "EL"], aes(x = timestamp,
               y = speed)) +
 geom_point(alpha = 0.2) +
 geom_smooth(method = "gam",
             formula = y ~ s(x, bs = "ps"),
             colour = "blue")

