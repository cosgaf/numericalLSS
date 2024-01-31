CalculaResultadoMatrizSuperior <- function(matriz, b, dimensao){

  # Cria vetor que vai receber a resposta do sistema
  x = matrix(numeric(dimensao),nrow = dimensao)

  # Começa na ultima linha da matriz
  linha = dimensao
  # Verifica se o ultimo elemento da matriz é nulo
  if (matriz[dimensao,dimensao] == 0){
    stop("Problema sem solução")
  }

  # Calcula ultimo valor da resposta do sistema
  x[dimensao,] = b[linha] / matriz[linha,linha]

  # Inicia na penultima linha da matriz
  linha <- linha - 1
  # Itera subindo cada linha da matriz
  while (1 <= linha){
    # Define a variável que vai receber o calculo
    coef_aux <- 0
    # Seleciona a linha acima da linha atual
    linha_aux <- linha + 1

    # Percorre as linhas abaixo da linha definida acima
    while (linha_aux <= dimensao){
      # Calcula resposta
      coef_aux <- coef_aux + matriz[linha,linha_aux]*x[linha_aux]
      # Pula para a próxima linha
      linha_aux <- linha_aux + 1
    }
    # Calcula resposta da linha atual
    x[linha,] <- (b[linha,] - coef_aux) / matriz[linha,linha]
    # Pula para a linha anterior
    linha <- linha - 1
  }
  # Retorna a resposta
  return(x)
}

CalculaDeterminante <- function(matriz, dimensao, trocaDeLinhas){
  # Inicia determinante
  determinante = 1
  # Percorre todas as posições da diagonal principal
  while (1 <= dimensao){
    # Multiplica determinante pela posição atual da diagonal principal
    determinante <- determinante*matriz[dimensao,dimensao]
    # Pula para a próxima posição
    dimensao <- dimensao - 1
  }
  # Inverte sinal do determinante, dependendo do numero de trocas de linhas, durante o escalonamento
  determinante <- determinante*((-1)^trocaDeLinhas)
  # Retorna o determinante
  return(determinante)
}

EliminacaoSemPivotamento <- function(matriz, vetor, dimensao){

  # Define variáveis auxiliares
  # Define variável que vai contar o numero de trocas de linha
  trocasDeLinha <- 0
  # Define variável que indica a coluna da matriz a ser escalonada
  p <- 1
  # Define variável que indica a linha atual
  linha <- 1

  # Percorre todas as linhas até a penultima linha
  while(linha <= dimensao - 1){
    # Checar se a primeira posicao da linha é zero
    if (matriz[p,linha] == 0){
      # Checar se não estou na ultima linha da matriz
      if (p == dimensao){
        print("Entrou aqui")
        # Retorna um erro
        stop("Não foi possível calcular")
      }
      # Pula para a próxima linha
      p <- p + 1
      next
    }
    # Verifica se precisa trocar de linha
    if (p != linha) {

      # Troca linhas da matriz A
      tmp <- matriz[p,]
      matriz[p,] <- matriz[linha,]
      matriz[linha,] <- tmp

      # Troca linhas do vetor
      tmp <- vetor[p,]
      vetor[p,] <- vetor[linha,]
      vetor[linha,] <- tmp

      # Incrementa contador de troca de linhas
      trocasDeLinha <- trocasDeLinha + 1

    }

    # Define linha onde vai começar a zerar os coeficientes
    linha_final <- linha + 1

    # Percorre as linhas abaixo da linha selecionada para zerar os coeficientes
    while (linha_final <= dimensao){
      # Calcula coeficiente multiplicador para zerar a primeira posição da linha
      m <- matriz[linha_final,linha] / matriz[linha,linha]
      # Zera aprimeira posição da linha, aplicando o multplicador
      matriz[linha_final,] <- matriz[linha_final,] - m*matriz[linha,]
      # Aplica o multplicador no vetor b
      vetor[linha_final,] <- vetor[linha_final,] - m*vetor[linha,]
      # Pula para a próxima linha
      linha_final <- linha_final + 1
    }

    # Pula para a próxima linha
    linha <- linha + 1
    # Indica a coluna que será analisada
    p <- linha

  }

  # Montar vetor de retorno, com a solução do sistema e determinante da matriz A
  return(list("matriz" = matriz,
              "x" = CalculaResultadoMatrizSuperior(matriz, vetor, dimensao),
              "determinante" = CalculaDeterminante(matriz, dimensao, trocasDeLinha),
              "msg_erro" = "Calculado com sucesso"))
}

