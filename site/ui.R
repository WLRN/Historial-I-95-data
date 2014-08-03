require(shiny)
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
                  selected = "South"),
      selectInput("color_scheme", label = "Color scheme",
                  choices = c("Red", "Green", "Blue", "Orange", "Gray", "Red Light", "Green Light", "Blue Light", "Orange Light", "Area Red", "Area Green", "Area Brown", "Blue-Green Sequential", "Brown Sequential", "Purple Sequential", "Grey Sequential"),
                  selected = "Red"),
      width = 2),
    mainPanel(
      plotOutput("jam_probability")
    )
  )
))
