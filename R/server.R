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
  
  load("C:/Users/Quentin/Desktop/MAP536R/Shiny_projectR/data/incidents.RData")
  
  #Functions to delete after the packaging #####################################################################################
  
  build_stat_df <- function(x){
  
    if(is.null(x)){return("Appliquez des filtres")}
    
    max_no_na <- partial(max, na.rm = TRUE)
    min_no_na <- partial(min, na.rm = TRUE)
    mean_no_na <- partial(mean, na.rm = TRUE)
    var_no_na <- partial(var, na.rm = TRUE)
    
    tibble(
      min = min_no_na(x),
      mean = mean_no_na(x),
      var = var_no_na(x),
      max = max_no_na(x)
    )
  }
  
  filter_fdny <- function(df, input) {
    if(length(input$time_interval) == 0) {
      stop("A date  interval must be specified !")
    }
    filtered_df <- df %>%
      filter(inc_time >= input$time_interval[1], inc_time <= input$time_interval[2])
    if(length(input$zip_code) > 0) {
      filtered_df <- filtered_df %>%
        filter(as.character(zip_code) %in% input$zip_code)
    }
    if(length(input$type) > 0) {
      filtered_df <- filtered_df %>%
        filter(inc_type %in% input$type)
    }
    if(length(input$magnitude) > 0) {
      filtered_df <- filtered_df %>%
        filter(inc_level %in% input$magnitude)
    }
    
    return(filtered_df)
  }
  
  get_deployment_time <- function(df) {
    
    #compute column for deployment time
    deployment_time <- df %>%
      mutate(col = as.numeric(arr_time) - as.numeric(inc_time)) %>%
      dplyr::select(col)
    
    return(deployment_time)
    
  }
  
  
  get_intervention_duration <- function(df) {
    intervention_duration <- df %>%
      mutate(col = as.numeric(dep_time) - as.numeric(arr_time)) %>%
      dplyr::select(col)
    
    return(intervention_duration)
  }
  
  
  get_inteventions_per_box <- function(df) {
    
    #number interventions by day and boxes
    nb_days <- 1 + as.numeric(trunc(max(df$inc_time), units = "days") - trunc(min(df$inc_time), units = "days"))
    
    interventions_per_box <- df %>%
      group_by(fire_box) %>%
      summarise(col = n()/nb_days) %>%
      dplyr::select(col)
    
    return(interventions_per_box)
  }
  
  
  get_nb_units <- function(df){
    
    #get number of units
    nb_units <- df %>%
      dplyr::select(units) %>%
      rename(col = units)
    
    return(nb_units)
    
  }
  
  
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
    
    n_per_type <- filtered_df %>% group_by(inc_type) %>% summarize(n = n())
    
    output <- list()
    output$filtered_df <- filtered_df
    output$statistic_df <- stat_df
    output$number_intervention_per_type <- n_per_type
    return(output)
  }
  
  #End functions to delete after packaging ######################################################################################
 
  
  #Set the choices for the user
  updateSelectInput(session = session,
                    inputId = "fireboxSelect",
                    choices = tidy_incidents %>% 
                      dplyr::select(fire_box) %>% 
                      distinct(fire_box) %>% 
                      arrange(fire_box)
  )   
  
  updateSelectInput(session = session,
                    inputId = "type",
                    choices = tidy_incidents %>% 
                      dplyr::select(inc_type) %>% 
                      distinct(inc_type) %>% 
                      arrange(inc_type)
  )   
  
  updateSelectInput(session = session,
                    inputId = "zip_code",
                    choices = tidy_incidents %>% 
                      dplyr::select(zip_code) %>% 
                      distinct(zip_code) %>% 
                      arrange(zip_code)
  )   
  
  updateSelectInput(session = session,
                    inputId = "magnitude",
                    choices = tidy_incidents %>% 
                      dplyr::select(inc_level) %>% 
                      distinct(inc_level) %>% 
                      arrange(inc_level)
  )   
  
  
  #Run the functions on the data 
  res <- reactive({statistic_fdny(tidy_incidents, input)})
  
  output$plot1 <- renderDataTable({
    res()$filtered_df 
  })
  
  output$plot2 <- renderDataTable({
    res()$stat_df
  })
  
  output$plot3 <- renderDataTable({
    res()$n_per_type
  })
  
  
  
  #### MAP HENRI #################################################################################################################
  
  library("sf")
  library("raster")
  library("tidyverse")
  library("rgdal")
  library("xml2")
  library("stringr")
  library("tmap")
  
  nyfc <- st_read(dsn = "C:/Users/Quentin/Desktop/MAP536R/Shiny_projectR/data/nyfc",
                  layer = "nyfc",
                  quiet = TRUE)
  
  nyfc_firebox <- st_read(dsn = "C:/Users/Quentin/Desktop/MAP536R/Shiny_projectR/data/firebox.kml",
                          layer = "Fire_Boxes.csv",
                          quiet = TRUE)
  
  plot_firebox <- function(x){
    if (str_sub(x,1,1) %in% c("B", "M", "Q", "R", "X") && str_length(x) == 5){
      tm_shape(nyfc_firebox %>% filter(Name %in% x)) +
        tm_bubbles() +
        tm_shape(nyfc) +
        tm_borders()
    }
    else {
      "Please enter a correct firebox number."
    }
  }
  
  output$fire_map <- renderLeaflet({
    plot_firebox(input$fireboxSelect)
  })

  
  
  
  
  
  
  
  
  
  
  
  
  
  
})
