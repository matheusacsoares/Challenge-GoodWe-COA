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

## Impactos esperados

- **Redução de ciclos de CPU:** O código em Assembly gera menos instruções executáveis, o que diminui diretamente os ciclos de clock exigidos pelo processador.
- **Menor consumo do hardware:** A otimização do cálculo de distribuição de carga permite a utilização de microcontroladores de baixo consumo energético.
- **Proteção instantânea:** O balanceamento dinâmico executado em baixo nível reajusta as potências e evita sobrecargas na infraestrutura elétrica de forma muito mais rápida.

## Relação com sustentabilidade e energias renováveis

**Eficiência energética:** A infraestrutura de recarga opera no seu nível máximo de otimização, evitando o desperdício de recursos computacionais e poupando energia.

**Aproveitamento limpo:** Ao reduzir o consumo interno do próprio eletroposto, garantimos uma maior eficiência e melhor aproveitamento da energia gerada por fontes renováveis no ecossistema de mobilidade.