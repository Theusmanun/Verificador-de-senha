.text
.globl validar_entrada
.globl calcular_forca

validar_entrada:
    lb $t0, 0($a0)
    beq $t0, 10, erro_validacao
    beq $t0, 0, erro_validacao
    
    li $v0, 1
    jr $ra

erro_validacao:
    li $v0, 0
    jr $ra

calcular_forca:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    sw $s2, 0($sp)

    move $s0, $a0
    li $s1, 0
    li $s2, 0

    li $t0, 0
    li $t1, 0
    li $t2, 0

loop_analise:
    lb $t3, 0($s0)
    beq $t3, 0, fim_loop
    beq $t3, 10, fim_loop

    addi $s2, $s2, 1
    
    blt $t3, 65, check_min
    bgt $t3, 90, check_min
    li $t0, 1
    j next_char

check_min:
    blt $t3, 97, check_spec
    bgt $t3, 122, check_spec
    li $t1, 1
    j next_char

check_spec:
    li $t2, 1

next_char:
    addi $s0, $s0, 1
    j loop_analise

fim_loop:
    bge $s2, 8, ganha_ponto_tam
    j soma_flags

ganha_ponto_tam:
    addi $s1, $s1, 2

soma_flags:
    add $s1, $s1, $t0
    add $s1, $s1, $t1
    add $s1, $s1, $t2

    ble $s1, 5, return_score
    li $s1, 5

return_score:
    move $v0, $s1

    lw $s2, 0($sp)
    lw $s1, 4($sp)
    lw $s0, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra