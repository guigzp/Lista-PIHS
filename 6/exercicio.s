.section .data
	abertura: .asciz "Mostrar Sequência de Fibonacci\n"
	quantidade: .int 0
	pede_quantidade: .asciz "Digite a quantidade de termos: "
	formato: .asciz "%d"
	mostra_fib: .asciz "Sequência: %d"
	mostra_valor: .asciz " %d"
	atual: .int 1
	aux: .int 0
	
.section .text

fibonacci:
	movl 4(%esp), %ecx
	subl $1, %ecx

	pushl %ecx

	pushl atual
	pushl $mostra_fib
	call printf
	
	addl $8, %esp
	popl %ecx


	cmpl $0, %ecx
	je termina

mostra:
	pushl %ecx

	movl aux, %eax
	movl atual,  %ebx
	addl %ebx, %eax
	movl %eax, atual
	movl %ebx, aux

	pushl atual
	pushl $mostra_valor
	call printf

	
	addl $8, %esp
	popl %ecx

	loop mostra

termina:

ret

.global main

main:
	pushl $abertura
	call printf
	addl $4, %esp

	pushl $pede_quantidade
	call printf

	pushl $quantidade
	pushl $formato
	call scanf

	addl $12, %esp


	pushl quantidade
	call fibonacci 

fim:
	pushl $0
	call exit
