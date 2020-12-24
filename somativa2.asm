.data
    quebraLinha: .asciiz "\n" 
    bitParidade: .asciiz "bit-paridade: " 
    saida:       .asciiz "saida: "        
    incorreta:   .asciiz "entrada incorreta\n"  
.text
    # O objetivo desse codigo e fazer uma paridade par dos numeros inseridos, ou seja, se o numero tiver uma quantidade impar de
    # 1s, o numero recebe mais 1 no comeco, para a quantidade ficar par. Caso contrario, colocar um 0 no comeco do numero. 
    main:
        li    $v0, 5               # lendo o numero
        syscall
        move  $s0, $v0             # movendo para $s0
        bltz  $s0, entradaIncorreta # se o numero for menor que 0
        li    $t4, 127              
        slt   $t5, $t4, $s0         # se o numero for maior que 127
        beq   $t5, $zero, Else
    entradaIncorreta:
        li    $v0, 4
        la    $a0, incorreta
        syscall
        j     Exit2
    Else:
        add   $s1, $s0, $zero      # s1 recebe uma copia do numero
        add   $s2, $s0, $zero      # s2 recebe uma copia do numero
        li    $t2, 0               # contador de 1s
    LOOP:
        beq   $s0, $zero, Exit
        andi  $t3, $s0, 1          # se o primeiro bit for 1, $t3 recebe 1
        beq   $t3, $zero, Else1    # se t3 for 0, vai pro else
        addi  $t2, $t2, 1          # se for 1, contador de 1 é incrementado
    Else1:
        sll   $s0, $s0, 1          # deslocando o numero em 1 bit a esquerda
        j     LOOP
    Exit:
        sll   $t2, $t2, 7          # o ultimo bit de um numero impar e 1, entao estou deslocando a esquerda
                                   # para checar esse ultimo bit
        andi  $t0, $t2, 1          # se o bit for 1, t0 recebe 1
        beq   $t0, $zero, Else2    # se t0 for 0, o numero e par
        addi  $s1, $s1, 128        # adicionando o bit 1 no comeco
        li    $v0, 4              
        la    $a0, bitParidade
        syscall

        li    $v0, 1
        add   $a0, $t0, $zero      # imprimindo o bit de paridade
        syscall

        li    $v0, 4
        la    $a0, quebraLinha
        syscall

        li    $v0, 4
        la    $a0, saida
        syscall

        li    $v0, 1
        add   $a0, $s1, $zero      # imprimindo o resultado
        syscall

        li    $v0, 4
        la    $a0, quebraLinha
        syscall

        j      Exit2

    Else2:
        li    $v0, 4
        la    $a0, bitParidade
        syscall

        li    $v0, 1
        add   $a0, $t0, $zero       # imprimindo o bit de paridade
        syscall

        li    $v0, 4
        la    $a0, quebraLinha
        syscall
        
        li    $v0, 4
        la    $a0, saida
        syscall

        li    $v0, 1
        add   $a0, $s1, $zero       # imprimindo o resultado
        syscall        

        li    $v0, 4
        la    $a0, quebraLinha
        syscall
    Exit2:
        li    $v0, 10
        syscall