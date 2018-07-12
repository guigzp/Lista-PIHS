.section .data
	pede_tamanho: .asciz "Digite o tamanho do vetor: "
	pula_linha: .asciz "\n"
	tamanho: .int 0
	formato_int: .asciz "%d"
	vetor: .int 0
	pede_elem: .asciz "Digite um valor: "
	aux: .int 0
	soma: .int 0
	media: .int 0
	abaixo_media: .int 0
	mostra_media: .asciz "Media = %d\n"
	mostra_abaixo_media: .asciz "Abaixo da Media: %d\n"

.section .text

.global main

main:
	pushl $pede_tamanho
	call printf

	pushl $tamanho
	pushl $formato_int
	call scanf

	addl $12, %esp

	movl $4, %eax

	movl tamanho, %ebx

	imull %eax, %ebx

	pushl %ebx
	call malloc
	
	movl %eax, vetor

	movl tamanho, %ecx
	movl %eax, %edi

preenche_vetor:
	push %ecx

	pushl $pede_elem
	call printf

	pushl $aux
	pushl $formato_int
	call scanf

	movl aux, %eax
	addl %eax, soma

	movl %eax, (%edi)
	addl $4, %edi
	addl $12, %esp
	popl %ecx
	loop preenche_vetor

	movl soma, %eax
	movl $0, %edx
	movl tamanho, %ebx
	divl %ebx
	movl %eax, media

	pushl media
	pushl $mostra_media
	call printf

	movl vetor, %edi
	movl tamanho, %ecx

procura_vetor:
	push %ecx

	movl media, %eax
	cmpl %eax, (%edi)
	jge continua
	addl $1, abaixo_media

continua:
	addl $4, %edi
	loop procura_vetor

	pushl abaixo_media
	pushl $mostra_abaixo_media
	call printf
	

fim:
	pushl $0
	call exit
