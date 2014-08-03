require(shiny)
# Inputs:
# - day of week
# - time of day
# - direction
#
# Outputs:
# - probability of slow (0-20), medium (20 - 50), fast (50+)

shinyUI(fluidPage(
  titlePanel("End of the Road"),
  sidebarLayout(
    sidebarPanel(
      selectInput("day_of_week", label = "Select day",
                  choices = c("Sunday",
                              "Monday",
                              "Tuesday",
                              "Wednesday",
                              "Thursday",
                              "Friday",
                              "Saturday"),
                  selected = "Monday"),
      selectInput("time_of_day", label = "Hour of departure",
                  choices = paste(c(12, 1:11), c(rep("AM", 12), rep("PM", 12))),
                  selected = "8 AM"),
      selectInput("direction", label = "Direction",
                  choices = c("North", "South"),
                  selected = "South")
    ),
    mainPanel(
      fluidRow(
        plotOutput("jam_probability")
      )
    )
  )
))
