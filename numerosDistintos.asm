.data
    vetor: .word 1, 1, 2, 3
.text
    main:
        la   $a0, vetor
        li   $a1,  4
       jal   elemDistintos
      move   $t0, $v0

        li   $v0, 1
      move   $a0, $t0
      syscall

      li     $v0, 10
      syscall

#int vetor[7] = {13}, qtd = 1,i,j,igual=0,contador=0;
#    for(i=0; i<qtd; i++){
#        for(j= i+1; j<qtd && igual == 0; j++){
#            if(vetor[i] == vetor[j]){
#                igual = 1;
#            }
#        }
#        if(igual==0){
#            contador++;
#        }
#        igual = 0;
#    }
#    printf("%d\n", contador);
#Objetivo: fazer uma funçao que retorne o numero de elementos distintos de um vetor

    elemDistintos:
    #$s0 = i     $s1 = j    $s2 = igual   $s3 = contador $a0 = vetor[0]  $a1 = qtd
    li    $s0, -1              # i  = -1
    li    $s2, 0               # igual = 0
    li    $s3, 0               # contador = 0

    LOOP1:
   addi   $s0, $s0, 1          # i++
    beq   $s0, $a1, Exit       # if(i == qtd) sai do for
   addi   $s1, $s0, 1          # j = i + 1

    LOOP2:
    beq   $s1, $a1, DESVIO1    # if( j == qtd) sai do segundo for
    bne   $s2, $zero, DESVIO1  # if(igual != 0) sai do segundo for
    add   $t0, $a0, $s0        # $t0 recebe o endereço de vetor[i]
    add   $t1, $a0, $s1        # $t1 recebe o endereço de vetor[j]
     lw   $t2, 0($t0)          # $t2 recebe o numero da posicao vetor[i]
     lw   $t3, 0($t1)          # $t3 recebe o numero da posicao vetor[j]
    bne   $t2, $t3, ELSE       # if(vetor[i] != vetor[j]) 
     li   $s2, 1               # igual = 1

    ELSE: 
    addi  $s1, $s1, 1          # j++
    j     LOOP2

    DESVIO1:
     bne  $s2, $zero, DESVIO2  # if( igual != 0) 
    addi  $s3, $s3, 1          # contador++

    DESVIO2:
    li   $s2, 0                # igual = 0
    j     LOOP1

    Exit:
    add   $v0, $s3, $zero      # armazenando o valor do contador em $v0
    jr     $ra                  # return
