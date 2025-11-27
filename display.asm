.data
    str_bar: .asciiz "#"
    str_dot: .asciiz "."
    str_l:   .asciiz "["
    str_r:   .asciiz "]"

.text
desenhar_status:
    move $t0, $a0
    li $t1, 5
    sub $t1, $t1, $t0

    li $v0, 4
    la $a0, str_l
    syscall

loop_preenchido:
    blez $t0, loop_vazios
    li $v0, 4
    la $a0, str_bar
    syscall
    addi $t0, $t0, -1
    j loop_preenchido

loop_vazios:
    blez $t1, fim_desenho
    li $v0, 4
    la $a0, str_dot
    syscall
    addi $t1, $t1, -1
    j loop_vazios

fim_desenho:
    li $v0, 4
    la $a0, str_r
    syscall
    
    li $v0, 11
    li $a0, 10
    syscall

    jr $ra