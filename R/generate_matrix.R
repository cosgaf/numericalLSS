#' @title Gera matriz de Hilbert
#' @description
#' Gera uma matriz de Hilbert, onde cada termo a_ij = 1 / (i + j - 1)
#' @param dimensao dimensão da matriz a ser gerada (nxn)
#' @return Retorna a matriz de Hilbert, de tamanhao nxn (quadrada)
#' @export
GeraMatrizHilbert <- function(dimensao){

  if (!is.numeric(dimensao)) {
    stop("O argumento ’dimensao’ deve ser número inteiro", call. = FALSE)
  }
  if (dimensao %% 1 != 0){
    stop("O argumento ’dimensao’ deve ser número inteiro", call. = FALSE)
  }

  # Inicializa matriz de zeros
  matrizHilbert <- matrix(0, nrow = dimensao, ncol = dimensao)
  # Posição inicial das linhas
  i <- 1
  # Percorre as linhas da matriz
  while (i <= dimensao){
    # Posição inicial das colunas
    j <- 1
    # Percorre as colunas da matriz
    while (j <= dimensao){
      # Calcula o valor da posição i,j da matriz
      matrizHilbert[i,j] <- 1/(i + j - 1)
      j <- j + 1
    }
    i <- i + 1
  }
  # Retorna a matriz de Hilbert
  return(matrizHilbert)
}
