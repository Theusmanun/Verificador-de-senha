.data
    prompt:       .asciiz "\n[Input] Digite a senha: "
    err_empty:    .asciiz "\n[Erro] A senha nao pode ser vazia ou nula. Tente novamente.\n"
    buffer:       .space 100
    score_msg:    .asciiz "\nPontuacao Final: "

.text
.globl main

main:
    # --- TRATAMENTO DE ERRO (Input Loop) ---
loop_input:
    # 1. Imprimir Prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # 2. Ler String
    li $v0, 8
    la $a0, buffer
    li $a1, 100
    syscall

    # 3. Validar Entrada (Verifica se é só \n)
    # $a0 ja tem o buffer
    jal validar_entrada   
    
    # Retorno em $v0: 1 = Valido, 0 = Invalido
    beq $v0, 0, input_invalido

    # --- PROCESSAMENTO ---
    la $a0, buffer        # Passa endereço da senha
    jal calcular_forca    # Retorna pontuação em $v0
    
    move $s0, $v0         # Salva pontuação em $s0 para não perder

    # --- SAÍDA VISUAL ---
    move $a0, $s0         # Passa pontuação para função de desenho
    jal desenhar_status

    # Encerrar o programa aqui para não "cair" nas funções abaixo acidentalmente
    li $v0, 10
    syscall

input_invalido:
    li $v0, 4
    la $a0, err_empty
    syscall
    j loop_input          # Volta para pedir senha

# --- INCLUSAO DOS MÓDULOS ---
# O MARS vai ler esses arquivos como se estivessem escritos aqui.
# Garanta que os arquivos analise.asm e display.asm estao na mesma pasta.
.include "analise.asm"
.include "display.asm"