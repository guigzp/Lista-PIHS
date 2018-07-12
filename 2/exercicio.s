.section .data
	abertura: .asciz "Ordenar Vetor\n"
	formato: .asciz " %d"
	vetor_inicio: .asciz "Vetor Inicial:"
	vetor_ordenado: .asciz "\nVetor Ordenado:"
	pula_linha: .asciz "\n"
	vetor: .int 10,5,3
	tamanho: .int 3
	atual: .int 0
	
.section .text

mostra_vetor:
	movl $vetor, %eax
	movl tamanho, %ecx

printa_vetor:
	pushl %eax
	pushl %ecx
	movl (%eax), %eax
	pushl %eax
	pushl $formato
	call printf
	addl $8, %esp
	popl %ecx
	popl %eax
	addl $4, %eax
	loop printa_vetor
ret

bubble_sort:
	movl 4(%esp), %eax		# endereço
	movl 8(%esp), %ecx		# tamanho

ordena:
	pushl %eax
	movl (%eax), atual
	movl %eax, %ebx
ordena_interno:
	pushl %ebx
	movl (%ebx), %ebx
	cmpl atual, %ebx


.global main

main:
	pushl $abertura
	call printf
	addl $4, %esp

	pushl $vetor_inicio
	call printf

	call mostra_vetor

	addl $4, %esp


	pushl tamanho
	pushl $vetor
	call bubble_sort

	addl $8, %esp

	pushl $vetor_ordenado
	call printf
	addl $4, %esp

	call mostra_vetor

	pushl $pula_linha
	call printf
	addl $4, %esp

fim:
	pushl $0
	call exit
