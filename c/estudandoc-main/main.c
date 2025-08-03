#include <stdio.h>

// Inicio
void verificar(int numeroSecreto){
    int chute;
    char opcao;
    int acertou;  

    printf("Digite um número para o programa verificar se você acertou\n");
    scanf(" %d", &chute);
    
    acertou = (chute == numeroSecreto);

    if(acertou){
      printf("\nParabéns, você digitou %d e acertou!\n", chute);
      printf("Programa finalizado com sucesso!\n\n");
    } else {
     if(chute > numeroSecreto){
      printf("Você digitou um número maior que o número secreto\nDeseja tentar novamente? Digite (S) para Sim ou (N) para Não?\n");
      scanf(" %c", &opcao);
      if(opcao == 'S' || opcao == 's'){
        printf("\n");
        verificar(numeroSecreto);
      } else if (opcao == 'N' || opcao == 'n'){
        printf("Programa encerrado pelo usuário, até a proxima!");
      } else {
        printf("Programa encerrado, até a proxima!");
      }
     }

     if(chute < numeroSecreto){
      printf("Você digitou um número menor que o número secreto\nDeseja tentar novamente? Digite (S) para Sim ou (N) para Não?\n");
      scanf(" %c", &opcao);
      if(opcao == 'S' || opcao == 's'){
        printf("\n");
        verificar(numeroSecreto);
      } else if (opcao == 'N' || opcao == 'n'){
        printf("Programa encerrado pelo usuário, até a proxima!");
      } else {
        printf("Programa encerrado, até a proxima!");
      }
     }
    }
}

int main() {
    printf("****************************************************\n");
    printf("***********Bem Vindo ao Jogo de Advinhação**********\n");
    printf("****************************************************\n");

    int numeroSecreto = 40;
    verificar(numeroSecreto);

    return 0;
}