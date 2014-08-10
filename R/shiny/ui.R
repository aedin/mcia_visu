library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("shiny app for mcia visualization"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(

    sidebarPanel(

      fileInput("file", "Choose file to upload")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
