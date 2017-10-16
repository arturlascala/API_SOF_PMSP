### API SOF ###

# Este script em R contém uma função para a leitura da API de Empenhos do Sistema 
# Orçamentário Financeiro da Prefeitura de São Paulo

# Carregue a função no R e preencha os argumentos conforme desejado

# A SENHA é fornecida por meio de cadastro no site https://api.prodam.sp.gov.br/store/



APISOF <- function(SENHA, anoEmpenho, mesEmpenho, codEmpenho = NULL, numCpfCnpj = NULL, txtRazaoSocial = NULL, codOrgao = NULL){
  
  library(httr)
  library(jsonlite)
  
  prov1 <-  GET(paste0("https://gatewayapi.prodam.sp.gov.br:443/financas/orcamento/sof/v2.1.0/consultaEmpenhos?anoEmpenho=",anoEmpenho,"&mesEmpenho=", mesEmpenho,"&numCpfCnpj=", numCpfCnpj, "&txtRazaoSocial=", txtRazaoSocial,"&codOrgao=",codOrgao),
             add_headers(Accept = "application/json", 
                  Authorization = paste("Bearer", SENHA)))
             
  prov2 <- fromJSON(content(prov1, "text", encoding = "UTF-8"))
  paginas <- prov2$metadados$qtdPaginas
  
  pb <- txtProgressBar(min = 0, max = paginas, style = 3)
  
  x <- vector("list", paginas)
  for (i in 1:paginas) {
    
    x[[i]] <- GET(paste0("https://gatewayapi.prodam.sp.gov.br:443/financas/orcamento/sof/v2.1.0/consultaEmpenhos?anoEmpenho=",anoEmpenho, "&mesEmpenho=", mesEmpenho,"&numCpfCnpj=", numCpfCnpj, "&txtRazaoSocial=", txtRazaoSocial,"&codOrgao=",codOrgao, "&numPagina=",i),
                  add_headers(Accept = "application/json", 
                              Authorization = paste("Bearer", SENHA)))
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
  
  
  
  
}



