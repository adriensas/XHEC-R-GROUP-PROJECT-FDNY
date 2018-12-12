#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(leaflet)

# Define UI for application that draws a histogram
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
                            choices = NULL)
              ),
              
              box(
                title = "Map Filters",
                status = "info",
                width = NULL,
                collapsible = TRUE,
                
                checkboxInput("heatbox",
                              label = "heatbox1",
                              value = FALSE)
                
              )
              
              
            ),
            
            #column(
              
              tabBox(
                width = 9,
                title = "NY Firemen data visualisation",
                tabPanel("Maps", icon = icon("globe"),
                         
                         leafletOutput("fire_map")
                         
                ),
                
                tabPanel("Statistics", icon = icon("bar-chart"),
                         
                         dataTableOutput("plot3")
                         
                ),
                
                tabPanel("Data", icon = icon("book"),
                         
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
