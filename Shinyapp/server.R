server <- function(input, output, session) {
  
  values <- reactiveValues()
  
  datasetInput <- reactive({
    switch(input$dataset,
           "ano1" = input$select1,
           "mes1" = input$select2,
           "TOKENX" = input$TOKEN)
  })
  
  
  
  
  
  
  output$downloadData <- downloadHandler(filename = "Empenhos.csv", 
                                         
                                         
                                         
                                         
                                         content = function(file){
                                           
                                           
                                           library(httr)
                                           library(jsonlite)
                                           
                                           prov1 <-  GET(paste0("https://gatewayapi.prodam.sp.gov.br:443/financas/orcamento/sof/v2.1.0/consultaEmpenhos?anoEmpenho=",parse(text=input$select1),"&mesEmpenho=", parse(text=input$select2),"&codOrgao=",parse(text=input$select3)),
                                                         add_headers(Accept = "application/json", 
                                                                     Authorization = paste("Bearer", parse(text=input$TOKEN))))
                                           
                                           prov2 <- fromJSON(content(prov1, "text", encoding = "UTF-8"))
                                           paginas <- prov2$metadados$qtdPaginas
                                           
                                           pb <- txtProgressBar(min = 0, max = paginas, style = 3)
                                           
                                           x <- vector("list", paginas)
                                           for (i in 1:paginas) {
                                             
                                             x[[i]] <- GET(paste0("https://gatewayapi.prodam.sp.gov.br:443/financas/orcamento/sof/v2.1.0/consultaEmpenhos?anoEmpenho=",parse(text=input$select1), "&mesEmpenho=", parse(text=input$select2),"&codOrgao=",parse(text=input$select3), "&numPagina=",i),
                                                           add_headers(Accept = "application/json", 
                                                                       Authorization = paste("Bearer", parse(text=input$TOKEN))))
                                             setTxtProgressBar(pb, i)
                                           }
                                           
                                           
                                           # converte o JSON em data.frame
                                           y <- vector("list", paginas)
                                           for(i in 1:paginas){
                                             
                                             y[[i]] <- fromJSON(content(x[[i]], "text", encoding = "UTF-8"))
                                             
                                           }
                                           
                                           # seleciona o data.frame da lista
                                           z <- vector("list", paginas)
                                           for (i in 1:paginas) {
                                             z[[i]] <- y[[i]]$lstEmpenhos
                                           }
                                           
                                           # formata os dados em um único data.frame
                                           dados <<- do.call(rbind.data.frame, z)
                                           
                                           
                                           
                                           
                                           
                                           
                                           
                                           
                                           write.csv2(x = dados,file)}, 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         contentType = "csv")
  
  
  
  
  
  output$selected_var <- renderText({ 
    paste("Você selecionou", input$select1, "/", input$select2)
  })
  
  
  
}



