#Hofbauer Lab1 part1
.data
Z:	.word 	0
.text
main:

addi	t0, zero,15 	#value for int A
addi	t1, zero,10 	#value for int B
addi	t2, zero,5 	#value for int C
addi	t3, zero,2 	#value for int D
addi	t4, zero,18 	#value for int E
addi	t5, zero,-3 	#value for int F

sub	a0,t0,t1	#(A-B) into a0
mul	t6,t2,t3	#(C*D) into temp6

add	a0,a0,t6	#(A-B) + (C*D) into a0

sub	t6,t4,t5	#(E-F) into t6

add	a0,a0,t6	#Adds (E-F) to returned value

div	t6,t0,t2	#divides (A/C) into t6

sub	a0,a0,t6	#subtracts return value by (A/C) for final value

sw	a0, Z, t6		#Saves a0 (return value) into Z with t7 as a temp 

#END
