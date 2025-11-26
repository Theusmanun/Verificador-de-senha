.data
    str_bar:  .asciiz "#"
    str_dot:  .asciiz "."
    str_l:    .asciiz "["
    str_r:    .asciiz "]"

.text
# ------------------------------------------------------------------
# SUB-ROTINA: desenhar_status
# Entrada: $a0 (score 0-5)
# Não retorna valor.
# ------------------------------------------------------------------
desenhar_status:
    move $t0, $a0        # $t0 = Pontos (preenchidos)
    li $t1, 5            
    sub $t1, $t1, $t0    # $t1 = Vazios (5 - pontos)

    # Imprime '['
    li $v0, 4
    la $a0, str_l
    syscall

loop_preenchido:
    blez $t0, loop_vazios
    li $v0, 4
    la $a0, str_bar      # Imprime "##"
    syscall
    addi $t0, $t0, -1
    j loop_preenchido

loop_vazios:
    blez $t1, fim_desenho
    li $v0, 4
    la $a0, str_dot      # Imprime ".."
    syscall
    addi $t1, $t1, -1
    j loop_vazios

fim_desenho:
    # Imprime ']'
    li $v0, 4
    la $a0, str_r
    syscall
    
    # Imprime quebra de linha
    li $v0, 11
    li $a0, 10
    syscall

    jr $ra