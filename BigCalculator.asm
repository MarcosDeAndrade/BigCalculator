	.data
	
	#===============================================================================================================#
	#	Este proyecto fue realizado por Samuel Boada y Marcos De Andrade, estudiantes de Ingenieria		#	
	#	en Sistemas en la Universidad Metropolitana de Caracas Venezuela; en la asignatura Organizacion		#	
	#	del Computador dictada por el profesor Rafael Matienzo junto con el preparador Gabriele Lafiagiola	#
	#	                                                                                                        #
	#											trimestre 1819-1	#
	#===============================================================================================================#	


	#-------------------------------------------------  ENUNCIADO  -------------------------------------------------# 
	#	     Se desea implementar aritmetica de numeros largos manejados o representados como cadenas	        #
	#	     de caracteres ascii de hasta 50 digitos (positivos y negativos) inlcuyendo los decimales	        #
	#	     (si los hibiese). Debe poder manejarse 2 decimales asumnidos.					#
	#													        #
	#	     El programa debe sumar, restar y multiplicar enteros largos, teniendo cuidado de mantener	        #
	#	     consistencia con los decimales asumidos.							        #
	#---------------------------------------------------------------------------------------------------------------#

entrada:	.asciiz "-------------------------------------------------|    CALCULADORA BASICA    |-------------------------------------------------\n     Este programa fue elaborado por( Samuel Boada y Marcos De Andrade ), estudiantes de la Universidad Metropolitana de\n     Caracas Venezuela, en la asignatura de Organización del Computador, dictada por el profesor Rafael Matienzo con la\n     ayuda del preparador Gabriele Lafigliola. \n\n"	
descripcion:	.asciiz "Descripcion: El siguiente programa es una calculadora capaz de realizar 3 operaciones basicas, suma, resta y mutiplicación.\nPuede operar hasta 50 digitos en cuanto a la suma y resta, y hasta 25 digitos en cuanto a la multiplicación.               \nSiga todas las instrucciones para el correcto funcionamiento en cuanto al calculo de que desee operar.\n-----------------------------------------------------------------------------------------------------------------------------\n"	

saludo:		.asciiz "Ingrese primer numero \n"
saludo2:	.asciiz "\nIngrese segundo numero \n"
salto:		.asciiz "\n"


res:		.asciiz "\nResultado: "
num1:		.asciiz "\n     Num1: "
num2:		.asciiz "\n     Num2: "
aca:		.asciiz "\nAcarreo Pos: "

mas:		.asciiz " + "
menos:		.asciiz " - "
por:		.asciiz " x "
igual:		.asciiz " = "

con_acarreo:	.asciiz " ...con acarreo = "
uso:		.asciiz " ...uso: "
resi:		.asciiz "\nAcarreo: "

pos_coma:	.asciiz "\n , "

num1_mayor:	.asciiz "\nNumero 1 Mayor "
num2_mayor:	.asciiz "\nNumero 2 Mayor "
num_iguales:	.asciiz "\nNumeros Iguales"

sum_aca:	.asciiz "\nsumar_acarreo_final\n"
Syntax_Error:	.asciiz "\nSyntax Error X.X\n"

menu:		.asciiz "\n (1) Sumar            (Máximo 50 dígitos por Número - Incluyendo Decimales)\n (2) Restar           (Máximo 50 dígitos por Número - Incluyendo Decimales)\n (3) Multiplicar      (Máximo 25 dígitos por Número - Incluyendo Decimales) \n (4) Dividir\n\n"
invalido:	.asciiz "\nOpción Inválida... No sabes escribir?!"
version_beta:	.asciiz "\nOpción Única para Cuentas Premium y Superiores \n"

zero:		.byte 0x30
uno:		.byte 0x31
diez:		.byte 0x0a
coma:		.byte 0x2c
null:		.byte 0x00

numero1:	.space 51
numero2:	.space 51
resultado:	.space 55

	.text
	
		#--------------------  Inicializacion de Registros  ---------------------#
	
				li $s0, 0	
				li $s1, 0	
				li $s2, 0	
				li $s3, 0	
				li $s4, 0	
				li $s5, 1	
				li $s6, 1	
				li $s7, 1	
	
				li $t0, 50	
				li $t1, 0	# Numero 1
				li $t2, 0	# Numero 2
				li $t3, 0	# Resultado
				li $t4, 0	
				li $t5, 0	# Opcion Menu | Acarreo
	
clean_resultado: 		lb   $t3, null
		 		sb   $t3, resultado ($t0)
		 		subi $t0, $t0, 1
		 		bgez $t0, clean_resultado
		 		li $t0, 0
	 	 		j Insert_Opciones
	 	 
