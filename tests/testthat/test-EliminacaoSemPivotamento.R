A <- t(matrix(c(c(1,-1,2,-1),
                c(2,-2,3,-3),
                c(1,1,1,0),
                c(1,-1,4,3)),nrow = 4,ncol = 4))

b <- matrix(c(-8,-20,-2,4),nrow = 4,ncol = 1)

resposta <- EliminacaoSemPivotamento(A,b,3)

resposta$x

testthat::test_that("Verificando função EliminacaoSemPivotamento",{
  testthat::expect_identical(resposta$msg_erro,"Calculado com sucesso")
  testthat::expect_equal(resposta$x,matrix(c(-7,3,2,2),nrow = 4,ncol = 1))
})
