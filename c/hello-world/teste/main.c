#include <stdio.h>
#include <stdlib.h>
#include <locale.h>

int main()
{
    setlocale(LC_ALL, "Portuguese_Brazil");
    //setlocale(LC_NUMERIC, "pt_BR.utf-8");



    /*
    // FOREACH em C (Algoritmo)

    int arr[] = {1,2,3,4,5,6,7,8,9,10};
    int n = sizeof(arr) / sizeof(arr[0]);

    for (int i = 0; i < n; i++) {
    printf("%d ", arr[i]);
    }

    printf()




    // DO WHILE

    int valor = 5, digitado;


    do {
        printf("\nDigite um valor inteiro maior que %d: ", valor);
        scanf("%d", &digitado);
    } while(digitado <= valor);

    printf("Valor lido: %d", digitado);




    // WHILE

    int valor = 5, digitado;


    printf("\nDigite um valor inteiro maior que %d: ", valor);
    scanf("%d", &digitado);

    while(digitado <= valor){
        printf("\Valor inválido! Digite um valor inteiro maior que %d: ", valor);
        scanf("%d", &digitado);
    }

    printf("Valor lido: %d", digitado);



    // FOR (decrescente)

    int ini = 5, inter = 5, dest = 1000;

    for(ini ; ini <= dest; ini+=inter){ // Incremento de n em n
        printf("%d \n", ini);
    }


    // FOR (crescente)


    for(i = 0; i < 10; i++){
        printf("Número: %d\n", i);
    }


    printf("---------------------------------------------------------------------\n");
    printf("---------------------------EXERCICIO 10 -----------------------------\n");
    printf("------------------Estruturas de decisão e seleção--------------------\n");

    printf("\n\n10) Faça um programa que, dado três valores a, b e c, verifique se eles podem ser os comprimentos dos lados de um triângulo.");
    printf("\nCaso positivo, seu programa deve informar também se o triângulo é nequilátero, isósceles ou escaleno.") ;
    printf("\nCaso contrário, seu programa deve escrever a mensagem “Não formam um triângulo”.\n\n");

    int a, b, c;

    printf("\Digite três valores: ");
    scanf("%d%d%d", &a, &b, &c);

    if( a + b > c && a + c > b & b + c > a)
    {
        printf("Os 3 lados forma um triangulo! \n");
        if(a == b && a == c)
            printf("Equilátero\n");
        else if(a == b || a == c || b == c)
            printf("Isosceles\n");
        else
            printf("Escaleno\n");
    }
    else
        printf("Os 3 lados NÃO formam um triangulo! \n");



       printf("---------------------------------------------------------------------\n");
       printf("---------------------------EXERCICIO 10 ERRADO -----------------------------\n");
       printf("------------------Estruturas de decisão e seleção--------------------\n");

       printf("\n\n10) Faça um programa que, dado três valores a, b e c, verifique se eles podem ser os comprimentos dos lados de um triângulo.");
       printf("\nCaso positivo, seu programa deve informar também se o triângulo é nequilátero, isósceles ou escaleno.") ;
       printf("\nCaso contrário, seu programa deve escrever a mensagem “Não formam um triângulo”.\n\n");

       int ladoA, ladoB, ladoC, somaLados = 360;

       printf("\nDigite o comprimento dos 3 lado de um triângulo: ");
       scanf("%d%d%d", &ladoA, &ladoB, &ladoC);

       if(ladoA + ladoB + ladoC == somaLados){
           printf("\nTriângulo válido");
           if(ladoA == ladoB && ladoB == ladoC)
               printf("\nTriângulo equilátero");
           else if(ladoA == ladoB || ladoB == ladoC || ladoC == ladoA)
               printf("\nTriângulo isósceles");
           else{
               printf("\nTriângulo escaleno");
           }
       }else{
           printf("\nTriângulo inválido");
       }

    printf("---------------------------------------------------------------------\n");
    printf("---------------------------EXERCICIO 09 -----------------------------\n");
    printf("------------------Estruturas de decisão e seleção--------------------\n");

    float nota1, nota2, nota3;
    char escolha;

    printf("\nQual a média desejada?\na - aritmética\nb - ponderada\n");
    scanf("%c", &escolha);

    if(escolha == 'a' || escolha == 'A' || escolha == 'b' || escolha == 'B')
    {
        printf("Digite as 3 notas: ");
        scanf("%f%f%f", &nota1, &nota2, &nota3);
    }

    if(escolha == 'a' || escolha == 'A')
        printf("Média aritmética: %.2f\n", (nota1 + nota2 + nota3) / 3);
    else if(escolha == 'b' || escolha == 'B')
        printf("Média ponderada: %.2f\n", (nota1*3 + nota2*3 + nota3*4) / 10 );
    else
        printf("Opção inválida");


    printf("---------------------------------------------------------------------\n");
    printf("---------------------------EXERCICIO 08 -----------------------------\n");
    printf("------------------Estruturas de decisão e seleção--------------------\n");

    printf("\n\n8) Elabore um programa que, dado o número do mês, indica quantos dias têm esse mês.\nUtilize para isso a estrutura de seleção switch.\n\n");

    int num_mes;

    printf("\nDigite o número de um mês: ");
    scanf("%d", &num_mes);

    switch(num_mes){
    case 1:
        printf("\nJaneiro de 31 dias");
        break;
    case 2:
        printf("\nFevereiro tem 28 dias");
        break;
    case 3:
        printf("\nMarço tem 31 dias");
        break;
    case 4:
        printf("\nAbril tem 30 dias");
        break;
    case 5:
        printf("\nMaio tem 31 dias");
        break;
    case 6:
        printf("\nJunho tem 30 dias");
        break;
    case 7:
        printf("\nJulho tem 31 dias");
        break;
    case 8:
        printf("\nAgosto tem 31 dias");
        break;
    case 9:
        printf("\nSetembro tem 30 dias");
        break;
    case 10:
        printf("\nOutubro tem 31 dias");
        break;
    case 11:
        printf("\nNovembro tem 30 dias");
        break;
    case 12:
        printf("\nDezembro tem 31 dias");
        break;
    default:
        printf("\nMês %d inválido", num_mes);
    }

    printf("---------------------------------------------------------------------\n");
    printf("---------------------------EXERCICIO 07 -----------------------------\n");
    printf("------------------Estruturas de decisão e seleção--------------------\n");

    printf("\n\n7) Faça um programa que peça ao usuário um caracter e diga se é uma vogal ou não.\n\n");

    char letra;

    printf("Digite uma letra: ");
    scanf("%c", &letra);

    if(letra == 'a' ||
       letra == 'e' ||
       letra == 'i' ||
       letra == 'o' ||
       letra == 'u'){
           printf("\n%c é uma vogal\n\n", letra);
       }else {
           printf("\n%c não é vogal\n\n", letra);
       }

    printf("---------------------------------------------------------------------\n");
    printf("---------------------------EXERCICIO 05 -----------------------------\n");
    printf("------------------Estruturas de decisão e seleção--------------------\n");

    printf("\n\n6) Faça um programa para ler um número inteiro e verificar se corresponde a um mês válido no calendário.\nCaso corresponda, escrever o nome do mês, caso contrário, escrever a mensagem ‘Mês Inválido’.\n\n");

    int num_mes;

    printf("\nDigite o número de um mês: ");
    scanf("%d", &num_mes);

    switch(num_mes)
    {
    case 1:
     printf("\nJaneiro");
     break;
    case 2:
     printf("\nFevereiro");
     break;
    case 3:
     printf("\nMarço");
     break;
    case 4:
     printf("\nAbril");
     break;
    case 5:
     printf("\nMaio");
     break;
    case 6:
     printf("\nJunho");
     break;
    case 7:
     printf("\nJulho");
     break;
    case 8:
     printf("\nAgosto");
     break;
    case 9:
     printf("\nSetembro");
     break;
    case 10:
     printf("\nOutubro");
     break;
    case 11:
     printf("\nNovembro");
     break;
    case 12:
     printf("\nDezembro");
     break;
    default:
     printf("\nMês %d inválido", num_mes);
    }

     printf("---------------------------------------------------------------------\n");
     printf("---------------------------EXERCICIO 04 -----------------------------\n");
     printf("------------------Estruturas de decisão e seleção--------------------\n");

     printf("\n\nCrie um programa que permita ao usuário escolher entre fazer a conversão de Real para Dólar ou de Dólar para Real.\nUtilize como taxa de câmbio $1 igual a R$5.30.");

     float real = 5.3, dolar = 1.0, valor, resultado;
     int opcao;

     printf("\n\n\nDigite o valor que deseja converter: ");
     scanf("%f", &valor);

     printf("\nEscolha uma modalidade de conversão\n\t1 - Dolar para Real\n\t2 - Real para Dólar\n\n\Digite o valor: ");
     scanf("%d", &opcao);

     switch(opcao){
     case 1:
         resultado = valor * real;
         printf("\nO valor convertido de Dólar para Reais é de: R$ %'.2f\n\n", resultado);
         break;
     case 2:
         resultado = valor / real;
         printf("\nO valor convertido de Real para Dólar é de: $ %'.2f\n\n", resultado);
         break;
     default:
         printf("\nOpção inválida");
     }


     printf("---------------------------------------------------------------------\n");
     printf("---------------------------EXERCICIO 03 -----------------------------\n");
     printf("------------------Estruturas de decisão e seleção--------------------\n");

     printf("\n3) Escreva um programa em C que leia um número e informe se ele é divisível por 2, por 3 ou por 5, ou se não é divisível por nenhum deles.\n");

     int num;

     printf("\Digite um número para saber se ele é divisível por 2, 3 ou 5: ");
     scanf("%d", &num);

     if(!(num % 2))
         printf("\nO Número %d é divisível por 2", num);
     if(!(num % 3))
         printf("\nO Número %d é divisível por 3", num);
     if(!(num % 5))
         printf("\nO Número %d é divisível por 5", num);
     if(num % 2 || num % 3 || num % 5)
         printf("\nO Número %d não é divisível por 2, 3 ou 5, ele é primo.\n", num);


     printf("---------------------------------------------------------------------\n");
     printf("---------------------------EXERCICIO 02 -----------------------------\n");
     printf("------------------Estruturas de decisão e seleção--------------------\n");

     printf("Escreva um programa em C que lê 5 números inteiros, um por vez. Conte quantos destes valores");
     printf("são negativos e quantos são positivos. Ao final, imprima na tela a quantidade de números negativos e positivos.\n");

     int num1, num2, num3, num4, num5;
     int negativo = 0, positivo = 0, neutro = 0;

     printf("\nDigite 5 números inteiros: ");
     scanf("%d%d%d%d%d", &num1, &num2, &num3, &num4, &num5);

     if(num1 > 0){
         positivo++;
     }else if(num1 == 0) {
         neutro++;
     }else {
         negativo++;
     }

      if(num2 > 0){
         positivo++;
     }else if(num2 == 0) {
         neutro++;
     }else {
         negativo++;
     }

      if(num3 > 0){
         positivo++;
     }else if(num3 == 0) {
         neutro++;
     }else {
         negativo++;
     }

      if(num4 > 0){
         positivo++;
     }else if(num4 == 0) {
         neutro++;
     }else {
         negativo++;
     }

      if(num5 > 0){
         positivo++;
     }else if(num5 == 0) {
         neutro++;
     }else {
         negativo++;
     }

     printf("\n No total foram:\n\nPositivos: %d\nNegativos: %d\nNeutros: %d\n", positivo, negativo, neutro);

    /*

     printf("---------------------------------------------------------------------\n");
     printf("---------------------------EXERCICIO 1 -----------------------------\n");
     printf("------------------Estruturas de decisão e seleção--------------------\n");

     printf("1) Escreva um programa em C que leia três valores e apresente qual é o maior e qual é o menor.\n");

     int num1, num2, num3, maior, menor;

     printf("\nDigite 3 valores inteiros: ");
     scanf("%d%d%d", &num1, &num2, &num3);

     if(num1 >= num2 && num1 >= num3){
         maior = num1;
     }else if(num2 >= num3){
         maior = num2;
     }else {
         maior = num3;
     }

     if(num1 <= num2 && num1 <= num3){
         menor = num1;
     } else if (num2 <= num3){
         menor = num2;
     } else {
         menor = num3;
     }

     printf("\n\nMaior: %d", maior);
     printf("\nMenor: %d\n", menor);

     int opcao;

     printf("1 - Cadastrar produto\n2 - Vender produto\n3 - Buscar produto\n4 - Imprimir relatório\n0 - Sair\n");
     scanf("%d", &opcao);

     switch(opcao){
     case 1:
         printf("\nProduto cadastrado.\n");
         break;
     case 2:
         printf("\nProduto vendido.\n");
         break;
     case 3:
         printf("\nBuscando produto...\n");
         break;
     case 4:
         printf("\nImprimindo relatório...\n");
         break;
     case 0:
         printf("\nSaindo do programa...\n");
         break;
     default:
         printf("\nOpção inválida!\n");

     }
     int idade;

     printf("\nDigite sua idade: ");
     scanf("%d", &idade);

     if(idade <= 5 || idade >= 60){
         printf("\nTem direito a gratuidade!");
     }else {
         printf("\nNão tem direito a gratuidade!");
     }

     int idade;
     char sexo;

     printf("\nDigite seu sexo (f ou m) e sua idade: ");
     scanf("%c%d", &sexo, &idade);

     if(sexo == 'm' && idade == 18){
         printf("Alistamento obrigatório!\n");
     }else {
         printf("Dispensado!\n");
     }

     int idade;
     char sexo;

     printf("\nDigite seu sexo (f ou m): ");
     scanf("%c", &sexo);

     if(sexo == 'm'){

         printf("\nDigite sua idade: ");
         scanf("%d", &idade);

         if(idade == 18){
             printf("Alistamento obrigatório!\n");
         }else {
             printf("\nDispensado");
         }
     } else {
         printf("\nMulheres são dispensadas");
     }

     if(a < 0){
         printf("\n\tValor é negativo\n");
     }else{
         if(a > 0)
             printf("\n\tO valor é positivo");
         else
             printf("\n\tO valor é zero");
     }

     int a;

     printf("\nDigite um valor qualquer: ");
     scanf("%d", &a);

     a < 0 ? printf("Verdadeiro") : printf("Falso");

     int a;

     printf("\nDigite um valor qualquer: ");
     scanf("%d", &a);

     if(a<0)
         printf("\n\tO número é negativo.\n");
     else if(a == 0)
         printf("\n\tO número é zero\n");
     else
         printf("\n\tO número é positivo.\n");


     int a = 10, b = 20;

     printf("\n\tResultado: %d\n\n", a != b);

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