clean_numero1: 	 		lb   $t3, null
				sb   $t3, numero1 ($t0)
				subi $t0, $t0, 1
				bgez $t0, clean_numero1
		 		li $t0, 0
		 		jr $ra
		 		
shift_numero1_izq:		li $t0, 1
				li $t4, 0
				
loop_shift1:			lb   $t1, numero1($t0)
				lb   $t3, null
				sb   $t3, numero1($t0)
				sb   $t1, numero1($t4)
				addi $t0, $t0, 1
				addi $t4, $t4, 1
				blt  $t4, $s3, loop_shift1
				subi $s1, $s1, 1
				subi $s3, $s3, 1
				jr   $ra
		 
clean_numero2: 	 		lb   $t3, null
				sb   $t3, numero2 ($t0)
				subi $t0, $t0, 1
				bgez $t0, clean_numero2
				li $t0, 0
				jr $ra
				
shift_numero2_izq:		li $t0, 1
				li $t4, 0
				
loop_shift2:			lb   $t1, numero2($t0)
				lb   $t3, null
				sb   $t3, numero2($t0)
				sb   $t1, numero2($t4)
				addi $t0, $t0, 1
				addi $t4, $t4, 1
				blt  $t4, $s4, loop_shift2
				subi $s2, $s2, 1
				subi $s4, $s4, 1
				jr   $ra
		 
add_cero_en_uno:		move $t0, $s3
				addi $t4, $t0, 1
				bnez $t2, loop_cero_en_uno
				b revisa
loop_cero_en_uno:		lb   $t1, numero1($t0)
				lb   $t3, zero
				sb   $t3, numero1($t0)
				sb   $t1, numero1($t4)
				subi $t0, $t0, 1
				subi $t4, $t4, 1
				bgez $t0, loop_cero_en_uno
				lb   $t3, zero
				sb   $t3, numero1($t0)
				addi $s1, $s1, 1
				addi $s3, $s3, 1
				j revisa
				
add_cero_en_uno2:		move $t0, $s4
				addi $t4, $t0, 1
				bnez $t2, loop_cero_en_dos
				b revisa2
loop_cero_en_dos:		lb   $t1, numero2($t0)
				lb   $t3, zero
				sb   $t3, numero2($t0)
				sb   $t1, numero2($t4)
				subi $t0, $t0, 1
				subi $t4, $t4, 1
				bgez  $t0, loop_cero_en_dos
				lb   $t3, zero
				sb   $t3, numero2($t0)
				addi $s2, $s2, 1
				addi $s4, $s4, 1
				j revisa2
	 	 
Insert_Opciones:		
				li   $v0,4
				la   $a0, entrada
				syscall

				li   $v0,4
				la   $a0, descripcion
				syscall

				li   $v0,4
				la   $a0, menu
				syscall
						
				li  $v0, 5
				syscall
				move $t9, $v0
				
				beq $t9, 1, datos
				beq $t9, 2, datos
				beq $t9, 3, datos
				beq $t9, 4, falso
				b Error
				
Error:				li $v0, 4
				la $a0, invalido
				syscall
				b Insert_Opciones

# ----------------------------------------   Datos   ----------------------------------------#

datos:		
		Insert_Num1:	li $v0, 4
				la $a0, saludo
				syscall
	
				li $v0, 8
				la $a0, numero1
				la $a1, 51
				syscall
		
				j digitos1
	
		Insert_Num2:	li $v0, 4
				la $a0, saludo2
				syscall
			
				li $v0, 8
				la $a0, numero2
				la $a1, 51
				syscall
				
				j digitos2
	
# ----------------------------------------   Procesos   ----------------------------------------#

reset:			#	Resetear Registros
				li $t0, 0
				li $t1, 0
				li $t2, 0
				li $t3, 0
				li $t4, 0
				li $t5, 0
				li $t6, 0
				li $t7, 0
				li $t8, 0
				
				jr $ra
				
		
digitos1:		#	Digitos de N1
	loop_digitos1:		lb   $t1, numero1($s3)
				blt  $t1, 0x30, validacion_digito
				bgt  $t1, 0x39,	validacion_digito
				beq  $t2, 1, sumar_decimal
	  parte1_2:		addi $s3, $s3, 1
	  			bne  $t9, 3, validacion_no_pasar_50
	  			beq  $t9, 3, validacion_no_pasar_25	
	  parte1_3:		j loop_digitos1

validacion_no_pasar_50:		bgt  $s3, 50, error_digito
				j parte1_3

validacion_no_pasar_25:		bgt  $s3, 25, error_digito
				b parte1_3

validacion_digito:
				beq  $t1, 0x2c, guardarcoma1
				beq  $t1, 0x0a, revisar_decimal
				beq  $t1, 0x2d, numero1_negativo
				b error_digito

