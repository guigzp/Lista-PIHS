.section .data
	abertura: .asciz "Calculo de PA ou PG\n\n1) PA \n2) PG\nDigite sua opcao: "
	soma: .int 0
	razao: .int 0
	n: .int 0
	inicial: .int 0
	opcao: .int 0
	formato: .asciz "%d"
	mostra_valor: .asciz " %d"
	mostra_pa: .asciz "PA: %d"
	mostra_pg: .asciz "PG: %d"
	mostra_soma: .asciz "\nSoma: %d\n"
	pede_inicial: .asciz "\Digite o valor inicial: "
	pede_quantidade: .asciz "\nDigite a quantidade de termos: "
	pede_razao: .asciz "\nDigite a razão: "
	opcao_invalida: .asciz "\nOpção inválida"
.section .text

calcula_pa:
	movl 4(%esp), %eax
	movl %eax, inicial
	movl %eax, soma
	movl 8(%esp), %eax
	movl %eax, razao
	movl 12(%esp), %eax
	movl %eax, n

	pushl inicial
	pushl $mostra_pa
	call printf
	addl $8, %esp

	movl n, %ecx
	subl $1, %ecx

	movl razao, %eax

loop_calculo_pa:
	pusha
	addl %eax, inicial
	pushl inicial
	pushl $mostra_valor
	call printf
	addl $8, %esp
	movl inicial, %eax
	addl %eax, soma
	popa
	loop loop_calculo_pa

	movl soma, %eax
	movl %eax, 4(%esp)

ret

calcula_pg:
	movl 4(%esp), %eax
	movl %eax, inicial
	movl %eax, soma
	movl 8(%esp), %eax
	movl %eax, razao
	movl 12(%esp), %eax
	movl %eax, n

	pushl inicial
	pushl $mostra_pg
	call printf
	addl $8, %esp

	movl n, %ecx
	subl $1, %ecx

	movl razao, %eax

loop_calculo_pg:
	pusha
	mov razao, %ax
	mull inicial
	mov %ax, inicial
	pushl inicial
	pushl $mostra_valor
	call printf
	addl $8, %esp
	movl inicial, %eax
	addl %eax, soma
	popa
	loop loop_calculo_pg

	movl soma, %eax
	movl %eax, 4(%esp)

ret

.global main

main:

	pushl $abertura
	call printf

	pushl $opcao
	pushl $formato
	call scanf

	pushl $pede_inicial
	call printf

	pushl $inicial
	pushl $formato
	call scanf

	pushl $pede_quantidade
	call printf

	pushl $n
	pushl $formato
	call scanf

	pushl $pede_razao
	call printf

	pushl $razao
	pushl $formato
	call scanf

	addl $48, %esp

	movl opcao, %eax
	cmpl $1, %eax
	je chama_pa
	cmpl $2, %eax
	je chama_pg

	pushl $opcao_invalida
	call printf
	jmp fim

chama_pa:
	pushl $n
	pushl $razao
	pushl $inicial
	call calcula_pa
	jmp mostra
chama_pg:
	pushl $n
	pushl $razao
	pushl $inicial
	call calcula_pg

mostra:
	popl %eax

	pushl %eax
	pushl $mostra_soma
	call printf
	addl $8, %esp
fim:
	pushl $0
	call exit
