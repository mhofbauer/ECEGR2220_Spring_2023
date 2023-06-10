#Celsius = (Fahrenheit – 32.0) x 5.0 / 9.0
#Kelvin = Celsius + 273.15

.data
userInReq:	.asciz	"Enter the Temperture in Degrees : "
outCel:		.asciz 	"Value in Celcius : "
outKel:		.asciz 	"Value in Kelvin : "
newln:	.asciz	"\r\n"

fpCel:	.float	32.0
fpCel1:	.float	5.0
fpCel2:	.float	9.0

fpKel: .float	273.15

		
	.text
main:	
	jal	celsius		# the call to the function
	jal	kelvin
Exit:
	li  a7,10       #system call for an exit
	ecall
	
#end main _________________________________________________

#function celsius
.globl celsius

celsius:
	li	a7,4		#system call for print string
	la	a0,userInReq
	ecall
	li	a7,6		#system call for reading floating point
	ecall
	
	fmv.s	ft0,fa0		#save result in ft0
	
	flw 	ft1,fpCel, t0 	#loads 32.0 into 
	flw 	ft2,fpCel1, t0 	#loads 5.0 into ft2
	flw	ft3,fpCel2, t0	#loads 9.0 into ft3
	
	fsub.s	ft1,ft0,ft1 	#does userin - 32.0
	fmul.s	ft1,ft1,ft2	#(user-32.0) * 5
	fdiv.s	ft1,ft1,ft3	#((user-32.0) * 5) / 9
	
	fmv.s	fa0, ft1	#moves ft1 to fa0 for the save
	
	fsw fa0, fpCel, t0	#saves result of calcs to fpCel
	
	li	a7,4			#system call for print string
	la	a0,outCel
	ecall
	li	a7,2			#system call for printing float fa0 in ascii
	ecall
	li	a7,4			#system call for print string
	la	a0,newln
	ecall
	
	ret
#end fucntion clesius

#function kelvin
.globl kelvin

kelvin:
	
	flw 	ft0,fpCel, t0 	#loads value saved for Celsius into ft0
	flw 	ft1,fpKel, t0 	#loads 273.0 for conversion forumula
	
	fadd.s	ft1,ft0,ft1 	#does celsius + 273.15
	
	fmv.s	fa0, ft1	#moves ft1 to fa0 for the save
	
	fsw fa0, fpKel, t0	#saves result of calcs to fpCel
	
	li	a7,4			#system call for print string
	la	a0,outKel
	ecall
	li	a7,2			#system call for printing float fa0 in ascii
	ecall
	li	a7,4			#system call for print string
	la	a0,newln
	ecall
	
	ret
#end fucntion kelvin


