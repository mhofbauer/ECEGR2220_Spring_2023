.data
	val1: .word 0xFFFF0000  
  	val2: .word 0x0000FFFF
  	val3: .word 0x00000003
.text
lw a1,val1
lw a2,val2
lw a3,val3

add a0,a1,a2 		#result:a0	10	0xffffffff
sub a0,a1,a2 		#result:a0	10	0xfffe0001
addi a0,a1,55 		#result:a0	10	0xffff0037
and a0,a1,a1 		#result:a0	10	0xffff0000
andi a0, a1, 0x000000FF	#result:a0	10	0x00000000
or a0, a1, a2  		#result:a0	10	0xffffffff
ori a0,a1, 0x000000FF	#result:a0	10	0xffff00ff
sll a0,a1,a3		#result:a0	10	0xfff80000
slli a0,a1,0x00000001	#result:a0	10	0xfffe0000
srl a0,a1,a3		#result:a0	10	0x1fffe000
srli a0,a1,0x00000002	#result:a0	10	0x3fffc000
