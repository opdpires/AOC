#include<stdio.h>
int fib(int n)
{
   if (n <= 1)
      return n;
   return fib(n-1) + fib(n-2);
}
 
int main ()
{
  int n = 0;
  printf("Digite um numero natural para obter o termo correspondente na serie de Fibonacci: ");
  scanf("%d", &n);
  printf("Resultado: %d", fib(n));
  printf("\nAperte uma tecla para sair");
  getchar();	//Faz com que o programa espere o usuário
  		//digitar algo antes de terminar o programa
  return 0;
}
