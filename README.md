# ChargeGrid Intelligence
### Challenge FIAP + GoodWe 2026

Sistema inteligente para gerenciamento energético de eletropostos, com foco em eficiência energética, estabilidade da rede elétrica e integração com fontes renováveis.

---

## Integrantes

- Giovanna Ferreira Almeida - RM571822
- Lucas Bellezzo Figueiredo - RM569734
- Maria Luiza Vieira de Freitas - RM571535
- Matheus Arruda Camara Soares - RM571594
- Matheus Sabino da Silva Guedes - RM572907

---

## 🔗 Navegação Rápida

[Visão Geral](#visão-geral-do-projeto) •
[Assembly](#sprint-1---controle-dinâmico-de-potência-em-assembly) •
[Circuito Lógico](#sprint-2---sistema-inteligente-de-prioridade-energética) •
[Sustentabilidade](#relação-com-sustentabilidade) •
[Vídeo](#demonstração)

---

# Índice

- [Visão Geral do Projeto](#visão-geral-do-projeto)
- [Problema Identificado](#problema-identificado)
- [Objetivos](#objetivos)
- [Arquitetura da Solução](#arquitetura-da-solução)
- [Sprint 1 - Controle Dinâmico de Potência em Assembly](#sprint-1---controle-dinâmico-de-potência-em-assembly)
  - [Objetivo](#objetivo)
  - [Funcionamento](#funcionamento)
  - [Arquitetura Utilizada](#arquitetura-utilizada)
  - [Trechos Relevantes do Código](#trechos-relevantes-do-código)
  - [Benefícios](#benefícios)
- [Sprint 2 - Sistema Inteligente de Prioridade Energética](#sprint-2---sistema-inteligente-de-prioridade-energética)
  - [Expressão Booleana](#expressão-booleana)
  - [Variáveis](#variáveis)
  - [Funcionamento do Circuito](#funcionamento-do-circuito)
  - [Circuito Implementado](#circuito-implementado)
  - [Simulações Realizadas](#simulações-realizadas)
- [Relação com Sustentabilidade](#relação-com-sustentabilidade)
- [Resultados Obtidos](#resultados-obtidos)
- [Demonstração](#demonstração)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Referências](#referências)

---

# Visão Geral do Projeto

O ChargeGrid Intelligence é uma proposta de sistema inteligente para gerenciamento energético de eletropostos comerciais.

A solução foi desenvolvida para auxiliar o controle da potência distribuída entre veículos elétricos e otimizar o uso dos recursos energéticos disponíveis, buscando reduzir desperdícios e aumentar a eficiência da infraestrutura.

Para isso, o projeto foi dividido em dois módulos complementares:

- Controle Dinâmico de Potência em Assembly;
- Sistema Inteligente de Prioridade Energética utilizando Circuitos Lógicos.

---

# Problema Identificado

O crescimento da mobilidade elétrica aumenta a demanda por pontos de recarga.

Quando vários veículos realizam carregamento simultaneamente, a potência exigida pode ultrapassar a capacidade da instalação elétrica, causando riscos à infraestrutura e reduzindo a eficiência do sistema.

Além disso, sistemas de controle mal otimizados podem consumir recursos computacionais desnecessários, aumentando o consumo energético do próprio hardware responsável pelo gerenciamento.

---

# Objetivos

- Evitar sobrecargas na infraestrutura elétrica;
- Distribuir potência de forma inteligente entre carregadores;
- Priorizar o uso de fontes renováveis;
- Melhorar o aproveitamento energético;
- Reduzir o consumo computacional do sistema de controle;
- Demonstrar a viabilidade técnica da solução através de protótipos funcionais.

---

# Arquitetura da Solução

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

O sistema utiliza um módulo responsável pelo gerenciamento da potência distribuída e outro responsável pela tomada de decisões energéticas baseadas nas condições da rede e das fontes renováveis.

---

# Sprint 1 - Controle Dinâmico de Potência em Assembly

## Objetivo

Desenvolver um algoritmo capaz de monitorar o consumo dos carregadores e redistribuir a potência disponível quando a demanda ultrapassar os limites da instalação.

---

## Funcionamento

O programa simula diversos carregadores conectados simultaneamente.

Primeiramente é realizada a soma de todos os consumos.

Caso o valor total ultrapasse a potência máxima permitida, o sistema recalcula automaticamente a potência atribuída a cada carregador, realizando um balanceamento proporcional.

Dessa forma a infraestrutura permanece protegida sem interromper totalmente as sessões de recarga.

---

## Arquitetura Utilizada

O projeto foi desenvolvido utilizando Assembly x86-64.

O controle é realizado diretamente através de registradores como:

- AL
- BL
- DL
- ESI
- EDI

Essa abordagem reduz abstrações de software de alto nível e diminui a quantidade de instruções executadas pelo processador.

---

## Trechos Relevantes do Código

### Loop de Soma

Responsável por calcular a potência total utilizada.

```assembly
loop_soma:
    add al, [esi]
    inc esi
    dec byte [cont]
    cmp byte [cont], 0
    jg loop_soma
```

### Loop de Reajuste

Responsável por recalcular a potência distribuída para cada carregador.

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

- Menor quantidade de ciclos de CPU;
- Menor consumo energético do hardware;
- Resposta rápida para situações críticas;
- Possibilidade de utilização em sistemas embarcados de baixo consumo.

---

# Sprint 2 - Sistema Inteligente de Prioridade Energética

## Objetivo

Determinar quando uma fonte complementar de energia pode ser utilizada para auxiliar a operação do eletroposto.

---

## Expressão Booleana

Expressão original:

```text
S = D · ((A + B) · (C̅ + A))
```

Expressão simplificada:

```text
S = D(A + BC̅)
```

<img width="479" height="194" alt="Captura de tela 2026-06-11 160806" src="https://github.com/user-attachments/assets/ac4cd00c-92f9-4e99-b5bb-e716aa75d060" />


---

## Variáveis

| Variável | Significado |
|-----------|-----------|
| A | Energia Solar Disponível |
| B | Banco de Baterias Disponível |
| C | Horário de Pico |
| D | Necessidade de Energia Complementar |
| S | Fonte Complementar Autorizada |

---

## Funcionamento do Circuito

O circuito monitora a disponibilidade de energia renovável, o armazenamento em baterias e as condições da rede elétrica.

Quando o sistema detecta necessidade de energia complementar, a lógica avalia se existem condições adequadas para utilização dessa energia.

Essa decisão permite complementar o carregamento dos veículos sem comprometer a estabilidade da rede.

---

## Circuito Implementado

Componentes utilizados:

- 4 entradas digitais (DIP Switches);
- 1 porta NOT;
- 2 portas AND;
- 1 porta OR;
- 1 LED indicador de saída;
- Painel solar representativo.

### Circuito no Tinkercad

<img width="1014" height="691" alt="Captura de tela 2026-06-15 162944" src="https://github.com/user-attachments/assets/19edc774-20a1-431c-b398-da9820d4354c" />

### Tabela Verdade

<img width="205" height="359" alt="Captura de tela 2026-06-11 160745" src="https://github.com/user-attachments/assets/666e73e3-bb0c-4e10-8483-a103a18930a8" />


### Projeto Tinkercad

https://www.tinkercad.com/things/6ze0Bsg7X4t-sers-coa-challenge-fiap-goodwe-2026-sprint-2

---

## Simulações Realizadas

### Cenário 1

- Energia solar disponível;
- Necessidade de energia complementar.

Resultado:

✅ Fonte complementar autorizada.

---

### Cenário 2

- Sem energia solar;
- Bateria disponível;
- Fora do horário de pico.

Resultado:

✅ Fonte complementar autorizada.

---

### Cenário 3

- Sem energia solar;
- Horário de pico.

Resultado:

❌ Fonte complementar bloqueada.

---

# Relação com Sustentabilidade

A solução desenvolvida está alinhada aos conceitos de eficiência energética e energias renováveis.

O módulo Assembly reduz o consumo computacional do sistema de controle, enquanto o circuito lógico prioriza o uso de energia solar e armazenamento energético quando disponíveis.

Os principais benefícios são:

- Melhor aproveitamento da energia renovável;
- Redução de desperdícios;
- Maior eficiência operacional;
- Menor impacto sobre a rede elétrica;
- Infraestrutura de recarga mais sustentável.

---

# Resultados Obtidos

Os protótipos desenvolvidos demonstraram a viabilidade técnica da proposta.

Foi possível validar:

- Distribuição dinâmica de potência;
- Proteção contra sobrecargas;
- Tomada de decisão energética baseada em lógica digital;
- Integração entre gerenciamento de carga e fontes renováveis;
- Aplicação prática dos conceitos estudados durante o semestre.

---

# Demonstração

## Vídeo

https://youtu.be/NVhbX1RP8ec

## Projeto Tinkercad

https://www.tinkercad.com/things/6ze0Bsg7X4t-sers-coa-challenge-fiap-goodwe-2026-sprint-2

---

# Tecnologias Utilizadas

- Assembly x86-64
- Circuitos Lógicos Digitais
- Álgebra Booleana
- Tinkercad
- GitHub

---

# Referências

- GoodWe Technologies
- Intel x86-64 Documentation
- Material das disciplinas de Arquitetura de Computadores
- Material das disciplinas de Soluções em Energias Renováveis e Sustentáveis
