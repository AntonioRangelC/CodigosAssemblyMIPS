.data
    quebraLinha: .asciiz "\n"
.text
    main:
        li   $v0,5                # lendo primeiro inteiro
        syscall
        move $a0, $v0

        li   $v0,5                # lendo segundo inteiro
        syscall
        move $a1, $v0

        jal   multFac             # chamando a funcao

        li   $v0, 36               # imprimindo valor do HI
        mfhi $a0
        syscall

        li   $v0, 4
        la   $a0, quebraLinha
        syscall

        li   $v0, 36                # imprimindo valor de LO
        mflo $a0
        syscall

        li   $v0, 4
        la   $a0, quebraLinha
        syscall

        li   $v0, 10
        syscall

    # menos significativo: $s0      mais significativo: $s1   contador: $t1   $t0 recebe o LSB
    multFac: 
        li   $t5, 0    
        li   $t6, 0             
        slt  $t0, $a0, $zero        # se o numero for negativo, $t0 recebe 1
        beq  $t0, $zero, Else1       # se $t0, for 0, e positivo
        sub  $a0, $zero, $a0        # transformando em numero positivo
        li   $t5, 1                 # colocando uma flag
    Else1:
        slt  $t0, $a1, $zero
        beq  $t0, $zero, Else3
        sub  $a1, $zero, $a1 
        li   $t6, 1


    Else3:
        li   $t1, -1                # contador = 0
        li   $t2, 31                # aux = 31
       add   $s1, $zero, $zero      # P[63...32] = 0
      move   $s0, $a1               # P[31...0] = multiplicador
    LOOP:
        beq  $t1, $t2, Exit2        # se contador == 32, sai do loop
       addi  $t1, $t1, 1            # contador++
       andi  $t0, $s0, 1            # $t0 recebe o primeiro bit
        beq  $t0, $zero, Exit       # se o primeiro bit for 0, vai fazer o deslocamento
        add  $s1, $s1, $a0          # se o primeiro bit for 1, a parte significativa recebe o multiplicador
    Exit:
        andi $t4, $s1, 1            # se o bit menos significativo de $s1 for 1, $t0 recebe 1
        beq  $t4, $zero, Exit3
        sll  $t3, $s1, 31           # deslocando o numero 31 bits a direita para somar com a parte menos 
        srl  $s0, $s0, 1            # deslocamento a direita em 1 bit
        add  $s0, $s0, $t3          # a parte menos significativa recebe o 1 que veio da parte mais significativa
        srl  $s1, $s1, 1            # deslocamento a direita em 1 bit

        j    LOOP
    Exit3:
        srl  $s0, $s0, 1            # deslocamento a direita em 1 bit
        srl  $s1, $s1, 1            # deslocamento a direita em 1 bit

        j    LOOP                  
    Exit2:
        xor  $t5, $t5, $t6
        beq  $t5, $zero, Else2
        sub  $s0, $zero, $s0        # invertendo o sinal do resultado, porque um dos numeros � negativo
    Else2:
        mthi $s1                    # movendo $s1 para HI
        mtlo $s0                    # movendo $s0 para LO
        jr   $ra

