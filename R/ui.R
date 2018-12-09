#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  navbarPage("FireHelp",
    
    tabPanel("Project"),
    
    tabPanel("App",
             
             sidebarLayout(
               
               sidebarPanel(
                 
                 dateRangeInput("time_interval",
                                label = "Time Interval",
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
                             choices = NULL)
                 
               ),
               
               mainPanel(
                 
                 tabsetPanel(
                   
                   tabPanel("Plot1"),
                   
                   tabPanel("Plot2",
                            
                            dataTableOutput("filtered_data")
                            
                            ),
                   
                   tabPanel("Plot3")
                   
                 ) 
                 
               )
               
             )
             
             ),
    
    tabPanel("Data",
             
             dataTableOutput("data")
             
             ),
    
    tabPanel("Authors")
  )
  
 
  
))
