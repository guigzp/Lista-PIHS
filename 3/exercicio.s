.section .data
	abertura: .asciz "Calculadora Básica de Ponto Flutuante \n\nMenu: \n1) Adição \n2) Subtração \n3) Divisão \n4) Multiplicação\n"
	pede_menu: .asciz "\nDigite sua opção: "
	escolha: .int 0
	x: .double 0.0
	y: .double 0.0
	pede_x: .asciz "\nDigite o primeiro valor: "
	pede_y: .asciz "\nDigite o segundo valor: "
	pede_dividendo: .asciz "\nDigite o dividendo: "
	pede_divisor: .asciz "\nDigite o divisor (Diferente de 0) "
	valor_invalido: .asciz "Valor inválido, digite novamente\n"
	formato_double: .asciz "%lf"
	formato_int: .asciz "%d"
	resultado: .asciz "\nResultado = %.2lf \n"

.section .text

.global main

main:
	pushl $abertura
	call printf

menu:

	pushl $pede_menu
	call printf

	pushl $escolha
	pushl $formato_int
	call scanf

	addl $12, %esp		# limpa pilha

	cmpl $0, escolha
	jle escolha_errada
	cmpl $5, escolha
	jge escolha_errada
	cmpl $3, escolha
	je pede_divisao
	jmp pede_valores

escolha_errada:
	pushl $valor_invalido
	call printf
	addl $4, %esp
	jmp menu


pede_valores:
	pushl $pede_x
	call printf

	pushl $x
	pushl $formato_double
	call scanf

	addl $12, %esp

	pushl $pede_y
	call printf

	pushl $y
	pushl $formato_double
	call scanf

	addl $12, %esp

	cmpl $1, escolha
	je soma
	cmpl $2, escolha
	je sub
	cmpl $4, escolha
	je mul

pede_divisao:
	pushl $pede_dividendo
	call printf

	pushl $x
	pushl $formato_double
	call scanf

	addl $12, %esp

divisor:
	
	pushl $pede_divisor
	call printf

	pushl $y
	pushl $formato_double
	call scanf

	addl $12, %esp

	jmp div

soma:
	fldl x
	fldl y
	fadd %st(1), %st(0)
	jmp printa_resultado

sub:
	fldl y
	fldl x
	fsub %st(1), %st(0)
	jmp printa_resultado

mul:
	fldl x
	fldl y
	fmul %st(1), %st(0)
	jmp printa_resultado

div:
	fldl y
	fldl x
	fdiv %st(1), %st(0)
	jmp printa_resultado

printa_resultado:
	subl $8, %esp
	fstl (%esp)
	pushl $resultado
	call printf
	addl $4, %esp
	

fim:
	pushl $0
	call exit