numero1_negativo:		li $s5, 0
				j parte1_2

error_digito:
				li $v0, 4
				la $a0, Syntax_Error
				syscall
				
				jal clean_numero1
				
				li $s3, 0
				
				j Insert_Num1
				
guardarcoma1:		#	Guardar la Posicion de la coma de N1
				beq $t2, 1, error_digito
				move $s1, $s3
				li   $t2, 1
				j parte1_2
			
			#	Va contando la cantidad de decimales de N1	
sumar_decimal:		
				addi $t0, $t0, 1
				j parte1_2

quitar_negativo:		jal shift_numero1_izq
				j p2

revisar_decimal:	#	Revisar Decimal
				beqz $s5, quitar_negativo
		p2:		beq  $t2, 1, r2			#Si hay coma, revisar la cantidad de decimales
				beqz $t2, add_coma		#Si no hay coma, agregar los decimales 00
				
		r2:		beqz $s1, add_cero_en_uno
		revisa:		li   $t2, 0
				blt  $t0, 2, add_zero		 #Si la cantidad de decimales es menor a 2, agregar un 0
				bgt  $t0, 2, eliminar_dec_extra  #Si la cantidad de decimales es mayor a 2, eliminar los decimales restantes
				jal reset
				j Insert_Num2
		add_zero:	lb   $t3, zero
				sb   $t3, numero1($s3)
				addi $s3, $s3, 1
				lb   $t3, diez
				sb   $t3, numero1($s3)
				jal reset
				j Insert_Num2
				
		add_coma:	lb   $t3, coma
				sb   $t3, numero1($s3)
				li   $t0, 0
				move $s1,$s3
		coma2:		addi $s3, $s3, 1
				lb   $t3, zero
				sb   $t3, numero1($s3)
				addi $t0, $t0, 1
				blt  $t0, 2, coma2
				addi $s3, $s3, 1
				lb   $t3, diez
				sb   $t3, numero1($s3)
				jal reset
				j Insert_Num2
				
		eliminar_dec_extra:
				addi $s0, $s1, 3
		delete_2:	lb   $t3, null
				sb   $t3, numero1($s0)
				addi $s0, $s0, 1
				lb   $t3, numero1($s0)
				bne  $t3, 0x00, delete_2
				li   $s0, 0
				jal reset
				j Insert_Num2
		
digitos2:	  	#	Digitos de N2
	loop_digitos2:		lb   $t1, numero2($s4)
				blt  $t1, 0x30,	validacion_digito2
				bgt  $t1, 0x39,	validacion_digito2
				beq  $t2, 1, sumar_decimal2
	parte2_2:		addi $s4, $s4, 1
				beq  $t9, 3, validacion_no_pasar_25_2
	parte2_3:		j loop_digitos2

validacion_no_pasar_25_2:	bgt  $s4, 25, error_digito2
				b parte2_3

validacion_digito2:
				beq  $t1, 0x2c, guardarcoma2
				beq  $t1, 0x0a, revisar_decimal2
				beq  $t1, 0x2d, numero2_negativo	
				b error_digito2

numero2_negativo:		li $s6, 0
				j parte2_2

error_digito2:
				li $v0, 4
				la $a0, Syntax_Error
				syscall
				
				jal clean_numero2
				
				li $s3, 0
				
				j Insert_Num2
				
guardarcoma2:		#	Guardar la Posicion de la coma de N2
				beq $t2, 1, error_digito2
				move $s2, $s4
				li   $t2, 1
				j parte2_2
sumar_decimal2:
				addi $t0, $t0, 1
				j parte2_2

quitar_negativo2:		jal shift_numero2_izq
				j P2
								
revisar_decimal2:		beqz $s6, quitar_negativo2
		P2:		beq  $t2, 1, R2
				beqz $t2, Add_Coma
				
		R2:		beqz $s2, add_cero_en_uno2
		revisa2:	blt  $t0, 2, Add_Zero
				bgt  $t0, 2, eliminar_dec_extra_2
				jal reset
				b Correr_Coma
		Add_Zero:	lb   $t3, zero
				sb   $t3, numero2($s4)
				addi $s4, $s4, 1
				lb   $t3, diez
				sb   $t3, numero2($s4)
				jal reset
				j Correr_Coma
				
		Add_Coma:	lb   $t3, coma
				sb   $t3, numero2($s4)
				li   $t0, 0
				move $s2,$s4
		Coma2:		addi $s4, $s4, 1
				lb   $t3, zero
				sb   $t3, numero2($s4)
				addi $t0, $t0, 1
				blt  $t0, 2, Coma2
				addi $s4, $s4, 1
				lb   $t3, diez
				sb   $t3, numero2($s4)
				jal reset
				j Correr_Coma
				
		eliminar_dec_extra_2:
				addi $s0, $s2, 3
		delete2:	lb   $t3, null
				sb   $t3, numero2($s0)
				addi $s0, $s0, 1
				lb   $t3, numero2($s0)
				bne  $t3, 0x00, delete2
				li   $s0, 0
				jal reset 
				j Correr_Coma
				
