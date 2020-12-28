# import libs

library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(scales)
library(glue)
library(DT)
library(wordcloud2)

# import dataset

data_2010s <- read.csv('data_clean_2010s.csv')
genre <- read.csv('data_by_genres_clean.csv')
year <- read.csv('data_by_year_clean.csv')

my_theme <- theme(legend.key = element_rect(fill="black"),
                  legend.background = element_rect(color="white", fill="#263238"),
                  plot.subtitle = element_text(size=6, color="white"),
                  panel.background = element_rect(fill="#dddddd"),
                  panel.border = element_rect(fill=NA),
                  panel.grid.minor.x = element_blank(),
                  panel.grid.major.x = element_blank(),
                  panel.grid.major.y = element_line(color="darkgrey", linetype=2),
                  panel.grid.minor.y = element_blank(),
                  plot.background = element_rect(fill="#263238"),
                  text = element_text(color="white"),
                  axis.text = element_text(color="white")
)