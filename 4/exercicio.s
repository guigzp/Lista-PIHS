.section .data
	abertura: .asciz "Acha o Maior e Menor valor dentro de um vetor"
	vetor: .int 0,12,-5,4
	tam_vetor: .int 4
	mostra_maior: .asciz "\nMaior: %d"
	mostra_menor: .asciz "\nMenor: %d\n"
	maior: .int 0
	menor: .int 0
.section .text

calcula_maior_menor:
	popl %edi		# Endereço de retorno da função
	popl %eax		# Parametro passado pela função
	pushl %edi		# Devolvendo o parametro passado pela função
	movl (%eax), %ebx
	movl %ebx, maior
	movl %ebx, menor

	movl $3, %ecx

loop_calcula_maior_menor:
	addl $4, %eax
	movl (%eax), %ebx
	cmpl %ebx, maior
	jge compara_menor

troca_maior:
	movl %ebx, maior

compara_menor:
	cmpl %ebx, menor
	jle termina_loop

troca_menor:
	movl %ebx, menor

termina_loop:
	loop loop_calcula_maior_menor

	pushl menor
	pushl maior
	pushl %edi

ret

ret

.global main

main:
	pushl $abertura
	call printf
	addl $4, %esp

	pushl $vetor

	call calcula_maior_menor

	popl %eax

	pushl %eax
	pushl $mostra_maior
	call printf

	addl $8, %esp
	
	popl %eax

	pushl %eax
	pushl $mostra_menor
	call printf

fim:
	pushl $0
	call exit
