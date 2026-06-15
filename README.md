# ChargeGrid Intelligence

### Challenge FIAP + GoodWe 2026

Sistema inteligente para gerenciamento energético de eletropostos comerciais, com foco em eficiência energética, estabilidade da rede elétrica e integração com fontes renováveis.

---

# Integrantes

* Giovanna Ferreira Almeida - RM571822
* Lucas Bellezzo Figueiredo - RM569734
* Maria Luiza Vieira de Freitas - RM571535
* Matheus Arruda Camara Soares - RM571594
* Matheus Sabino da Silva Guedes - RM572907

---

# Índice

1. Visão Geral do Projeto
2. Problema Identificado
3. Objetivos
4. Arquitetura da Solução
5. Sprint 1 - Controle Dinâmico de Potência em Assembly

   * Funcionamento
   * Trechos do Código
   * Benefícios
6. Sprint 2 - Sistema Inteligente de Prioridade Energética

   * Circuito Lógico
   * Expressão Booleana
   * Funcionamento
   * Simulação no Tinkercad
7. Relação com Sustentabilidade
8. Resultados Obtidos
9. Demonstração
10. Tecnologias Utilizadas
11. Referências

---

# 1. Visão Geral do Projeto

O ChargeGrid Intelligence é uma proposta de sistema inteligente para gerenciamento energético de eletropostos comerciais.

A solução busca controlar a distribuição de potência entre carregadores de veículos elétricos e auxiliar a tomada de decisões energéticas utilizando informações sobre geração solar, armazenamento em baterias e condições da rede elétrica.

O objetivo é aumentar a eficiência energética da infraestrutura, reduzir desperdícios e contribuir para uma operação mais sustentável.

---

# 2. Problema Identificado

O crescimento da mobilidade elétrica aumenta continuamente a demanda por estações de recarga.

Quando vários veículos são carregados simultaneamente, a potência total demandada pode ultrapassar os limites disponíveis da infraestrutura elétrica.

Além disso, muitos sistemas realizam esse gerenciamento utilizando softwares de alto nível que exigem maior processamento computacional e consumo energético.

Os principais desafios são:

* Sobrecarga da rede elétrica;
* Distribuição ineficiente da potência disponível;
* Baixo aproveitamento da energia renovável;
* Desperdício de recursos computacionais;
* Falta de controle inteligente das cargas.

---

# 3. Objetivos

* Distribuir potência entre múltiplos carregadores;
* Evitar sobrecarga da infraestrutura elétrica;
* Priorizar o uso de energia renovável;
* Utilizar armazenamento energético quando necessário;
* Reduzir o consumo computacional do sistema de controle;
* Demonstrar a viabilidade técnica da solução através de protótipos funcionais.

---

# 4. Arquitetura da Solução

```text
          Painéis Solares
                  │
                  ▼
          Banco de Baterias
                  │
                  ▼
        Controlador Energético
                  │
      ┌───────────┴───────────┐
      │                       │
      ▼                       ▼
Controle de Potência     Sistema de Prioridade
   (Assembly)               Energética
      │                       │
      └───────────┬───────────┘
                  │
                  ▼
            Eletroposto
                  │
                  ▼
           Veículos Elétricos
```

A solução foi dividida em dois módulos principais.

---

# 5. Sprint 1 - Controle Dinâmico de Potência em Assembly

## Objetivo

Controlar a distribuição de potência entre carregadores ativos, evitando que a demanda total ultrapasse a capacidade máxima da rede elétrica.

---

## Funcionamento

O algoritmo monitora o consumo dos carregadores conectados.

Quando a soma das potências ultrapassa o limite definido para a instalação, o sistema realiza automaticamente um reajuste proporcional da potência distribuída para cada carregador.

Esse procedimento evita sobrecargas sem interromper completamente as sessões de recarga.

---

## Arquitetura Utilizada

O código foi desenvolvido para arquitetura x86-64.

A implementação utiliza diretamente registradores como:

* AL
* BL
* DL
* ESI
* EDI

A manipulação direta dos registradores reduz abstrações de software e diminui a quantidade de instruções executadas pelo processador.

---

## Trechos Relevantes

### Loop de Soma

