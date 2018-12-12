#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

server <- function(input, output, session) {
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

    updateSelectInput(session = session,
                      inputId = "district",
                      choices = tidy_incidents %>%
                        dplyr::select(borough) %>%
                        distinct(borough) %>%
                        arrange(borough)
    )


    #Run the functions on the data
    res <- reactive({statistic_fdny(tidy_incidents, input)})
    map_data_df <- reactive({compute_map_df(res()$filtered_df)})
    output$plot1 <- renderDataTable({
      print(res())
      res()$filtered_df
    })

    output$plot2 <- renderDataTable({
      res()$statistic_df
    })

    output$plot3 <- renderDataTable({
      res()$number_intervention_per_type
    })
    output$fire_map <- renderLeaflet({
      plot_leaflet_map(map_data_df(), input)
    })
}
