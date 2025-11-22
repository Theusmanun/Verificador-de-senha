.text
.globl validar_entrada
.globl calcular_forca

# ------------------------------------------------------------------
# SUB-ROTINA: validar_entrada
# Verifica se a string tem caracteres uteis (não é só \n ou nula)
# Retorna $v0 = 1 (OK) ou 0 (Erro)
# ------------------------------------------------------------------
validar_entrada:
    lb $t0, 0($a0)               # Lê primeiro char
    beq $t0, 10, erro_validacao  # Se for \n (ASCII 10)
    beq $t0, 0, erro_validacao   # Se for Null
    
    li $v0, 1           # Sucesso
    jr $ra

erro_validacao:
    li $v0, 0           # Falha
    jr $ra

# ------------------------------------------------------------------
# SUB-ROTINA: calcular_forca
# Analisa complexidade. Usa registradores salvos ($s) conforme regra.
# ------------------------------------------------------------------
calcular_forca:
    # PRÓLOGO (Salva contexto)
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)      # Endereço string
    sw $s1, 4($sp)      # Score acumulado
    sw $s2, 0($sp)      # Tamanho

    move $s0, $a0       # $s0 recebe argumento
    li $s1, 0           # Score inicial = 0
    li $s2, 0           # Tamanho = 0

    # Flags temporárias ($t0=Upper, $t1=Lower, $t2=Special)
    li $t0, 0
    li $t1, 0
    li $t2, 0

loop_analise:
    lb $t3, 0($s0)          # Lê char
    beq $t3, 0, fim_loop    # Null terminator
    beq $t3, 10, fim_loop   # Newline

    addi $s2, $s2, 1        # Incrementa tamanho
    
    # Verifica Maiuscula (65-90)
    blt $t3, 65, check_min
    bgt $t3, 90, check_min
    li $t0, 1               # Flag Upper OK
    j next_char

check_min:
    # Verifica Minuscula (97-122)
    blt $t3, 97, check_spec
    bgt $t3, 122, check_spec
    li $t1, 1               # Flag Lower OK
    j next_char

check_spec:
    # Se nao é letra, considera especial/numero
    li $t2, 1

next_char:
    addi $s0, $s0, 1
    j loop_analise

fim_loop:
    # SOMATÓRIO DOS PONTOS
    # Se tamanho >= 8, +1 ponto
    bge $s2, 8, ganha_ponto_tam
    j soma_flags
ganha_ponto_tam:
    addi $s1, $s1, 2        # Tamanho vale 2 pontos neste modelo

soma_flags:
    add $s1, $s1, $t0       # +1 se teve Maiuscula
    add $s1, $s1, $t1       # +1 se teve Minuscula
    add $s1, $s1, $t2       # +1 se teve Especial

    # Limita score maximo a 5 (opcional)
    ble $s1, 5, return_score
    li $s1, 5

return_score:
    move $v0, $s1           # Retorno em $v0

    # EPÍLOGO (Restaura contexto)
    lw $s2, 0($sp)
    lw $s1, 4($sp)
    lw $s0, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
