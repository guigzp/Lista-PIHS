.section .data
	abertura: .asciz "Comparar dois vetores\n"
	formato: .asciz "%d"
	mensagem_iguais: .asciz "Os vetores são iguais!\n"
	mensagem_diferentes: .asciz "Os vetores diferem na posição: %d\n"
	vetor1: .int 1,2,3
	vetor2: .int 1,5,3
	tamanho: .int 3
	posicao: .int 1
	
.section .text

compara:
	movl 4(%esp), %eax		# Endereço primeiro vetor
	movl 8(%esp), %ebx		# Endereço segundo vetor
	movl 12(%esp), %ecx     # tamanho dos vetores

percorre:
	pushl %eax
	pushl %ebx

	movl (%eax), %eax
	movl (%ebx), %ebx
	cmpl %eax, %ebx
	jne sao_diferentes

	popl %ebx
	popl %eax
	addl $4, %eax
	addl $4, %ebx
	addl $1, posicao
	loop percorre
	movl %ecx, posicao
	jmp coloca_posicao

sao_diferentes:
	addl $8, %esp

coloca_posicao:
	movl posicao, %eax
	movl %eax, 4(%esp)

ret

.global main

main:
	pushl $abertura
	call printf
	addl $4, %esp


	pushl tamanho
	pushl $vetor2
	pushl $vetor1
	call compara

	popl %eax
	cmpl $0, %eax
	je iguais

diferentes:
	pushl %eax
	pushl $mensagem_diferentes
	call printf
	jmp fim

iguais:
	pushl $mensagem_iguais
	call printf

fim:
	pushl $0
	call exit
