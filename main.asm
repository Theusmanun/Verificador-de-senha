.data
    prompt:    .asciiz "\n[Input] Digite a senha: "
    err_empty: .asciiz "\n[Erro] A senha nao pode ser vazia ou nula. Tente novamente.\n"
    buffer:    .space 100
    score_msg: .asciiz "\nPontuacao Final: "

.text
.globl main

main:
loop_input:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 8
    la $a0, buffer
    li $a1, 100
    syscall

    jal validar_entrada
    
    beq $v0, 0, input_invalido

    la $a0, buffer
    jal calcular_forca
    
    move $s0, $v0

    move $a0, $s0
    jal desenhar_status

    li $v0, 10
    syscall

input_invalido:
    li $v0, 4
    la $a0, err_empty
    syscall
    j loop_input

.include "analise.asm"
.include "display.asm"