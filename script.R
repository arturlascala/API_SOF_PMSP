############ API_SOF ###########

# Script em R para extrair dados do SOF. Este script extrai múltiplas páginas de uma vez. 

# Preâmbulo - ALTERAR ANTES DE USAR
senha <- "INSIRA SEU TOKEN AQUI" 
paginas <- INSIRA O NÚMERO DE PÁGINAS AQUI

# extrai dados da API do SOF
x <- vector("list", paginas)
for (i in 1:paginas) {
        
        x[[i]] <- GET(paste0("https://gatewayapi.prodam.sp.gov.br:443/financas/orcamento/sof/v2.1.0/consultaEmpenhos?anoEmpenho=2017&mesEmpenho=6&numPagina=",i),
            add_headers(Accept = "application/json", 
                        Authorization = senha))
}

# converte o JSON em data.frame
y <- vector("list", paginas)
for(i in 1:paginas){
        
        y[[i]] <- fromJSON(content(x[[i]], "text", encoding = "UTF-8"))
        
}

# seleciona o data.frame da lista
z <- vector("list", NÚMERO DE PÁGINAS)
for (i in 1:paginas) {
        z[[i]] <- y[[i]]$lstEmpenhos
}

# formata os dados em um único data.frame
dados <- do.call(rbind.data.frame, z)