Correr_Coma:		#	Definir numero de arriba para correr la coma
				lb  $t3, zero
				beq $s1, $s2, Guardar_Pos_Coma
				bgt $s1, $s2, numero1_arriba
				bgt $s2, $s1, numero2_arriba
	Guardar_Pos_Coma:	move $a1, $s1
				j Evaluar_Numeros		
		
numero1_arriba:		#	Correr numero 2 a la derecha para que las comas queden en la misma posicion
				sub  $t5, $s1, $s2
		loop1:		move $t1, $s4		
				addi $t2, $s4, 1	
		loop1_2:	lb   $t0, numero2($t1)	
				sb   $t3, numero2($t1)	
				sb   $t0, numero2($t2)	
				subi $t1, $t1, 1	
				subi $t2, $t2, 1	
				bgez $t1, loop1_2
				addi $s0, $s0, 1	
				addi $s4, $s4, 1	
				addi $s2, $s2, 1
				blt  $s0, $t5, loop1
				move $a1, $s1
				jal reset
				j Evaluar_Numeros
			
numero2_arriba:		#	Correr numero 1 a la derecha para que las comas queden en la misma posicion
				sub  $t5, $s2, $s1
		loop2:		move $t1, $s3
				addi $t2, $s3, 1
		loop2_2:	lb   $t0, numero1($t1)
				sb   $t3, numero1($t1)
				sb   $t0, numero1($t2)
				subi $t1, $t1, 1
				subi $t2, $t2, 1
				bgez $t1, loop2_2
				addi $s0, $s0, 1
				addi $s3, $s3, 1
				addi $s1, $s1, 1
				blt  $s0, $t5, loop2
				move $a1, $s2
				jal reset
				j Evaluar_Numeros

Evaluar_Numeros:		lb  $t1, numero1($zero)
				and $t1, $t1, 0x000f
				lb  $t2, numero2($zero)
				and $t2, $t2, 0x000f
								
				blt $t1, $t2, numero2_mayor
				blt $t2, $t1, numero1_mayor
				b Calcular_Mayor
			
		numero1_mayor:	la $a2, numero1_mayor
				
					#li $v0, 4
					#la $a0, num1_mayor
					#syscall
				
					#li $v0, 4
					#la $a0, salto
					#syscall
				
				li $s0, 1
				
				j Evaluar_Signo1
				
		numero2_mayor:	la $a2, numero2_mayor
				
					#li $v0, 4
					#la $a0, num2_mayor
					#syscall
				
					#li $v0, 4
					#la $a0, salto
					#syscall
				
				li $s0, 0
				
				j Evaluar_Signo2
				
		Calcular_Mayor:
				jal reset
				li   $t0, 1
			loopC:	lb   $t1, numero1($t0)
				and  $t1, $t1, 0x000f
				lb   $t2, numero2($t0)
				and  $t2, $t2, 0x000f
				bgt  $t1, $t2, numero1_mayor
				bgt  $t2, $t1, numero2_mayor
				beq  $t1, 0x0a, numero1_mayor
				addi $t0, $t0, 1
				b loopC

resultado_negativo:		li   $s7, 0
				jr   $ra

		#--------------------  Signo Numero 1 Mayor  ---------------------#
												
Evaluar_Signo1:			beq  $t9, 1, Revisar_Signo_Suma
				beq  $t9, 2, Revisar_Signo_Resta
				beq  $t9, 3, Revisar_Signo_Multiplicacion
				
Revisar_Signo_Suma:		beq $s5, $s6, revisar_negativo
				bne $s5, $s6, Signo_Suma
	revisar_negativo:	beqz $s5, negativo
				b Start_Suma
		negativo:	jal resultado_negativo
	      Start_Suma:	j sumar

	      Signo_Suma:	beqz $s5, Suma_Negativa
	      			b Resta_Num1_Mayor
	   Suma_Negativa:	jal resultado_negativo
	   			b Resta_Num1_Mayor

Revisar_Signo_Resta:		beq $s5, $s6, ver_negativo
				bne $s5, $s6, Revisar_Suma

	    ver_negativo:	beqz $s5, Resta_Negativa
	    			b Resta_Num1_Mayor
	  Resta_Negativa:	jal resultado_negativo
	     Start_Resta:	j Resta_Num1_Mayor
	     
	   Revisar_Suma:	beqz $s5, negativo

