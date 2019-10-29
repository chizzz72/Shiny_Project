shinyUI(dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "World Happiness 2019"),
  dashboardSidebar(
    sidebarUserPanel(
      "Chi Zhang", image = "https://images-na.ssl-images-amazon.com/images/I/41CyuoxrPvL._SX425_.jpg"
      ),
    sidebarMenu(
      menuItem("Introduction", tabName= "intro", icon = icon("info")),
      menuItem("Map", tabName = "map", icon = icon("map")),
      menuItem("Compare", tabName = "chart", icon = icon("bar-chart-o"))
    ),
    selectizeInput(
      "factors", "Select facotor contribute to happiness", 
      input_list, selected = 'Positive affect'
    )

  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "intro",
        fluidRow(column(12, align="center", offset = 0,
                        box(htmlOutput('intro_header'), htmlOutput('intro_author'), width = 20, background = 'teal'),
                        tags$style(type="text/css", "#string { text-align:center }"))
                 ),
        fluidRow(column(12, align="center", offset = 0,
                        box(htmlOutput('intro_body1'), htmlOutput('intro_body2'), htmlOutput('intro_body3'), width = 20, background = 'teal'),
                        tags$style(type="text/css"))
                 )
        ),
      tabItem(
        tabName = "map",
        fluidRow(plotOutput("map"))
        ),
      tabItem(
        tabName = "chart",
        fluidRow(box(plotOutput("chart"), width = 12))
      )
    )
    )

))