#include <stdio.h>

int main(){
    printf("Iniciando programa...\n\n");

    int x;
    int y;
   

    printf("Digite um valor para X\n");
    scanf("%d", &x);

    printf("Digite um valor para Y\n");
    scanf("%d", &y);

    int resultado = x * y;

    printf("O resultado da multiplicação é %d\n\n", resultado);
}