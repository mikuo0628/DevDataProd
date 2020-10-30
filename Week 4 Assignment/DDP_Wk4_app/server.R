#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tm)
library(wordcloud)
library(memoise)

default_corp_url <- 'http://www.gutenberg.org/cache/epub/2242/pg2242.txt'
# default_corp <- readLines(default_corp_url)
default_corp <- readr::read_file(default_corp_url)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    terms <- reactive({
        input$process
        isolate({
            withProgress({
                setProgress(message = 'Processing corpus...')
                getTermMatrix(input$corpus)
            })
        })
    })
    wordcloud_rep <- repeatable(wordcloud)
    output$word_cloud <- renderPlot({
        v <- terms()
        wordcloud_rep(
            names(v), v, scale = c(4, 0.5),
            min.freq = input$freq, max.words = input$max,
            colors = brewer.pal(8, 'Dark2')
        )
        
    })

})