EliminacaoComPivotamento <- function(matriz, vetor, dimensao){

  # Define variáveis auxiliares
  # Define variável que vai contar o numero de trocas de linha
  trocasDeLinha <- 0
  # Define variável que indica a coluna da matriz a ser escalonada
  p <- 1
  # Define variável que indica a linha atual
  linha <- 1

  # Percorre todas as linhas até a penultima linha
  while(linha <= dimensao - 1){
    # Define a linha com coef maior, como sendo a linha atual
    linha_maior <- linha
    # Seleciona a próxima linha
    p <- linha + 1
    # Salva o valor do maior coef. até então
    max <- matriz[linha_maior, linha]

    # Percorre as demais linhas, para ver se a linha atual é a com maior coeficiente na coluna selecionada
    while (p <= dimensao){
      # Verifica se a próxima linha possui coeficiente maior que o maior até agora
      if (max < matriz[p,linha] & matriz[p,linha] != 0){
        # Salva o novo valor do maior coef.
        max <- matriz[p,linha]
        # Define a nova linha como a com maior coef. até então
        linha_maior <- p
      }
      # Pula para a próxima linha
      p <- p + 1
    }

    # Checar se a primeira posicao da linha é zero
    if (matriz[linha_maior,linha] == 0){
      # Retorna um erro
      stop("Não conseguiu calcular")
    }
    # Verifica se precisa trocar de linha
    if (linha_maior != linha) {

      # Troca linhas da matriz A
      tmp <- matriz[linha_maior,]
      matriz[linha_maior,] <- matriz[linha,]
      matriz[linha,] <- tmp

      # Troca linhas do vetor
      tmp <- vetor[linha_maior,]
      vetor[linha_maior,] <- vetor[linha,]
      vetor[linha,] <- tmp

      # Incrementa contador de troca de linhas
      trocasDeLinha <- trocasDeLinha + 1

    }
    # Define linha onde vai começar a zerar os coeficientes
    linha_final <- linha + 1

    # Percorre as linhas abaixo da linha selecionada para zerar os coeficientes
    while (linha_final <= dimensao){
      # Calcula coeficiente multiplicador para zerar a primeira posição da linha
      m <- matriz[linha_final,linha] / matriz[linha,linha]
      # Zera a primeira posição da linha, aplicando o multplicador
      matriz[linha_final,] <- matriz[linha_final,] - m*matriz[linha,]
      # Aplica o multplicador no vetor b
      vetor[linha_final,] <- vetor[linha_final,] - m*vetor[linha,]
      # Pula para a próxima linha
      linha_final <- linha_final + 1
    }
    # Pula para a próxima linha
    linha <- linha + 1
    # Indica a coluna que será analisada
    p <- linha
  }
  # Montar vetor de retorno, com a solução do sistema e determinante da matriz A
  retorno <- list("matriz" = matriz,
                  "x" = CalculaResultadoMatrizSuperior(matriz, vetor, dimensao),
                  "determinante" = CalculaDeterminante(matriz, dimensao, trocasDeLinha),
                  "msg_erro" = "Calculado com sucesso")
}

#' @title Solver sem pivotamento
#' @description
#' Recebe uma matriz e um vetor 'b' e realiza a eliminação de Gauss sem pivotamento.
#' @details
#' Additional details...
#' @param matriz Matriz quadrada, de ordem n
#' @param vetor Vetor de dimensao nx1
#' @return Retorna o vetor solução 'x' e o determinante da matriz
#' @references reference
#' @export
solver_semPivotamento <- function(matriz, vetor){
  tryCatch(
    {
      retorno <- EliminacaoSemPivotamento(matriz, vetor, dim(matriz)[1])
    },
    error = function(cond) {
      return(list("matriz" = NULL, "x" = NULL, "determinante" = NULL, "msg_erro" = conditionMessage(cond)))
    },
    warning = function(cond) {
      return(list("matriz" = NULL, "x" = NULL, "determinante" = NULL, "msg_erro" = "warning - Houve um problema na execução"))
    }
  )
}

#' @title Solver com pivotamento
#' @description
#' Recebe uma matriz e um vetor 'b' e realiza a eliminação de Gauss com pivotamento.
#' @details
#' Additional details...
#' @param matriz Matriz quadrada, de ordem n
#' @param vetor Vetor de dimensao nx1
#' @return Retorna o vetor solução 'x' e o determinante da matriz
#' @references reference
#' @export
solver_comPivotamento <- function(matriz, vetor){
  tryCatch(
    {
      retorno <- EliminacaoSemPivotamento(matriz, vetor, dim(matriz)[1])
    },
    error = function(cond) {
      return(list("matriz" = NULL, "x" = NULL, "determinante" = NULL, "msg_erro" = conditionMessage(cond)))
    },
    warning = function(cond) {
      return(list("matriz" = NULL, "x" = NULL, "determinante" = NULL, "msg_erro" = "warning - Houve um problema na execução"))
    }
  )
}