Responsável por calcular a potência total demandada.

```assembly
loop_soma:
    add al, [esi]
    inc esi
    dec byte [cont]
    cmp byte [cont], 0
    jg loop_soma
```

### Loop de Reajuste

Responsável por redistribuir a potência proporcionalmente.

```assembly
loop_reajuste:
    mov al, [esi]
    mul bl
    div dl

    mov [edi], al

    inc esi
    inc edi

    dec byte [cont]
    cmp byte [cont], 0
    jg loop_reajuste
```

---

## Benefícios

* Menor número de ciclos de CPU;
* Menor consumo energético do hardware;
* Resposta rápida para situações críticas;
* Possibilidade de execução em dispositivos embarcados de baixo consumo.

---

# 6. Sprint 2 - Sistema Inteligente de Prioridade Energética

## Objetivo

Determinar quando uma fonte complementar de energia pode ser utilizada para auxiliar a operação do eletroposto.

---

## Expressão Booleana

Expressão original:

S = D · ((A + B) · (C̅ + A))

Expressão simplificada:

S = D(A + BC̅)

---

## Variáveis

| Variável | Significado                         |
| -------- | ----------------------------------- |
| A        | Energia Solar Disponível            |
| B        | Bateria Disponível                  |
| C        | Horário de Pico                     |
| D        | Necessidade de Energia Complementar |
| S        | Fonte Complementar Autorizada       |

---

## Funcionamento

O circuito analisa simultaneamente:

* disponibilidade de energia solar;
* disponibilidade da bateria;
* horário de pico da rede;
* necessidade de energia adicional.

A saída é ativada apenas quando as condições energéticas são adequadas para utilização da fonte complementar.

---

## Circuito Implementado

Componentes utilizados:

* 4 entradas digitais;
* 1 porta NOT;
* 2 portas AND;
* 1 porta OR;
* 1 LED de saída.

### Circuito no Tinkercad

<img width="1014" height="691" alt="Captura de tela 2026-06-15 162944" src="https://github.com/user-attachments/assets/77cc7d57-0180-479b-8e83-f54db783b6ba" />


### Tabela Verdade

<img width="205" height="359" alt="Captura de tela 2026-06-11 160745" src="https://github.com/user-attachments/assets/fe48cdb9-a253-4073-aa12-5123c4b7b2e8" />

---

## Simulação

Durante os testes foram avaliados diferentes cenários:

### Cenário 1

* Energia solar disponível
* Necessidade de energia complementar

Resultado:

Fonte complementar autorizada.

### Cenário 2

* Sem energia solar
* Bateria disponível
* Fora do horário de pico

Resultado:

Fonte complementar autorizada.

### Cenário 3

* Sem energia solar
* Horário de pico

Resultado:

Fonte complementar bloqueada.

---

# 7. Relação com Sustentabilidade

A solução contribui para:

* melhor aproveitamento da energia solar;
* utilização inteligente de armazenamento energético;
* redução de desperdícios;
* gerenciamento eficiente da demanda;
* maior estabilidade da rede elétrica.

Além disso, a utilização de algoritmos otimizados em Assembly reduz o consumo computacional do sistema de controle.

---

# 8. Resultados Obtidos

Os protótipos desenvolvidos demonstraram a viabilidade técnica da proposta.

Resultados observados:

* distribuição automática de potência;
* prevenção de sobrecargas;
* tomada de decisão energética baseada em condições reais;
* redução da complexidade computacional;
* integração entre gerenciamento de carga e fontes renováveis.

---

# 9. Demonstração

### Vídeo

https://youtu.be/NVhbX1RP8ec

### Projeto Tinkercad

https://www.tinkercad.com/things/6ze0Bsg7X4t-sers-coa-challenge-fiap-goodwe-2026-sprint-2

---

# 10. Tecnologias Utilizadas

* Assembly x86-64
* Tinkercad
* Circuitos Lógicos Digitais
* Álgebra Booleana
* GitHub

---

# 11. Referências

* GoodWe Technologies
* Material das disciplinas de Arquitetura de Computadores
* Material das disciplinas de Soluções em Energias Renováveis e Sustentáveis
* Documentação Intel x86-64