Revisar_Signo_Multiplicacion:	bne $s5, $s6, multiplicacion_negativa
				b Start_Multiplicacion
				
     multiplicacion_negativa:	jal resultado_negativo
        Start_Multiplicacion:	j multiplicar
						
		#--------------------  Signo Numero 2 Mayor  ---------------------#

Evaluar_Signo2:			beq  $t9, 1, Revisar_Signo_Suma2
				beq  $t9, 2, Revisar_Signo_Resta2
				beq  $t9, 3, Revisar_Signo_Multiplicacion
				
Revisar_Signo_Suma2:		beq $s5, $s6, revisar_negativo2
				bne $s5, $s6, Signo_Suma2
	revisar_negativo2:	beqz $s6, negativo2
				b Start_Suma2
		negativo2:	jal resultado_negativo
	      Start_Suma2:	j sumar

	      Signo_Suma2:	beqz $s6, Suma_Negativa2
	      			b Resta_Num2_Mayor
	   Suma_Negativa2:	jal resultado_negativo
	   			b Resta_Num2_Mayor
	   			
Revisar_Signo_Resta2:		beq $s5, $s6, ver_negativo2
				bne $s5, $s6, Revisar_Suma2

	    ver_negativo2:	beqz $s6, Resta_Negativa2
	    			b Resta_Num2_Mayor
	  Resta_Negativa2:	jal resultado_negativo
	     Start_Resta2:	j Resta_Num2_Mayor
	     
	     Revisar_Suma2:	beqz $s6, negativo2	
	     	
# ----------------------------------------   SUMA   ----------------------------------------#

		#--------------------  Registros usados en la operacion Suma -------------------#
		#										#
		#   	$s0	 								#
		#   	$s1	 								#
		#   	$s2	 								#	
		#   	$s3	 								#
		#   	$s4	 								#
		#    	$s5	 								#
		#    	$s6	 								#
		#    	$s7	 								#
		#	   	 								#
		#    	$t0	 								#	
		#    	$t1	    Numero 1	 						#
		#    	$t2	    Numero 2	 						#
		#    	$t3	    Resultado	 						#
		#   	$t4	 								#	
		#    	$t5	    Opcion Menu | Acarreo					#
		#		 								#
		#-------------------------------------------------------------------------------#


sumar:
				li $t4, 0
				
				li $v0, 4
				la $a0, salto
				syscall
				
				li   $v0, 1
				move $a0, $a1
				syscall
													
				addi $t0, $a1, 2
loopsuma:			lb   $t1,numero1($t0)
				beq  $t1,0x2c,print_coma
				andi $t1,$t1,0x000f
				lb   $t2, numero2($t0)
				andi $t2,$t2,0x000f
				
				li $v0, 4
				la $a0, salto
				syscall
				
				li   $v0, 1
				move $a0, $t1
				syscall
				
				li $v0, 4
				la $a0, mas
				syscall
				
				li   $v0, 1
				move $a0, $t2
				syscall
				
				li $v0, 4
				la $a0, igual
				syscall
				
				add  $t3,$t2,$t1
				
				li   $v0, 1
				move $a0, $t3
				syscall
				
				add  $t3,$t3,$t4
				
				li $v0, 4
				la $a0, con_acarreo
				syscall
				
				li   $v0, 1
				move $a0, $t3
				syscall
				
				li $v0, 4
				la $a0, salto
				syscall
				
				li   $t4,0
				bge  $t3,10,acarreo
				
loopsuma2:			ori  $t3,$t3,0x30
				sb   $t3, resultado($t0)
				
loopsuma3:			subi $t0, $t0,1
				
				bgez $t0, loopsuma
				bnez $t4, shift
				j imprimir

acarreo:			subi $t3,$t3,10
				li   $t4,1				
				j loopsuma2
				
print_coma:			sb $t1, resultado($t0)

				li $v0, 4
				la $a0, pos_coma
				syscall
				
				li $v0, 4
				la $a0, salto
				syscall
				
				j loopsuma3
				
shift:				addi $t4, $a1, 3
				addi $t0, $a1, 2
				
loop_shift:			lb   $t1, resultado($t0)
				lb   $t3, zero
				sb   $t3, resultado($t0)
				sb   $t1, resultado($t4)
				subi $t0, $t0, 1
				subi $t4, $t4, 1
				bgez $t0, loop_shift
				lb   $t3, uno
				sb   $t3, resultado($t4)
				j imprimir

