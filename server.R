shinyServer(function(input, output){
  
  
  
  
  
  input_list = c("Positive affect", "Log of GDP", "Healthy life", "Freedom", "Corruption", "Generosity")
  
  #Get the corresponding df to the selectizeInput
  current_data = reactive({
    
    if(input$factors == "Positive_affect"){
      if(is.null(positive_affect)){
        positive_affect = na.omit(data %>% select(continent, Ladder, Positive.affect))
        positive_affect$continent <- as.factor(positive_affect$continent)
        names(positive_affect) <- c("continent", "Happiness_Rank", "Positive_affect")
      }
      return(positive_affect)
    }
    
    if(input$factors == "Log_of_GDP"){
      if(is.null(log_of_gdp)){
        log_of_gdp = na.omit(data %>% select(continent, Ladder, Log.of.GDP.per.capita))
        log_of_gdp$continent <- as.factor(log_of_gdp$continent)
        names(log_of_gdp) <- c("continent", "Happiness_Rank", "Log_of_GDP")
      }
      return(log_of_gdp)
    }
    
    if(input$factors == "Healthy_life"){
      if(is.null(healthy_life)){
        healthy_life = na.omit(data %>% select(continent, Ladder, Healthy.life.expectancy))
        healthy_life$continent <- as.factor(healthy_life$continent)
        names(healthy_life) <- c("continent", "Happiness_Rank", "Healthy_life")
      }
      return(healthy_life)
    }
    
    if(input$factors == "Freedom"){
      if(is.null(freedom)){
        freedom = na.omit(data %>% select(continent, Ladder, Freedom))
        freedom$continent <- as.factor(freedom$continent)
        names(freedom) <- c("continent", "Happiness_Rank", "Freedom")
      }
      return(freedom)
    }
    
    
    if(input$factors == "Generosity"){
      if(is.null(generosity)){
        generosity = na.omit(data %>% select(continent, Ladder, Generosity))
        generosity$continent <- as.factor(generosity$continent)
        names(generosity) <- c("continent", "Happiness_Rank", "Generosity")
      }
      return(generosity)
    }
    
  })
  
  #map of worldwide happiness Ladder
  output$map = renderPlot({
    ggplot(map.world_joined, aes(long, lat, group=group, fill=Ladder)) +
      geom_polygon() + ggtitle("World Happiness")
  })
  
  
  output$chart = renderPlot({
    temp_df = current_data()
    ggplot(temp_df, aes(x = Happiness_Rank, y = temp_df[, input$factors], color = continent))+
      geom_path()+
      facet_grid(continent ~ .)+
      geom_smooth(method="loess") + 
      stat_summary(aes(y = temp_df[, input$factors],group=1), fun.y=mean, colour="black", geom="line",group=1)+
      ggtitle(label = "Factor's effect on happiness")
  })
  
  
  
  
  
  output$intro_header = renderUI({
    h1('Welcome to Wrold Hppiness App!')
  })
  output$intro_author = renderUI({
    h4('Chi Zhang')
  })
  output$intro_body1 = renderUI({
    p("In this app, you will be able to see happiness score of each country on map. And you can also findout how does differrent factor contribute to the happiness score on differnt continents.")
    
  })
  output$intro_body2 = renderUI({
    p("Data Source: Helliwell, J., Layard, R., & Sachs, J. (2019). World Happiness Report 2019, New York: Sustainable Development Solutions Network.")
  })
  output$intro_body3 = renderUI({
    p('Hope you enjoy this app :)')
  })
  
})