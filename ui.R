ui <- fluidPage(
  
  
  titlePanel("API Empenhos"),
  
  
  
  
  fluidRow(
    
    column(8,
           sidebarPanel( selectInput(inputId =  "select1", label = h3("Escolha o Ano"), 
                                     choices = list("2017", "2016", 
                                                    "2015"), selected = 1))),
    
    
    column(8,
           sidebarPanel( selectInput(inputId = "select2", label = h3("Escolha o Mes"), 
                                     choices = list("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"), selected = 1))),
    
    #x <- vector("list", 99)
    #for(i in 1:99){
    #x[[i]] <- i}
    
    column(8,
           sidebarPanel( selectInput(inputId = "select3", label = h3("Escolha Codigo do Orgao"), 
                                     choices = as.list(seq(1,99,1)), selected = 1))),
    
    column(8,textInput(inputId = "TOKEN", h3("TOKEN"), 
                       value = "")), 
    
    
    
    #  sidebarLayout(
    #    sidebarPanel( selectInput(inputId =  "select", label = h3("Escolha o Ano"), 
    #                              choices = list("2017", "2016", "2015"), selected = 1)),
    #    sidebarPanel( selectInput(inputId = "select", label = h3("Escolha o Mês"), 
    #                              choices = list("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"), selected = 1)),
    mainPanel(
      #    actionButton("do", "Executar"),
      h2(textOutput("selected_var"), downloadLink('downloadData', 'Download'))
      
      
      
    )
    
    
  ))

