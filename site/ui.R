require(shiny);
shinyUI(
  fluidPage(id = "eotr-page",
            div(id = "title-header",
                icon("road", class = "fa-5x"),
                h1("End of the Road I-95")
            ),
            tags$head(
              tags$link(rel = "stylesheet", type = "text/css", href = "css/header.css")
            ),
            hr(),
            div(id = "selectors",
                fluidRow(
                  column(2,
                         selectInput("day_of_week", label = "Select day",
                                     choices = c("Sunday",
                                                 "Monday",
                                                 "Tuesday",
                                                 "Wednesday",
                                                 "Thursday",
                                                 "Friday",
                                                 "Saturday"),
                                     selected = "Monday")
                  ),
                  column(3,
                         selectInput("time_of_day", label = "Hour of departure",
                                     choices = paste(c(12, 1:11), c(rep("AM", 12), rep("PM", 12))),
                                     selected = "8 AM")
                  ),
                  column(2,
                         selectInput("direction", label = "Direction",
                                     choices = c("North", "South"),
                                     selected = "South")
                  )
                )
            ), hr(),
            tabsetPanel(
              tabPanel("Jam Probability",
                       plotOutput("jam_probability")
              )
            )
  )
)
