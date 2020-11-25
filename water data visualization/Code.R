library(shinythemes)
library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)
library(htmltools)
library(geojsonio)

# setwd('~/ZilongZheng_29499496_Code/')
ui<-navbarPage(
                'the relationship between weather and car accident',
                tabPanel('car accident', fluidPage(theme = shinytheme('flatly')),
                         tags$head(
                           tags$style(HTML('.shiny-output-error-validation{color: read;}'))),
                         pageWithSidebar(
                           headerPanel('year'),
                           sidebarPanel(width = 4,
                                        selectInput("Year", "Year", 
                                                    choices = c(2008,2009,2010,2011,2012,2013,2014,2015,2016,2017))),
                           mainPanel(column(6,leafletOutput('ausmap', width = 550, height = 700)))
                                        )
                         ),
                tabPanel('weather line chart', fluidPage(theme = shinytheme('flatly')),
                         tags$head(
                           tags$style(HTML('.shiny-output-error-validation{color:read;}'))),
                         pageWithSidebar(
                           headerPanel('weather line chart'),
                           sidebarPanel(width = 4,
                                        selectInput("Factor", "weather factor:", 
                                                    choices = c("MaxTemp" ,"Humidity_mean", "Pressure_mean", "Rainfall", 'WindGustSpeed')),
                                        checkboxGroupInput("state", 'state names:',
                                                           choices = c('NSW','Vic','Qld', 'SA', 'WA','Tas','NT','ACT'),
                                                           selected = 'Vic')),
                           mainPanel(column(6,
                                            plotOutput('linechart',width = 550, height = 700)))
                         )
                         ),
                tabPanel('car accident & weather', fluidPage(theme = shinytheme('flatly')),
                         tags$head(
                           tags$style(HTML('.shiny-output-error-validation{color:read;}'))),
                         pageWithSidebar(
                           headerPanel('the relation between weather factor and car accident'),
                           sidebarPanel(width = 4,
                                        selectInput("state_2", 'state names:',
                                                    choices = c('NSW','Vic','Qld', 'SA', 'WA','Tas','NT','ACT')),
                                        selectInput("Factor_2", "weather factor:", 
                                                    choices = c("MaxTemp" ,"Humidity_mean", "Pressure_mean", "Rainfall", 'WindGustSpeed'))),
                           mainPanel(column(6,
                                     plotOutput('plotchart',width = 550, height = 700)))
                         )
                         )
                         )
                        




sever<-function(input,output){
  crash_data<-read.csv('crashes_data_mean.csv')
  weather_data<-read.csv('weather_data_mean.csv')
  map_1<-geojsonio::geojson_read('au-states.geojson',what = 'sp')
  output$ausmap<-renderLeaflet({
    crash_data_input_year<-subset(crash_data,crash_data$Year == input$Year)
    crash_data_input_year<-crash_data_input_year[order(match(crash_data_input_year$State, c('NSW','Vic','Qld', 'SA', 'WA','Tas','NT','ACT'))),]
    bin<-c(0,50,100,150,200,250,300,400,500,600,700)
    pal<-colorBin('YlOrRd', domain = crash_data_input_year$Number.Fatalities, bins = bin)
    labels<-paste('<p>', crash_data_input_year$State, '</p>',
                  '<p>', 'the number of crash:', round(crash_data_input_year$Number.Fatalities, digits = 3), '</p>',
                  sep = '')
    leaflet()%>%
      addPolygons(data = map_1,
                  weight =1,
                  smoothFactor = 0.5,
                  color = 'white',
                  fillOpacity = 0.8,
                  fillColor = pal(crash_data_input_year$Number.Fatalities),
                  highlight=highlightOptions(
                    weight = 5,
                    color = '#666666',
                    fillOpacity = 0.7,
                    bringToFront = TRUE
                  ),
                  label = lapply(labels, HTML))%>%
      addLegend(pal= pal, 
                values = crash_data_input_year$Number.Fatalities, 
                opacity = 0.7,
                position = 'topright')
  })
  output$loca<-renderText({paste('the liner chart of weather')})
  output$linechart<-renderPlot({ state<-input$state
  weather_data_input<-weather_data[(weather_data$state %in% state),]
  weather_data_input<-weather_data_input[(weather_data_input$year %in% c(2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018)),]
  if (input$Factor == 'MaxTemp'){
    ggplot(weather_data_input,aes(x = year, y = MaxTemp, color = state))+
      geom_line()+
      geom_point()+
      scale_x_continuous(breaks = c(2008,2010,2012,2014,2016,2018))
  }
  else if (input$Factor == 'Humidity_mean'){
    ggplot(weather_data_input,aes(x = year, y = Humidity_mean, color = state))+
      geom_line()+
      geom_point()+
      scale_x_continuous(breaks = c(2008,2010,2012,2014,2016,2018))
  }
  else if (input$Factor == 'Pressure_mean'){
    ggplot(weather_data_input,aes(x = year, y = Pressure_mean, color = state))+
      geom_line()+
      geom_point()+
      scale_x_continuous(breaks = c(2008,2010,2012,2014,2016,2018))
  }
  else if (input$Factor == 'Rainfall'){
    ggplot(weather_data_input,aes(x = year, y = Rainfall, color = state))+
      geom_line()+
      geom_point()+
      scale_x_continuous(breaks = c(2008,2010,2012,2014,2016,2018))
  }
  else if (input$Factor == 'WindGustSpeed'){
    ggplot(weather_data_input,aes(x = year, y = WindGustSpeed, color = state))+
      geom_line()+
      geom_point()+
      scale_x_continuous(breaks = c(2008,2010,2012,2014,2016,2018))
  }
  })
  output$plotchart<-renderPlot({
    weather_data_combine<-read.csv('combine_data.csv')
    weather_data_combine<-weather_data_combine[(weather_data_combine$state == input$state_2),]
    if (input$Factor_2 == 'MaxTemp'){
      ggplot(weather_data_combine,aes(x = MaxTemp, y = Number.Fatalities))+
        geom_point()+
        geom_smooth(se = FALSE)
    }
    else if (input$Factor_2 == 'Humidity_mean'){
      ggplot(weather_data_combine,aes(x = Humidity_mean, y = Number.Fatalities))+
        geom_point()+
        geom_smooth(se = FALSE)
    }
    else if (input$Factor_2 == 'Pressure_mean'){
      ggplot(weather_data_combine,aes(x = Pressure_mean, y = Number.Fatalities))+
        geom_point()+
        geom_smooth(se = FALSE)
    }
    else if (input$Factor_2 == 'Rainfall'){
      ggplot(weather_data_combine,aes(x = Rainfall, y = Number.Fatalities))+
        geom_point()+
        geom_smooth(se = FALSE)
    }
    else if (input$Factor_2 == 'WindGustSpeed'){
      ggplot(weather_data_combine,aes(x = WindGustSpeed, y = Number.Fatalities))+
        geom_point()+
        geom_smooth(se = FALSE)
    }
  })
  
}


shinyApp(ui = ui, server = sever)