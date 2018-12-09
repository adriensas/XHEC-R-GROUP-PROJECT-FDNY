#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  library(tidyverse)
  library(ggplot2)
  
  #Import of the tidy data
  #load("C:/Users/Quentin/Desktop/projetR/shinyApp/FireHelp/data/incidents.RData")
  
  #Original data for layout - To delete
  incidents <- read.csv('C:/Users/Quentin/Desktop/projetR/shinyApp/FireHelp/data/incidents.csv')
  
  
  
  #Functions Package (A MODIFIER SI LES FONCTIONS SONT CHARGEES AVEC LE PACKAGE) ########################
  
  #' Apply the filter to the main data frame
 
  filter_fdny <- function(df, input) {
    if(length(input$time_interval) == 0) {
      stop("A date  interval must be specified !")
    }
    filtered_df <- df %>%
      filter(INCIDENT_DATE_TIME >= input$time_interval[1], INCIDENT_DATE_TIME <= input$time_interval[2])
    if(length(input$zip_code) > 0) {
      filtered_df <- filtered_df %>%
        filter(as.character(ZIP_CODE) %in% input$zip_code)
    }
    if(length(input$type) > 0) {
      filtered_df <- filtered_df %>%
        filter(INCIDENT_TYPE_DESC %in% input$type)
    }
    if(length(input$magnitude) > 0) {
      filtered_df <- filtered_df %>%
        filter(INCIDENT_TYPE_DESC %in% input$magnitude)
    }
    
    return(filtered_df)
  }
  
  
  #take a data frame as input and return a 1 column data frame of the deployment time for each intervention
  get_deployment_time <- function(df) {
    
    #compute column for deployment time
    deployment_time <- df %>%
      mutate(col = as.numeric(ARRIVAL_DATE_TIME) - as.numeric(INCIDENT_DATE_TIME)) %>%
      select(col)
    
    return(deployment_time)
    
  }
  
  
  get_intervention_duration <- function(df) {
    intervention_duration <- df %>%
      mutate(col = as.numeric(LAST_UNIT_CLEARED_DATE_TIME) - as.numeric(ARRIVAL_DATE_TIME)) %>%
      select(col)
    
    return(intervention_duration)
  }
  
  
  get_inteventions_per_box <- function(df) {
    
    #number interventions by day and boxes
    nb_days <- 1 + as.numeric(trunc(max(df$INCIDENT_DATE_TIME), units = "days") - trunc(min(df$INCIDENT_DATE_TIME), units = "days"))
    
    interventions_per_box <- df %>%
      group_by(FIRE_BOX) %>%
      summarise(col = n()/nb_days) %>%
      select(col)
    
    return(interventions_per_box)
  }
  
  
  get_nb_units <- function(df){
    
    #get number of units
    nb_units <- df %>%
      select(UNITS_ONSCENE) %>%
      rename(col = UNITS_ONSCENE)
    
    return(nb_units)
    
  }
  
  # End Functions Package ##############################################################################
  
  
  # Fonction mère ##############################################################################
  
  statistic_fdny <- function(df, input){
    
    #call filter function to go from raw data to filtered data
    filtered_df <- filter_fdny(df, input)
    
    #create list of each element we want
    elements1 <- list(
      get_deployment_time(filtered_df),
      get_inteventions_per_box(filtered_df),
      get_nb_units(filtered_df),
      get_intervention_duration(filtered_df)
    )
    
    #extract col from each element of the list
    elements2 <- map(elements1, "col") %>%
      set_names(c("dep_time", "interv_per_box", "nb_units", "interv_duration"))
    
    
    stat_df <- map_dfr(elements2, build_stat_df, .id = "statistic")
    
    n_per_type <- filtered_df %>% group_by(INCIDENT_TYPE_DESC) %>% summarize(n = n())
    
    output <- list()
    output$filtered_df <- filtered_df
    output$statistic_df <- stat_df
    output$number_intervention_per_type <- n_per_type
    return(output)
  }
  
  # End Fonction mère ##############################################################################
  
  
  
  
  
  updateSelectInput(session = session,
                    inputId = "fireboxSelect",
                    choices = incidents %>% 
                      select(FIRE_BOX) %>% 
                      distinct(FIRE_BOX) %>% 
                      arrange(FIRE_BOX)
  )   
  
  updateSelectInput(session = session,
                    inputId = "type",
                    choices = incidents %>% 
                      select(INCIDENT_TYPE_DESC) %>% 
                      distinct(INCIDENT_TYPE_DESC) %>% 
                      arrange(INCIDENT_TYPE_DESC)
  )   
  
  updateSelectInput(session = session,
                    inputId = "zip_code",
                    choices = incidents %>% 
                      select(ZIP_CODE) %>% 
                      distinct(ZIP_CODE) %>% 
                      arrange(ZIP_CODE)
  )   
  
  
  output$data <- renderDataTable({
    incidents %>% head(100)
  })
  
  stat <- statistic_fdny(incidents, input)
  
  output$filtered_data <- renderDataTable({
    stat$filtered_df
  })
 
})
