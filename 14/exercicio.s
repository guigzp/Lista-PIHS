.section .data
	abertura: .asciz "Produto Escalar entre dois vetores\n"
	mostra_resultado: .asciz "Produto Escalar = %d\n"
	vetor1: .int 1, 2, 3
	vetor2: .int 3, 2, 1
	tamanho: .int 3
	resultado: .int 0
	
.section .text

produto_escalar:
	movl 4(%esp), %eax		# Endereço primeiro vetor
	movl 8(%esp), %ebx		# Endereço segundo vetor
	movl 12(%esp), %ecx		# tamanho vetores


calcula:
	pushl %eax
	pushl %ebx

	movl (%eax), %eax
	movl (%ebx), %ebx
	imull %eax, %ebx
	addl %ebx, resultado

	popl %ebx
	popl %eax

	addl $4, %ebx
	addl $4, %eax

	loop calcula

	movl resultado, %ebx
	movl %ebx, 4(%esp)

ret

.global main

main:
	pushl $abertura
	call printf
	addl $4, %esp


	pushl tamanho
	pushl $vetor1
	pushl $vetor2
	call produto_escalar

	popl %eax
	pushl %eax
	pushl $mostra_resultado
	call printf

fim:
	pushl $0
	call exit
