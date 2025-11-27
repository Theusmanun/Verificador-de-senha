#  Verificador de Força de Senha em MIPS Assembly

> **Disciplina:** INFRAESTRUTURA DE HARDWARE
> **Ambiente:** MARS (MIPS Assembler and Runtime Simulator)

##  Autores
Este projeto foi desenvolvido com excelência técnica por:
* **Gustavo Queque**
* **Matheus Melquiades**
* **Jorge Tadeu Filho**

---

##  Sobre o Projeto
Este software é uma implementação de baixo nível de um algoritmo de **análise heurística de senhas**. Diferente de validações simples, nosso sistema interpreta a complexidade da entrada do usuário em tempo real e fornece um feedback visual imediato.

O objetivo principal não é apenas validar uma string, mas demonstrar o **domínio completo da arquitetura MIPS**, especificamente no gerenciamento manual de memória (Pilha/Stack), convenção de chamadas de sub-rotinas e manipulação de bytes.

##  Funcionalidades Principais

O sistema avalia a senha com base em critérios de segurança da informação, atribuindo uma pontuação de **0 a 5**:

1.  **Análise de Caracteres:**
    * Detecta Letras Maiúsculas (`A-Z`).
    * Detecta Letras Minúsculas (`a-z`).
    * Detecta Números e Caracteres Especiais (Símbolos).
2.  **Verificação de Extensão:**
    * Bonificação automática para senhas com 8 ou mais caracteres.
3.  **Feedback Visual (HUD):**
    * Renderiza uma barra de progresso dinâmica no console (ex: `[###..]`), permitindo leitura instantânea da força da senha.
4.  **Validação de Entrada:**
    * Sistema robusto que rejeita inputs nulos ou vazios antes do processamento.

---

##  Destaques Técnicos (Estrutura e Pilha)

Este projeto foi desenhado seguindo as melhores práticas de programação em Assembly:

* **Gerenciamento de Pilha (`$sp`):** O código implementa corretamente o *Stack Frame* na função `calcular_forca`, salvando registradores `$s` e o endereço de retorno `$ra` para garantir a integridade dos dados entre chamadas aninhadas.
* **Modularização:** O código é dividido em responsabilidades claras:
    * `validar_entrada`: Sanatização de dados.
    * `calcular_forca`: Lógica de negócio e pontuação.
    * `desenhar_status`: Camada de apresentação (UI).
* **Eficiência de Registradores:** Uso otimizado de registradores temporários (`$t`) para cálculos voláteis e registradores salvos (`$s`) para persistência de dados críticos.

---

##  Critérios de Pontuação

O algoritmo utiliza uma lógica acumulativa. A senha começa com Score 0 e ganha pontos conforme atende aos requisitos:

| Critério Atendido | Pontuação |
| :--- | :--- |
| **Comprimento ≥ 8** | +2 Pontos |
| **Contém Maiúscula** | +1 Ponto |
| **Contém Minúscula** | +1 Ponto |
| **Contém Especial/Num**| +1 Ponto |
| **TOTAL MÁXIMO** | **5 Pontos** |

---

##  Como Executar

1.  Baixe o simulador **MARS**.
2.  Abra o arquivo principal (`.asm`) do projeto.
3.  Certifique-se de que os módulos estão no mesmo diretório (ou use a versão unificada do código).
4.  Pressione **F3** (Assemble) para montar o código.
5.  Pressione **F5** (Run) para executar.
6.  Digite as senhas no console inferior para testar.

---

##  Exemplos de Teste

Para validar a precisão do algoritmo, sugerimos os seguintes testes:

* `senha` ➔ Fraca `[#....]` (Só minúsculas, curta)
* `SENHA` ➔ Fraca `[#....]` (Só maiúsculas, curta)
* `Senha123` ➔ Forte `[#####]` (Maiúscula, minúscula, número, 8+ chars)
* `abc` ➔ Fraca `[#....]`
* `[Enter Vazio]` ➔ Erro tratado (Mensagem de aviso exibida)

---

> *Projeto desenvolvido para fins educacionais, demonstrando a robustez e a complexidade do Assembly MIPS.*