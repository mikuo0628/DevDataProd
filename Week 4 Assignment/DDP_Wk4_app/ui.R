#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

default_corp_url <- 'http://www.gutenberg.org/cache/epub/2242/pg2242.txt'
# default_corp <- readLines(default_corp_url)
default_corp <- readr::read_file(default_corp_url)

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Word Cloud Generator"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            textInput('corpus', 'Paste your text here:', default_corp),
            actionButton('process', 'Process'),
            hr(),
            sliderInput('freq',
                        'Minimum word frequency:',
                        min = 1, max = 50, value = 15),
            sliderInput('max',
                        'Maximum number of words to appear:',
                        min = 1, max = 500, value = 150)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput('word_cloud')
        )
    )
))
