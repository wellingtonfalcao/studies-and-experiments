#include <stdio.h>
#include <stdlib.h>
#include <locale.h>

int main()
{
    setlocale(LC_ALL, "Portuguese");



 /*
    printf("---------------------------------------------------------------------\n");
    printf("---------------------------EXERCICIO 02 -----------------------------\n");
    printf("---------------------------------------------------------------------\n");

    int a = 10;
    int b = 20;
    int carry;

    printf("Esses são os valores iniciais: \n A = %d, B = %d\n\n", a, b);

    carry = a;
    a = b;
    b = carry;

    printf("Esses são os valores invertidos: \n A = %d(B), B = %d(A)\n\n", a, b);

    printf("Digite um valor para A: ");
    scanf("%d", &a);

    printf("Digite um valor para B: ");
    scanf("%d", &b);

    printf("Esses são os valores finais para: \n A = %d, B = %d\n\n", a, b);


    printf("---------------------------------------------------------------------\n");
    printf("---------------------------EXERCICIO 03 -----------------------------\n");
    printf("---------------------------------------------------------------------\n");

    int c = 10;
    int d = 20;

    c = c + d;
    d = c - d;
    c = c - d;

    printf("Esses são os valores finais para: \n C = %d, D = %d\n\n", c, d);


    printf("---------------------------------------------------------------------\n");
    printf("---------------------------EXERCICIO 04 -----------------------------\n");
    printf("---------------------------------------------------------------------\n");

    float conta;
    int qtd_pessoas;
    float gorjeta = 0.1;


    printf("Digite o valor da conta e a quantidade de pessoas: ");
    scanf("%f%d", &conta, &qtd_pessoas);

    float calculo = (conta * gorjeta) + conta;
    float individual = calculo / qtd_pessoas;

    printf("O valor total da conta é de R$ %.2f e o valor por pessoa é de R$ %.2f", calculo, individual);



    printf("---------------------------------------------------------------------\n");
    printf("---------------------------EXERCICIO 05 -----------------------------\n");
    printf("---------------------------------------------------------------------\n");

    float diaria = 45.0;
    float ir = 0.08;
    int dias_trab;

    printf("A diaria do encanador é de R$ %.2f. Digite a quantidade de dias trabalhados por ele: ", diaria);
    scanf("%d", &dias_trab);

    float valor_bruto = diaria * dias_trab;
    float valor_liquido = valor_bruto - (valor_bruto * ir);

    printf("O valor bruto total é de R$ %.2f e o valor líquido é de R$ %.2f", valor_bruto, valor_liquido);



    printf("---------------------------------------------------------------------\n");
    printf("---------------------------EXERCICIO 06 -----------------------------\n");
    printf("---------------------------------------------------------------------\n");

    float cotacao_dolar = 1.0, cotacao_real = 2, valor_real, valor_dolar;

    printf("Digite o valor em reais que deseja converter: R$ ");
    scanf("%f", &valor_real);

    valor_dolar = (valor_real / cotacao_real) * cotacao_dolar;

    printf("O valor total de R$ %.2f convertido em dólar é de $ %.2f\n\n", valor_real, valor_dolar);

    printf("---------------------------------------------------------------------\n");
    printf("---------------------------EXERCICIO 07 -----------------------------\n");
    printf("---------------------------------------------------------------------\n");

    int entrada_qnt_segundos, horas, minutos, segundos;

    printf("Digite a quantidade de segundos e lhe retonarei em HH:MM:SS: ");
    scanf("%d", &entrada_qnt_segundos );

    horas = entrada_qnt_segundos / 3600;
    minutos = (entrada_qnt_segundos / 60) % 60;
    segundos = ((entrada_qnt_segundos % 60) % 60 ) % 60;

    printf("\nTotal de: Horas: %d, Minutos: %d, Segundos: %d\n\n", horas, minutos, segundos);
    */


    /*
    setlocale(LC_ALL,"Portuguese");
    printf("A codificação é: %s\n", setlocale(LC_ALL,"Portuguese"));
    printf("Arrebentação é muito legal\n");
    printf("%c", 7);


    int a = 10, b = 20;

    printf("Resto da divisao inteira: %d\n", b % a);

    int a = 10, b = 20;

    printf("\nDivisao de %d por %d e: %f\n", a, b, (float)a / b);

    printf("\nSoma: %d\n", 50 + 50);
    printf("\nSubtracao: %d\n", 50 - 20);
    printf("\nMultiplicacao: %d\n", 50 * 4);
    printf("\nDivisao: %.2f\n", 10.0 / 20);


    printf("Este e o titulo\n|--->\tEste e um paragrafo\n");


    long double x = 3.1415031956293467;

    printf("O tipo double precisa de %d bytes em memoria\n", sizeof x);

    __mingw_printf("O valor de x e: %.10Lf\n", x); // no Windows não é possível imprimir um numero maior que 8bytes;

    float x = 3.1415;

    printf("Um float precisa de %d bytes de memoria.\n", sizeof x);



    long long int x = 2147483647;

    printf("Tamanho de x em bytes: %d\n", sizeof x);
    printf("Valor de x: %ld\n", x);
    x++;
    printf("Valor de x: %lli\n", x);





    char x = 'm';
    uint16_t y = 32768;

    printf("Tamanho em memoria de um char int: %d bytes\n", sizeof x);
    printf("Tamanho em memoria de um tipo int: %d bytes\n", sizeof(int));
    printf("Tamanho em memoria de um tipo short int: %d bytes\nSeu valor e: %d\n", sizeof y, y);



    char a, b;

    printf("Digite duas letras: ");
    scanf("%c", &a);

    printf("Digite duas letras: ");
    scanf(" %c", &b);

    printf("Primeira letra: %c\nSegunda letra: %c\n", a, b);


    char sexo;
    int idade;
    float peso, altura;

    printf("Digite sexo (f,F | m ou M), idade, peso e altura\n");
    scanf(" %c%d%f%f", &sexo, &idade, &peso, &altura);//

    printf("Os valores sao:\n\nSexo: %c\nIdade: %d\nPeso: %.1f\nAltura: %.2f", sexo, idade, peso, altura);


    int num1, num2, num3;

    printf("Digite 3 valores inteiros: ");
    scanf("%d%d%d", &num1, &num2, &num3);

    printf("Valores lidos: %d, %d e %d\n", num1, num2, num3);



    char caractere;

    printf("Digite um caractere: ");
    caractere = fgetc(stdin);

    printf("Caractere lido: %c", caractere);


    char letra;

    printf("Digite um caractere: ");
    letra = getc(stdin);

    printf("Caractere lido: %c", letra);




    char letra;

    printf("Digite uma letra: ");
    letra = getchar();

    printf("Caractere lido: %c\n\n", letra);



    char sexo = 'm'; //precisa usar aspas simples

    printf("Valor da variavel sexo: %c\n", sexo);

    printf("Digite seu sexo: (f,F | m ou M)");
    scanf("%c", &sexo);

    printf("\n\nValor da variavel sexo: %c\n", sexo);




    float numReal = 3.1415;

    printf("O valor real e: %.4f\n", numReal);

    printf("Digite um numero real: ");
    scanf("%f", &numReal);

    printf("Valor lido: %.2f", numReal);


    int valor, valor2;

    valor = 50;

    printf("Digite um valor inteiro: ");
    scanf("%d", &valor);

    printf("Digite o segundo valor inteiro: ");
    scanf("%d", &valor2);

    printf("\n\nPrimeiro valor: %d\nSegundo valor: %d\n\n", valor, valor2);
    */

    return 0;
}


