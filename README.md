# Controlador de potência - Challenge FIAP + GoodWe

## Integrantes

- Giovanna Ferreira Almeida - RM571822
- Lucas Bellezzo Figueiredo - RM569734
- Maria Luiza Vieira de Freitas - RM571535
- Matheus Arruda Camara Soares - RM571594
- Matheus Sabino da Silva Guedes - RM572907

## Problema

O carregamento simultâneo de vários veículos pode ultrapassar a capacidade máxima da rede elétrica, causando sobrecargas. Além disso, o controle dessa carga nos eletropostos geralmente usa softwares de alto nível, o que gera consumo de energia desnecessário e baixa eficiência no processamento.

## Justificativa

É fundamental reajustar a potência distribuída de forma dinâmica para proteger a rede. Fazer esse balanceamento de forma ineficiente gasta energia que deveria ser poupada. Otimizar essa matemática limitadora diretamente no hardware usando Assembly garante uma proteção instantânea à rede e reduz o consumo energético do próprio processador.

## Proposta de solução

Desenvolver um módulo em baixo nível (Assembly) para realizar o controle e o reajuste dinâmico de carga do eletroposto. O programa processa o consumo dos veículos e faz o rebalanceamento matemático de forma rápida, reduzindo drasticamente os ciclos da CPU para garantir o menor consumo energético possível no hardware embarcado.

## Arquitetura utilizada 
O projeto é construído com base na arquitetura x86-64. O controle é feito operando diretamente nos registradores de dados (como AL, BL e DL para as operações matemáticas de MUL e DIV) e registradores de ponteiros (ESI e EDI) para varrer os vetores na memória. sEssa abordagem puramente em hardware evita abstrações de software de alto nível e reduz o gasto de energias.

## Trechos relevantes do código:

**Nota:** Este código atua como uma prova de conceito para o projeto. Atualmente, os valores de consumo estão pré-definidos na memória e utilizamos rotinas de impressão apenas para a demonstração visual dos cálculos. Em uma implementação final, os dados seriam recebidos dinamicamente pelos sensores da rede de carregadores e os prints seriam removidos, garantindo o desempenho e a economia de energia máxima do hardware.

**O código desenvolvido possui 2 loops principais que resumem o funcionamento e o objetivo:**

### Loop de soma

Este loop é responsável por somar todos as potências sendo utilizadas pelos carregadores

```
loop_soma:
    add al, [esi] ; Adiciona no registrador 'AL' o valor apontado no 'ESI'
    inc esi ; Incrementa 1 no registrador de ponteiro 'ESI' | próximo carregador
    dec byte [cont] ; Decrescenta 1 na variável de contador
    cmp byte [cont], 0 ; Compara a variável de contador com '0'
    jg loop_soma ; Se o contador for > que '0' volta e roda o loop_soma novamente

```

### Loop de reajuste

Este loop é responsável por calcular o reajuste de cada potência de forma proporcional e guardar o valor reajustado.

```
limite_excedido:
    mov byte [cont], qtdCarregadores ; Reseta o contador
    mov esi, consumos ; Reseta a posição para o inicio do vetor
    
    mov bl, [potMax] ; Atribui a potência máxima no 'bl' para usar como multiplicador
    mov dl, [soma] ; Atribui a soma no 'dl' para usar como divisor

loop_reajuste:
    mov al, [esi] ; Atribui a 'al' o consumo da posição atual do vetor
    mul bl ; Multiplica pela potência máxima
    div dl ; Divide pela soma 

    mov [edi], al ; Guarda o valor reajustado no registrador 'edi'

    inc esi ; Avança para a próxima posição do vetor de consumos
    inc edi ; Avança para a próxima posição do vetor de consumos reajustados

    dec byte [cont] ; Diminui o contador
    cmp byte [cont], 0 ; Compara se o contador já é igual a 0 (quando acaba os valores/carregadores do array)
    jg loop_reajuste ; continua o loop se contador > 0 | Redireciona para loop_reajuste~

    ; saiu do loop

    jmp imprimir_resultado ; Redireciona para imprimir_resultado (se não foi redirecionado acima / saiu do loop)
```

## Impactos esperados

- **Redução de ciclos de CPU:** O código em Assembly gera menos instruções executáveis, o que diminui diretamente os ciclos de clock exigidos pelo processador.
- **Menor consumo do hardware:** A otimização do cálculo de distribuição de carga permite a utilização de microcontroladores de baixo consumo energético.
- **Proteção instantânea:** O balanceamento dinâmico executado em baixo nível reajusta as potências e evita sobrecargas na infraestrutura elétrica de forma muito mais rápida.

## Relação com sustentabilidade e energias renováveis

**Eficiência energética:** A infraestrutura de recarga opera no seu nível máximo de otimização, evitando o desperdício de recursos computacionais e poupando energia.

**Aproveitamento limpo:** Ao reduzir o consumo interno do próprio eletroposto, garantimos uma maior eficiência e melhor aproveitamento da energia gerada por fontes renováveis no ecossistema de mobilidade.