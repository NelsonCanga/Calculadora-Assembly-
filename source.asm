.macro clear()
	
.end_macro

.macro print(%string)
	.data
	msg: .asciiz %string
	.text
	li $v0,4
	la $a0,msg
	syscall
.end_macro

.macro printValue(%string)
	.data
	msg: .asciiz %string
	.text
	li $v0,4
	la $a0,msg
	syscall
	li $v0,1
	la $a0,0($t0)
	syscall
.end_macro

.macro inputInt(%string)
	.data
	msg: .asciiz %string
	.text
	li $v0,4
	la $a0,msg
	syscall
	li $v0, 5
	syscall
	la $t0,0($v0)
.end_macro

.macro inputChar(%string)
	.data
	msg: .asciiz %string
	.text
	li $v0,4
	la $a0,msg
	syscall
	li $v0,12
	syscall
	beq $t0,0,adiciona
		la  $t7,0($v0)
	adiciona: la $t0,0($v0)
.end_macro

.macro factorial()
	li $t1,1
  	add $t2,$t0,0
    para:
    	blt $t1,$t2,fact
    		beq $t1,$t2,success
    			j fim
    	fact:
    		mul $t0,$t0,$t1
       		addi $t1,$t1,1
    		j para
	success: printValue("\n\tO factorial do número informado é ")
	pfWarning1: inputInt("\n\n\tPressione 0 para voltar ao menu: ")
		beq $t0,0,main
			j pfWarning1
	fim:
.end_macro 

.macro nPerfeito()
pfInitial:
	inputInt("\n\n\tInforme o número perfeito: ")
	li $t1,1
	for:
		blt $t1,$t0,calculo
			j verifica
	calculo:
		div $t0,$t1
		mfhi $t2 
		beq $t2,0,soma
		addi $t1,$t1,1
		blt $t1,$t0,for
		j verifica
	soma:
		add $t3,$t3,$t1
		addi $t1,$t1,1
		j for
	verifica:
		beq $t0,$t3,perfeito
	   		j imperfeito
	perfeito:
		factorial()
		j fim
	imperfeito:
   		print("\n\tO número informado não é perfeito.")
   		li $t3,0
		pfWarning2: inputInt("\n\n\tPressione 1 para informar o número novamente ou 0 para voltar ao menu: ")
		beq $t0,1,pfInitial
			beq $t0,0,main
				j pfWarning2
	fim:
.end_macro

.macro fibonacci()
fInitial:
	inputInt("\n\n\tInforme a posição da sequência: ")
	move $t4,$t0
	bgt $t4,10,invalida
		blt $t4,1,invalida
	li $t0,1
	li $t2,1
	para:
  		blt $t2,10, soma 
  			j fim
		soma:
  	 		add $t7,$t0,$t1
  	 		add $t1,$t0,0
  	 		add $t0,$t7,0
  	 		addi $t2,$t2,1
  	 		beq $t4,$t2,mostra
  	 		j para
	mostra:
		printValue("\n\tO factorial do número informado é ")
		fWarning1: inputInt("\n\n\tPressione 0 para voltar ao menu: ")
			beq $t0,0,main
				j fWarning1
	invalida:
		print("\n\tA posição informada é invalida.")
		fWarning2: inputInt("\n\n\tPressione 1 para informar a posição novamente ou 0 para voltar ao menu: ")
		beq $t0,1,fInitial
			beq $t0,0,main
				j fWarning2
	fim:
.end_macro

.macro potencia()
pInitial:
	inputInt("\n\n\tInforme a base: ")
	move $t4,$t0
	inputInt("\tInforme o expoente: ")
	move $t5,$t0
	blt $t5,0,invalida
	li $t1,1
	li $t0,1
	para:
  		ble $t1,$t5,calcular
  			j mostra
  	 	calcular:
  	 		mul $t0,$t0,$t4
  	 		addi $t1,$t1,1
  	 		j para
	mostra:
		printValue("\n\tA potência da base e do expoente informado é ")
		pWarning1: inputInt("\n\n\tPressione 0 para voltar ao menu: ")
			beq $t0,0,main
				j pWarning1
	invalida:
		print("\n\tO expoente não pode ser negativo.")
		pWarning3: inputInt("\n\n\tPressione 1 para informar a posição novamente ou 0 para voltar ao menu: ")
		beq $t0,1,pInitial
			beq $t0,0,main
				j pWarning3
	fim:
.end_macro

.macro quadrado()
qInitial:
	inputInt("\n\n\tInforme o número: ")
	move $t5,$t0
	li $t1,1
	blt $t5,0,qinvalida
	li $t0,0
	qfor:
		ble $t5,0,qverifica
			sub $t5,$t5,$t1
			addi $t1,$t1,2
			add $t0,$t0,1
			j qfor
	qverifica:
		beq $t5,0,raiz
	   		j qimperfeito
	raiz:
		printValue("\n\tA raiz quadrada do número informado é ")
		qWarning1: inputInt("\n\n\tPressione 0 para voltar ao menu: ")
			beq $t0,0,main
				j qWarning1
	qinvalida:
		print("\n\tO número não pode ser negativo.")
		qWarning4: inputInt("\n\n\tPressione 1 para informar a posição novamente ou 0 para voltar ao menu: ")
		beq $t0,1,qInitial
			beq $t0,0,main
				j qWarning4
	qimperfeito:
   		print("\n\tO número informado não é um quadrado perfeito.")
   		li $t3,0
		qWarning5: inputInt("\n\n\tPressione 1 para informar o número novamente ou 0 para voltar ao menu: ")
		beq $t0,1,qInitial
			beq $t0,0,main
				j qWarning5
	fim:
.end_macro

.globl main
	main:
		clear()
		inputInt("\n\n\t\t\t\t\t\t\tPJ - ASSEMBLY\n\n\n\t1 - Factorial Perfeito\n\t2 - Raiz Quadrada Perfeita\n\t3 - Potência\n\t4 - Fibonacci\n\t5 - Sair\n\n\tInforme a opção: ")
		beq $t0, 1, factorial
			beq $t0, 2, rQuadrada
				beq $t0, 3, potencia
					beq $t0, 4, fibonacci
						beq $t0, 5, sair
			
		factorial:
			nPerfeito()
		rQuadrada:
			quadrado()
		potencia:
			potencia()
		fibonacci:
			fibonacci()
		sair:
			li $v0, 10
			syscall
		
