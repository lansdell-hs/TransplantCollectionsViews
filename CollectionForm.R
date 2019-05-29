library(shiny)

# Define the fields we want to save from the form
fields <- c("name", "used_shiny", "r_num_years")

# Shiny app with 3 fields that the user can submit data for
shinyApp(
  ui = fluidPage(
    DT::dataTableOutput("responses", width = 300), tags$hr(),
    textInput("name", "Name", placeholder="Your Name Here"),
    textInput("email","UNOS Email:", placeholder="@unos.org"),
    checkboxInput("KI", "Kidney Program", FALSE),
    checkboxInput("KP", "Kidney-Pancreas Program", FALSE),
    checkboxInput("PA", "Pancreas Program", FALSE),
    checkboxInput("HR", "Heart Program", FALSE),
    checkboxInput("LI", "Liver Program", FALSE),
    checkboxInput("LU", "Lung Program", FALSE),
    
    textInput("BM1", "Benchmark1", placeholder="TX Center 1"),
    textInput("BM2", "Benchmark2", placeholder="TX Center 2"),
    textInput("BM3", "Benchmark3", placeholder="TX Center 3"),
    textInput("BM4", "Benchmark4", placeholder="TX Center 4"),
    textInput("BM5", "Benchmark5", placeholder="TX Center 5"),
    textInput("BM6", "Benchmark6", placeholder="TX Center 6"),
    textInput("BM7", "Benchmark7", placeholder="TX Center 7"),
    
    
    actionButton("submit", "Submit")
  ),
  server = function(input, output, session) {
    
    # Whenever a field is filled, aggregate all form data
    formData <- reactive({
      data <- sapply(fields, function(x) input[[x]])
      data
    })
    
    # When the Submit button is clicked, save the form data
    observeEvent(input$submit, {
      saveData(formData())
    })
    
    # Show the previous responses
    # (update with current response when Submit is clicked)
    output$responses <- DT::renderDataTable({
      input$submit
      loadData()
    })     
  }
)