# ----------------------------------------   RESTA   ----------------------------------------#

		#--------------------  Registros usados en la operacion Resta ------------------#
		#										#
		#   	$s0	 								#
		#   	$s1	 								#
		#   	$s2	 								#	
		#   	$s3	 								#
		#   	$s4	 								#
		#    	$s5	 								#
		#    	$s6	 								#
		#    	$s7	 								#
		#	   	 								#
		#    	$t0	 								#	
		#    	$t1	    Numero 1	 						#
		#    	$t2	    Numero 2	 						#
		#    	$t3	    Resultado	 						#
		#   	$t4	 								#	
		#    	$t5	    Opcion Menu | Acarreo					#
		#		 								#
		#-------------------------------------------------------------------------------#


restar:	
		#--------------------  Resta Numero 1 Mayor  ---------------------#
						
	Resta_Num1_Mayor:	li $v0, 4
				la $a0, salto
				syscall
				
				li   $v0, 1
				move $a0, $a1
				syscall
													
				addi $t0, $a1, 2
Resta1_Loop:			lb   $t1, numero1($t0)
				beq  $t1,0x2c,print_coma_resta
				andi $t1, $t1,0x000f
				lb   $t2, numero2($t0)
				andi $t2,$t2,0x000f
				bnez $t4, acarreo_resta
Resta1_Loop2:			blt  $t1, $t2, sumar_diez
Resta1_Loop3:			li   $v0, 4
				la   $a0, salto
				syscall
				
				li   $v0, 1
				move $a0, $t1
				syscall
				
				li $v0, 4
				la $a0, menos
				syscall
				
				li   $v0, 1
				move $a0, $t2
				syscall
				
				li $v0, 4
				la $a0, igual
				syscall
				
				sub  $t3,$t1,$t2
				
				li $v0, 1
				move $a0, $t3
				syscall
				
				or   $t3,$t3,0x30
				sb   $t3, resultado($t0)
				
Resta1_Loop4:			subi $t0, $t0, 1
				bgez $t0, Resta1_Loop
				j imprimir
				
		#--------------------  Resta Numero 2 Mayor  ---------------------#	
	
	Resta_Num2_Mayor:	li $v0, 4
				la $a0, salto
				syscall
				
				li   $v0, 1
				move $a0, $a1
				syscall
													
				addi $t0, $a1, 2
Resta2_Loop:			lb   $t1, numero2($t0)
				beq  $t1,0x2c,print_coma_resta
				andi $t1, $t1,0x000f
				lb   $t2, numero1($t0)
				andi $t2,$t2,0x000f
				bnez $t4, acarreo_resta
Resta2_Loop2:			blt  $t1, $t2, sumar_diez
Resta2_Loop3:			li   $v0, 4
				la   $a0, salto
				syscall
				
				li   $v0, 1
				move $a0, $t1
				syscall
				
				li $v0, 4
				la $a0, menos
				syscall
				
				li   $v0, 1
				move $a0, $t2
				syscall
				
				li $v0, 4
				la $a0, igual
				syscall
				
				sub  $t3,$t1,$t2
				
				li $v0, 1
				move $a0, $t3
				syscall
				
				or   $t3,$t3,0x30
				sb   $t3, resultado($t0)
				
Resta2_Loop4:			subi $t0, $t0, 1
				bgez $t0, Resta2_Loop
				j imprimir

		#-----------------------  Funciones Resta  -----------------------#

sumar_diez:
				addi $t1, $t1, 10
				li   $t4, 1
				bnez $s0, Resta1_Loop3
				b Resta2_Loop3

acarreo_resta:			beqz $t1, caso_zero
				subi $t1, $t1, 1
				li   $t4, 0				
				bnez $s0, Resta1_Loop2
				b Resta2_Loop2
				
caso_zero:			li $t1, 9
				bnez $s0, Resta1_Loop2
				b Resta2_Loop2
				
print_coma_resta:		sb $t1, resultado($t0)

				li $v0, 4
				la $a0, pos_coma
				syscall
				
				li $v0, 4
				la $a0, salto
				syscall
				
				bnez $s0, Resta1_Loop4
				b Resta2_Loop4
				
# ----------------------------------------   MULTIPLICACION   ------------------------------------------#

		#-------------------  Registros usados en la operacion Multiplicacion ------------------#
		#											#
		#   	$s0	 									#
		#   	$s1	 									#
		#   	$s2	 									#	
		#   	$s3	 									#
		#   	$s4	 									#
		#    	$s5	 									#
		#    	$s6	 									#
		#    	$s7	 									#
		#	   	 									#
		#    	$t0	 									#	
		#    	$t1	    Numero 1	 							#
		#    	$t2	    Numero 2	 							#
		#    	$t3	    Resultado	 							#
		#   	$t4	 									#	
		#    	$t5	    Opcion Menu | Acarreo						#
		#		 									#
		#---------------------------------------------------------------------------------------#

