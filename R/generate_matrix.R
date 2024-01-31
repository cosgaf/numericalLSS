#' @export
GeraMatrizHilbert <- function(dimensao){
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
