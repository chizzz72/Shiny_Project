library(DT)
library(shiny)
library(shinydashboard)
library(gdata) 
library(countrycode)
library(ggplot2)
library(dplyr)
library(maps)

data <- read.csv("./data/world_happiness_2019.csv")
#class(data)
#Assign continent to each country
data$continent <- countrycode(sourcevar = data$Country,
                              origin = "country.name",
                              destination = "continent")
#selectizeInput factor selections
input_list = c("Positive_affect", "Log_of_GDP", "Healthy_life", "Freedom", "Generosity")

positive_affect = NULL
log_of_gdp = NULL
healthy_life = NULL
freedom = NULL
corruption = NULL
generosity = NULL


#map data
mapdata = na.omit(data %>% select(Ladder, Country..region.))
map.world <- map_data("world")
as.factor(mapdata$Country..region.) %>% levels()
mapdata$Country..region. <- recode(mapdata$Country..region.
                                   ,'United States' = 'USA'
                                   ,'United Kingdom' = 'UK'
)
map.world_joined <- left_join(map.world, mapdata, by = c('region' = 'Country..region.'))
map.world_joined <- map.world_joined %>% mutate(fill_flg = ifelse(is.na(Ladder),F,T))


#test

pl <- na.omit(data %>%
                select(continent,Ladder, Positive.affect))


pl$continent <- as.factor(pl$continent)


names(pl) <- c("continent", "Happiness_Rank", "PositiveEmo")










