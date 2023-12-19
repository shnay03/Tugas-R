library(shiny)
runExample("01_Hello")
runExample("02_text")

data('marketing', package='datarium')
marketing

model = lm(sales~youtube+facebook, data=marketing)
model
summary(model)

ui = fluidPage(
  titlePanel("Judul"),
  sidebarLayout(
    sidebarPanel(
      numericInput('youtube','Masukan nilai feature youtube : ', value=0),
      numericInput('facebook','Masukan nilai feature facebook : ', value=0),
      actionButton('hitung', 'Predict LM')
    ), 
    mainPanel(
      textOutput('hasil')
    )
  )
)

server = function(input, output){
  observeEvent(input$hitung, {
    predictions <- predict(model, newdata=data.frame(youtube=input$youtube, facebook=input$facebook))
    output$hasil <- renderText({paste('Hasil Linear Regresi adalah', predictions)})
    })
}

shinyApp(ui=ui, server=server)

#covba


