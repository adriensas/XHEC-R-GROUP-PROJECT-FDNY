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
          ),
          tabItem(
            tabName = "project",
            h1("FireHelp"),
            h2("Origin of the Project"),
            p("The firemen of the BSPP (Paris Fire Department) perform over 500,000 interventions each year. Each and every one of them generates an incident report, which contain much information about the date, time, victim, response..."),
            p("According to CDT Mathieu, a superior officer from BSPP, their is a real need for advanced analytical tools. In order to report on the interventions, increase the efficiency of a fire company or ask for additional means, statistics have to be computed and presented to the relevant authorities. Today, those calculations are done manually"),
            p("FireHelp provides a comprehensive tool for data analysis of the interventions of a fire department, by harnessing various capabilities of the R programming language like interactive maps or reactive programming."),
            p("In its current version, FireHelp analyzes the data provided by the New-York City Fire Department (NYFD). However, military officers from the BSPP have already expressed their interest in the project and will give us access to their data to make FireHelp available in Paris."),
            h2("The Application"),
            p("FireHelp comes in the form of a package containing a Shiny App. It allows the user to perform various analyses of the interventions of the FDNY, and to rapidly visualize the results."),
            p("Through a variety of filters, the user can select the relevant interventions and areas of interest among the application's dataset (which contains all the interventions of the FDNY between January 1st, 2013 to January 1st, 2018). Once the user has defined the appropriate scope for its study, the application computes relevant summary statistics, which are then made available to the user in two main formats. First, the application allows the user to access a table containing the statistics calculated by the app. Second, the user has access to an interactive map of the city, on which he can plot those statistics."),
            p("Through its interactive and user-friendly interface, this application can simplify largely the work of superior officers of the Fire Department of a given city, allowing them to perform hours of manual data analyses in a matter of minutes, without having to learn anything about programming languages such as R.")
          )
        )
      )
    )

  ))
}
