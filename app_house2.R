library(shiny)

# Define UI
ui <- fluidPage(
  # App title
  titlePanel("PREDICTION DU PRIX D'UN BIEN IMMOBILIER SUR PARIS EN FONCTION DE LA SURFACE", 
             "model utilisé prédiction linéaire"),
  # Input for square meters
  mainPanel(
    tabsetPanel(
      tabPanel(
        h3("Prédiction"),
           sliderInput(inputId = "squareMeters",
                  label = "Square Meters",
                  min = 1,
                  max = 100000,
                  value = 50000
        ),
        # Price prediction
        tableOutput("predict")
      ),
      tabPanel(
        h3("Tableau"),
        DT::dataTableOutput("table")
      )
    )
  ),
                         
                         # Create a new row for the table. DT::dataTableOutput("table") ), tabPanel(h3("Graphiques"), plotOutput("plot") ))
  

        img(src = "test.jpg", height = 140, width = 400),
    #  )
   
  
  # Create a new row for the table.
)
  

# Load saved model
load("model.rda")

# Define server
server <- function(input, output) {
  predictions <- reactive({
    preprocessInput = data.frame(squareMeters = as.integer(input$squareMeters))
    prediction <- predict(modellm, preprocessInput)
    
    data.frame(
      Prediction = as.character(c(paste(round(prediction, digits=2), " €")))
    )
  })
  output$predict <- renderTable({
    predictions()
  })
  
  output$table <- DT::renderDataTable(DT::datatable({
    data <- data
  })
  )
  
  
}

# Launch the app
shinyApp(ui = ui, server = server)