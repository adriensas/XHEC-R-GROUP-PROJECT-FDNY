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
          icon = icon("fire-extinguisher"),
          menuSubItem("data1", tabName = "app_tab1", icon = icon("bar-chart")),
          menuSubItem("data2", tabName = "app_tab2", icon = icon("bar-chart"))
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
          
          tabName = "app_tab1",
          h2("NY Firemen data visualisation"),
          fluidRow(
            
            box(
              title = "Filters",
              width = 3,
              collapsible = TRUE,
              dateRangeInput("time_interval",
                             label="Time Interval",
                             language = "en-GB"),
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
            
            tabBox(
              title = "Data to plot",
              width = 9,
              tabPanel("Plot1",
                       
                       dataTableOutput("plot1")
                       
                       ),
              
              tabPanel("Plot2",
                       
                       dataTableOutput("plot2")
                       
                       ),
              
              tabPanel("Plot3",
                       
                       dataTableOutput("plot3")
                       
                       )
            )
          )
        )
      )
    )
  )
  
))
