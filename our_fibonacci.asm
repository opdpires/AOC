.data
	prompt: .asciiz "Digite um numero para obter o termo correspondente na serie de Fibonacci: "
	message: .asciiz "Resultado: "
        warning: .asciiz "\nAperte uma tecla para sair"
	
.text

main:
    #Guarda o stack frame e o endereço de retorno para o S.O.
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    #Inicialização ($s0 = n)
    addi $s0, $0, 0
	
    #Imprimir mensagem na tela pedindo um valor ao usuário
    li $v0, 4
    la $a0, prompt
    syscall
	
    #Resgatar o valor inserido pelo usuario
    li $v0, 5
    syscall
	
    #Armazenar o valor lido em um registrador
    move $s0, $v0
	
    #Preparar e realizar chamada da funcao fib
    addi $a0, $s0, 0
    jal fib
	
    #Armazenar valor de retorno da funcao
    add $t0, $v0, 0
	
    #Mostrar mensagem indicando que o resultado sera mostrado em seguida
    li $v0, 4
    la $a0, message
    syscall
	
    #Imprimir resultado contendo o valor do termo n da sequencia de fibonacci
    li $v0, 1
    move $a0, $t0
    syscall
	
    #Recuperar o endereco de retorno e o apontador da pilha
    lw $ra, 0($sp)
    addi $sp, $sp, 4
	
    #imprimir aviso para sair do prompt
    li $v0, 4
    la $a0, warning
    syscall
	
    #Espera o usuario inserir um valor e depois retorna ao sistema operacional
    li $v0, 12
    syscall
    #jr $ra
	
    #No MARS, nao podemos retornar ao sistema operacional, entao fazemos uma finalizacao forcada
    li $v0 10
    syscall
	
fib:
    #salvamento de contexto
    addi $sp, $sp, -12
    sw $ra, 8($sp)
    sw $s1, 4($sp)
    sw $a0, 0($sp)

    #Se o argumento for menor ou igual a 1, retorna com o valor do argumento
    #Em assembly, usamos a logica invertida para saltos condicionais
    #Entao avaliamos se e maior que 2, e se for, fara um salto para o bloco do else
    addi $t0, $0, 2
    slt $t0, $a0, $t0
    beq $t0, $0, else
	
    #executa o return n
    add $v0, $0, $a0
    addi $sp, $sp, 12	#recupera $sp da stack
    jr $ra			#retorna a funcao chamadora
	
    else: #executa chamada recursiva
        addi $a0, $a0, -1	#referenciando o termo anterior da sequencia
	jal fib			#faz a primeira chamada recursiva
	addi $s1, $v0, 0	#armazena o termo (n-1) em $s1
	lw $a0, 0($sp)		#recupera $a0 da stack
	addi $a0, $a0, -2	#referenciando o termo anterior ao anterior da sequencia
	jal fib			#faz a segunda chamada recursiva
	add $v0, $s1, $v0	#faz a soma dos dois valores de retorno
	lw $s1, 4($sp)		#recupera $s1 da stack
	lw $ra, 8($sp)		#recupera $ra da stack
				#nao e necessario recuperar $a0, porque nao sera mais utilizado
	addi $sp, $sp, 12	#recupera $sp da stack
	jr $ra			#retorna a funcao chamadora