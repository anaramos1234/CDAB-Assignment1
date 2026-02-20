library(shiny)
library(ggplot2)
library(palmerpenguins)

UI <- fluidPage(
  titlePanel("Assignment 1: Dataset penguins"),
  sidebarLayout(
    sidebarPanel(
      h4("Data Selection"),
      selectInput(inputId = "axis_x",
                  label = "Axis X:",
                  choices = c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g"),
                  selected = "bill_length_mm"),

      selectInput(inputId = "axis_y",
                  label = "Axis Y:",
                  choices = c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g"),
                  selected = "bill_depth_mm")
    ), 
    
    mainPanel(
      plotOutput(outputId = "scatter_plot")
    )
  )
)

server <- function(input, output) {
  output$scatter_plot <- renderPlot({
    ggplot(penguins, aes_string(x = input$axis_x, y = input$axis_y, color = "species")) +
      geom_point(size = 4, alpha = 0.8) +
      theme_minimal() +
      labs(title = paste("Relation between", input$axis_x, "and", input$axis_y),
            x = input$axis_x,
            y = input$axis_y)
  })

}
shinyApp(ui = UI, server = server)

