#' The Shiny app server
#'
#' @import shiny shinydashboard
#'
#' @return shiny app server
#' @export
#' @rdname ui

ui <- function() {
  shinyUI(fluidPage(

    dashboardPage(
      dashboardHeader(title="FireHelp"),
      dashboardSidebar(
        sidebarMenu(
          menuItem(
            "Project",
            tabName = "project",
            icon = icon("mortar-board")
          ),
          menuItem(
            "App",
            tabName = "app",
            icon = icon("fire-extinguisher")
          ),
          menuItem(
            "Authors",
            tabName = "authors",
            icon = icon("users")
          )
        )
      ),
      dashboardBody(
        tabItems(
          tabItem(

            tabName = "app",
            fluidRow(

              column(
                width = 3,

                box(
                  title = "Incidents Filters",
                  status = "info",
                  width = NULL,
                  collapsible = TRUE,

                  dateRangeInput("time_interval",
                                 start = '2014-01-01',
                                 end = '2014-02-01',
                                 label="Time Interval",
                                 language = "en-GB"),

                  selectInput("district",
                              label = "District",
                              multiple = TRUE,
                              choices = NULL),

                  selectInput("fireboxSelect",
                              label = "FireBox",
                              multiple = TRUE,
                              choices = NULL),

                  selectInput("type",
                              label = "Incident Type",
                              multiple = TRUE,
                              choices = NULL),

                  selectInput("zip_code",
                              label = "Incident Zip Code",
                              multiple = TRUE,
                              choices = NULL),

                  selectInput("magnitude",
                              label = "Incident Magnitude",
                              multiple = TRUE,
                              choices = NULL),

                  sliderInput("time_period",
                              label = "Period of the day",
                              min = 0,
                              max = 24,
                              value = c(0, 24))
                ),

                box(
                  title = "Map Filters",
                  status = "info",
                  width = NULL,
                  collapsible = TRUE,

                  selectInput("map_info",
                              selected = "n",
                              selectize = TRUE,
                              label = "Information to display",
                              multiple = FALSE,
                              choices = c("Number of Intervention", "Mean Intervention Duration", "Mean Number of Units", "Fire Box Map"))

                )


              ),

              #column(

              tabBox(
                width = 9,
                title = "NY Firemen data visualisation",
                tabPanel("Maps",
                  icon = icon("globe"),
                  leafletOutput("fire_map")
                ),

                tabPanel("Statistics",
                  icon = icon("bar-chart"),
                  dataTableOutput("plot3"),
                  dataTableOutput("plot2")
                ),

                tabPanel("Data",
                  icon = icon("book"),
                  dataTableOutput("plot1")

                )


              )

              #)
            )
          )
        )
      )
    )

  ))
}
