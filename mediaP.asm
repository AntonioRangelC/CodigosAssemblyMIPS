.data
    quebraLinha: .asciiz "\n"
.text
    # o objetivo desse código é calcular a média ponderada
    # a primeira linha a ser lida tem a quantidade valores 
    # as próximas linhas contem os pesos e os valores
    main:
        li		$v0, 5 		        # lendo a quantidade de valores que serão usados
        syscall 
        move    $s0, $v0            # $s0 recebe a quantidade

        li      $t0, 0              # contador = 0
        li      $t1, 0
        mtc1    $t1, $f5            # soma dos pesos = 0
        mtc1    $t1, $f7            # soma dos valores = 0
    LOOP:
        beq     $t0, $s0, Exit      # if( contador == quantidade) vai para Exit

        li      $v0, 6              # lendo um peso float
        syscall

        mov.s   $f1, $f0            # $f1 recebe o peso
        add.s   $f5, $f5, $f1       # soma dos pesos = soma dos pesos + peso

        li      $v0, 6              # lendo um valor float
        syscall

        mul.s   $f3, $f3, $f1       # multiplicando o valor pelo peso
        add.s   $f7, $f7, $f3       # soma dos valores = soma dos valores + valor

        addi    $t0, $t0, 1         # contador++
        j       LOOP
    Exit:
        div.s   $f12, $f7, $f5       # soma dos valores / soma dos pesos
        li      $v0,  2
        syscall

        la     $a0, quebraLinha   
        li     $v0, 4
        syscall

        li     $v0, 10
        syscall


        