multiplicar:
				jal reset
				
			#	Elimina la coma del numero1
	eliminar_coma1:		addi $t0, $s1, 1
				move $t4, $s1
				li   $t2, 0
		loop_e1:	lb   $t1, numero1($t0)
				lb   $t3, null
				sb   $t3, numero1($t0)
				sb   $t1, numero1($t4)
				addi $t2, $t2, 1
				addi $t0, $t0, 1
				addi $t4, $t4, 1
				blt  $t2, 3, loop_e1
				subi $s3, $s3, 1
				b eliminar_coma2

			#	Elimina la coma del numero2
	eliminar_coma2:		addi $t0, $s2, 1
				move $t4, $s2
				li   $t2, 0
		loop_e2:	lb   $t1, numero2($t0)
				lb   $t3, null
				sb   $t3, numero2($t0)
				sb   $t1, numero2($t4)
				addi $t2, $t2, 1
				addi $t0, $t0, 1
				addi $t4, $t4, 1
				blt  $t2, 3, loop_e2
				subi $s4, $s4, 1	
				b inicio_multi
				

inicio_multi:			jal reset
				
				addi $t7, $s1, 1		
				addi $t8, $s1, 1		
				
				li $s0, 0
loop_mul:			beqz $s0, hacer_shift
				b loop_mul1
	hacer_shift:		jal shift_resultado
				
	loop_mul1:		li $s0, 0
				lb  $t1, numero1($t7)
				and $t1, $t1, 0x00f
				
	loop_digito:		lb  $t2, numero2($t8)
				and $t2, $t2,0x00f
				
					#------  Impresiones de verificacion  ------#
					#li $v0, 4
					#la $a0, salto
					#syscall
				
					#li $v0, 1
					#move $a0, $t1
					#syscall
				
					#li $v0, 4
					#la $a0, por
					#syscall
				
					#li $v0, 1
					#move $a0, $t2
					#syscall
				
					#li $v0, 4
					#la $a0, igual
					#syscall
					#-------------------------------------------#
				
				mul   $t3, $t1, $t2
					
					#------  Impresiones de verificacion  ------#
					#li $v0, 1
					#move $a0, $t3
					#syscall
					#-------------------------------------------#
				
				add   $t3, $t3, $t5		  		
				
					#------  Impresiones de verificacion  ------#
					#li $v0, 4
					#la $a0, con_acarreo
					#syscall
				
					#li $v0, 1
					#move $a0, $t3
					#syscall
					#-------------------------------------------#
				
				li $t5, 0
				bge   $t3, 10, acarreo_mult		
				
loop_m2:			lb  $t6, resultado($t8)		
				and $t6,$t6,0x00f
				
					#------  Impresiones de verificacion  ------#
					#li $v0, 4
					#la $a0, salto
					#syscall
				
					#li   $v0, 1
					#move $a0, $t3
					#syscall
				
					#li $v0, 4
					#la $a0, mas
					#syscall
				
					#li   $v0, 1
					#move $a0, $t6
					#syscall
				
					#li $v0, 4
					#la $a0, igual
					#syscall
					#-------------------------------------------#
						
				add $t3, $t3, $t6		
				
					#------  Impresiones de verificacion  ------#
					#li   $v0, 1
					#move $a0, $t3
					#syscall
					#-------------------------------------------#
				
				add $t3, $t3, $t4
				
					#------  Impresiones de verificacion  ------#
					#li $v0, 4
					#la $a0, con_acarreo
					#syscall
				
					#li $v0, 1
					#move $a0, $t3
					#syscall
					#-------------------------------------------#
				
				li  $t4, 0
				bge $t3, 10, acarreo_final
				
loop_m3:			or $t3,$t3,0x30
				sb  $t3, resultado($t8)		
					
				subi $t8,$t8,1	
				bgez $t8, loop_digito		
				bnez $t5, add_ultimo_digito
				
					#------  Impresiones de verificacion  ------#
					#li $v0, 4
					#la $a0, res
					#syscall
				
					#li $v0, 4
					#la $a0, resultado
					#syscall
					#-------------------------------------------#
				
loop_num1:			addi $t8, $s1, 1
				subi  $t7, $t7,1
				bgez $t7, loop_mul
				b insertar_coma
				
