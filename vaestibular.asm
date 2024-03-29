.data
    quebraLinha: .asciiz "\n"
    gabarito: .space 1000
    candidato: .space 1000
.text
main:
    #$s0 = i   $s1 = contador  $s2 = quantidade  $a0 = gabarito  $a2 = candidato
    add   $s0, $zero, $zero   # i = 0
    add   $s1, $zero, $zero   # contador = 0
    li	  $v0, 5              # Lendo quantidade de questoes
    syscall
    move  $s2, $v0            # $s2 recebe a quantidade
    
    li    $v0, 8
    la    $a0, gabarito       # Lendo a string gabarito
    li    $a1, 1000
    syscall

    li    $v0, 8              
    la    $a2, candidato      # Lendo a string candidato
    li    $a3, 1000
    syscall

L1:
    beq   $s0, $s2, Exit      # if(i == quantidade) sair
    add   $t0, $s0, $a0       # $t0 tem o endere�o de gabarito[i]
    add   $t1, $s0, $a2       # $t1 tem o endere�o de candidato[i]
    lbu   $t2, 0($t0)         # $t2 recebe o caracter de gabarito[i]
    lbu   $t3, 0($t1)         # $t3 recebe o caracter de candidato[i]
    bne   $t2, $t3, Else      # if(contador[i] != gabarito[i])
    addi  $s1, $s1, 1         # contador++
    Else:
    addi  $s0, $s0, 1              # i++
    j     L1

Exit:
    li   $v0, 1               # imprimindo o contador
    add  $a0, $s1, $zero
    syscall             

    li   $v0, 4
    la   $a0, quebraLinha     #imprimindo \n
    syscall

    li   $v0, 10
    syscall
    