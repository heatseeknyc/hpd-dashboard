library(shiny)
library(leaflet)
library(plotly)
require(global.R)
options(shiny.error = browser)

fluidPage(
  
  fluidRow(
    column(width = 10,
           offset = 1,
           br(),
           img(src='hs_logo.png', width=162, height=54),
           br()
          ),
  fluidRow(
    column(width = 10,
           offset = 1,
         helpText("Built on NYC 311 heating complaint data and Heat Seek temperature sensor data")),
    column(width = 10,
           offset = 1,
           tabsetPanel(
             tabPanel("311 Complaint Data",
                      HTML("<br>"),
                      checkboxInput("exclude_unspecified", "Exclude 'Unspecified' Boroughs", TRUE),
                      checkboxInput("exclude_not_winters", "Exclude Non-Winter Months", TRUE),
                      plotOutput("bar_311_by_borough"),
                      HTML("<br>"),
                      plotOutput("bar_311_by_year"),
                      HTML("<br>"),
                      plotOutput("bar_311_by_winter")),
             tabPanel("Sensor Time Series",
                      HTML("<br>"),
                      selectizeInput(
                        inputId = 'hs_address_select',
                        label = "Select Specific Address",
                        choices = unique(df_hs$clean_address),
                        selected = c('196 ROCKAWAY PARKWAY')
                      ),
                      checkboxInput("group_by_violations", "Highlight Violations", TRUE),
                      checkboxInput("remove_outliers", "Remove Outliers", TRUE),
                      plotlyOutput("line_hs"),
                      HTML('<br>')),
             tabPanel("Sensor Map",
                      checkboxInput("remove_outliers", "Remove Outliers", TRUE),
                      checkboxInput("violations_only", "Show Violations Only", FALSE),
                      leafletOutput('map_hs', width = '100%', height=600)),
             
           )
           )
           
        )
  )
)