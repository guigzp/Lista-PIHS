.section .data
	soma: .int 0

.section .text

.global soma_vetor

soma_vetor:
	movl 4(%esp), %eax
	movl 8(%esp), %ecx
	movl 12(%esp), %edx

realiza_soma:
	movl (%eax), %ebx
	addl %ebx, soma
	addl $4, %eax
	loop realiza_soma

	movl soma, %eax
	movl %eax, (%edx)
ret

