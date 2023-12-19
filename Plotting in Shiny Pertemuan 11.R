library(shiny)
library(ggplot2)
library(datasets)

ui = fluidPage(
  titlePanel('Plotting in Shiny'),
  sidebarLayout(
    sidebarPanel(
      selectInput('datanya', 'Pilih dataset yang diinginkan', choices = c('iris', 'mtcars', 'co2'))
    ),
    mainPanel(
      plotOutput('hasil')
    )
  )
)

server = function(input, output){
  selectedData <- reactive({
    switch(input$datanya, 'iris' = 'iris', 'mtcars' = mtcars, 'co2' = co2)
  })
  plotData <- reactive({
    data <- selectedData()
    if(input$datanya == 'iris'){
      x_col = 'Sepal.Length'
      y_col = 'Sepal.Width'
    }else if(input$datanya == 'mtcars'){
      x_col = 'mpg'
      y_col = 'disp'
    } else{
      x_col = 'uptake'
      y_col = 'conc'
    }
    return(data.frame(x=data[, x_col], y = data[y_col]))
    })
  output$hasil <- renderPlot({
    ggplot(plotData(), aes (x,y))+
      geom_line()+
      labs(title=paste('Hasil plot', input$datanya))
  })
  }

shinyApp(ui=ui, server=server)
