	.section .data
	abertura: .asciz "Soma de elementos de um vetor\n"
	mostra_soma: .asciz "Soma = %d\n"
	formato: .asciz "%d"
	vetor: .int -3,2,3
	tamanho: .int 3
	soma: .double 0.0
	
.section .text

soma_vetor:
	movl 4(%esp), %eax
	movl 8(%esp), %ecx

realiza_soma:
	movl (%eax), %ebx
	addl %ebx, soma
	addl $4, %eax
	loop realiza_soma

	movl soma, %eax
	movl %eax, 4(%esp)
ret

.global main

main:
	pushl $abertura
	call printf
	addl $4, %esp

	pushl tamanho
	pushl $vetor
	call soma_vetor

	popl %eax
	pushl %eax
	pushl $mostra_soma
	call printf

	addl $8, %esp



fim:
	pushl $0
	call exit