add_ultimo_digito:		li $s0, 1
				add $t5, $t5, $t4
				jal shift_resultado
				bge $t5, 10, otro_mas
				b add_final
		otro_mas:	subi $t5, $t5, 10
				or $t3, $t5, 0x30
				sb $t3, resultado($zero)
				li $t5, 0
				jal shift_resultado
				lb $t3, uno
				sb $t3, resultado($zero)
				
					#------  Impresiones de verificacion  ------#
					#li $v0, 4
					#la $a0, res
					#syscall
				
					#li $v0, 4
					#la $a0, resultado
					#syscall
					#-------------------------------------------#
				
				j loop_num1
				
		add_final:	or $t3, $t5, 0x30
				sb $t3, resultado($zero)
				li $t5, 0
				
					#------  Impresiones de verificacion  ------#
					#li $v0, 4
					#la $a0, res
					#syscall
				
					#li $v0, 4
					#la $a0, resultado
					#syscall
					#------------------------------------------#
				
				j loop_num1

		#		Shift una posicion a la derecha de resultado
shift_resultado:		mul  $t0, $s3, 2
				addi $t4, $t0, 1
loop_shift_mul:			lb   $t1, resultado($t0)
				lb   $t3, zero
				sb   $t3, resultado($t0)
				sb   $t1, resultado($t4)
				subi $t0, $t0, 1
				subi $t4, $t4, 1
				bgez $t0, loop_shift_mul
				addi $a1, $a1, 1
				li   $t4, 0
				jr   $ra
				
shift_izquierda:		li   $t0, 1
				li   $t4, 0			
loop_shift_mul2:		lb   $t1, resultado($t0)
				lb   $t3, null
				sb   $t3, resultado($t0)
				sb   $t1, resultado($t4)
				addi $t0, $t0, 1
				addi $t4, $t4, 1
				blt  $t0, 50, loop_shift_mul2
				li   $t4, 0
				jr   $ra

acarreo_mult:			div $t5, $t3, 10		# Divido el resultado de la multiplicacion entre 10 y el Low queda en $t3
				mfhi $t3			# El High queda en $t5
				
					#------  Impresiones de verificacion  ------#
					#li $v0, 4
					#la $a0, uso
					#syscall
				
					#li $v0, 1
					#move $a0, $t3
					#syscall
				
					#li $v0, 4
					#la $a0, resi
					#syscall
				
					#li $v0, 1
					#move $a0, $t5
					#syscall 
				
					#li $v0, 4
					#la $a0, salto
					#syscall
					#-------------------------------------------#
				
				j loop_m2
				
acarreo_final:			subi $t3, $t3, 10
				li $t4, 1
				
					#------  Impresiones de verificacion  ------#
					#li $v0, 4
					#la $a0, uso
					#syscall
				
					#li $v0, 1
					#move $a0, $t3
					#syscall
				
					#li $v0, 4
					#la $a0, resi
					#syscall
				
					#li $v0, 1
					#move $a0, $t4
					#syscall
					#-------------------------------------------#
				
				j loop_m3
													
revisar_ceros:			jal reset
				li $t0, 0
				lb  $t3, resultado($zero)
				beq $t3, 0x30, quitar_cero
				b print2
		quitar_cero:	jal shift_izquierda
				
					#------  Impresiones de verificacion  ------#
					#li $v0, 4
					#la $a0, res
					#syscall
				
					#li $v0, 4
					#la $a0, resultado
					#syscall
					#------------------------------------------#
				
				lb  $t3, resultado($zero)
				beq $t3, 0x30, quitar_cero
				b print2
								
insertar_coma:			jal reset
				mul $t4, $s3, 2
				subi $t4, $t4, 1
				subi $t0, $t4, 1
				li $t2, 0
		loop_insertar:	lb $t1, resultado($t0)
				lb $t3, zero
				sb $t3, resultado($t0)
				sb $t1, resultado($t4)
				subi $t0, $t0, 1
				subi $t4, $t4, 1
				addi $t2, $t2, 1
				blt $t2, 4, loop_insertar
				lb $t3, coma
				sb $t3, resultado($t4)
				j imprimir	
				
falso:				
				li $v0, 4
				la $a0, version_beta
				syscall
				
				j fin
				
# ----------------------------------------------------------------------------------------------------#
	
imprimir:
				j revisar_ceros
				
	print2:			beqz $s7, add_signo
				b print3
	add_signo:		jal shift_resultado
				jal reset
				li $t0, 1
				lb $t3, menos($t0)
				sb $t3, resultado($zero)
				
	print3:			li $v0, 4
				la $a0, num1
				syscall
				
				li $v0, 4
				la $a0, numero1
				syscall
				
				li $v0, 4
				la $a0, num2
				syscall
				
				li $v0, 4
				la $a0, numero2
				syscall
				
				li $v0, 4
				la $a0, res
				syscall
				
				li $v0, 4
				la $a0, resultado
				syscall
		
				j fin
		
fin:

				li $v0, 10
				syscall
