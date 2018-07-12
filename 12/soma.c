#include "stdio.h"
#include "stdlib.h"

int main(void) {
 int vetor[3] = {1,10,3};
 int tamanho = 3;
 int resposta;

 soma_vetor(vetor,tamanho, &resposta); 
 printf("Resultado: %d\n", resposta);

 return (1);
}