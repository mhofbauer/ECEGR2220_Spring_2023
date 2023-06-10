.data
A:	.word  3
B:	.word  10
C:	.word  20
newln:	.asciz	"\r\n"

.text
main:
#fibo(A)
lw 	a0,A
jal 	ra, fibo

li a7,1
ecall				#prints result for convience
mv	a2,a0			#moves reult into a2 as a0 

li	a7,4			#call for print new line
la	a0,newln
ecall
	
#fibo(B)
lw 	a0,B
jal 	ra, fibo

li a7,1
ecall				#prints result for convience
mv	a3,a0			#moves reult into a2 as a0 

li	a7,4			#call for print new line
la	a0,newln
ecall
#fibo(C)
lw 	a0,C
jal 	ra, fibo

li a7,1
ecall				#prints result for convience
mv	a4,a0			#moves reult into a2 as a0

li 	a7,10
ecall				#exit call
#end main

fibo:
beq	a0,zero, fibo_end		#jumps to our if statement being true (base case 1)
addi	t0,zero,1		#loads 1 into t0 for branch when testing base case 2
beq	a0,t0, fibo_end		#jumps to end for our if else 

fibo_recursive:
addi 	sp,sp,-8
sw	a0, 0(sp)		#saving an function internal value for recursion
sw 	ra, 4(sp)		#saving the return address onto the stack

addi 	a0,a0,-1		#fibo(a-1)
jal	fibo			#calls fibo(a-1)

lw	s0, 0(sp)		#moves a0 result to s2
sw	a0, 0(sp)		#saves fibo(a-1)

addi	a0,s0,-2		#does fibo(a-2) with orginal a0-2
jal	fibo			#calls fibo(a-2)


lw	s0, 0(sp)		#pulling fibo(a-1) value off stack
add	a0,a0,s0		#adds fibo(a-1)+fibo(a-2)


lw 	ra, 4(sp)		#loads the adress of return address from stack and jumps to it
addi	sp,sp,8

fibo_end:
				#base case reuturns starting value for both so we don't need to worry about setting a result			
ret

#end fibo
