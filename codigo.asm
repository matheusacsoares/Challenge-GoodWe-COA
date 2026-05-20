section .data
    ; Definindo um 'array' que armazena os valores de potência a serem utilizados pelos carregadores
    consumos db 40, 50, 30, 20, 60
    qtdCarregadores equ $-consumos


    ; Definindo variável de limite máximo de potência a ser utilizada
    potMax db 150

    ; Definindo variável do texto a ser printado 
    msgOriginais db "Potência Original: "
    tam_originais equ $-msgOriginais

    msgReajustadas db "Potência Reajustada: "
    tam_reajustadas equ $-msgReajustadas

    ;msgPotMax db "Potência Máxima da rede: "
    ;tam equ $-msgPotMa

    ;msgPotSom db "Consumo máximo de potência: "
    ;tam equ $-msgPotSom

    msgContador db "Carregador: "
    tam_contador equ $-msgContador

    separador db "============================", 10
    tam_separador equ $-separador

    quebraLinha db 10

section .bss
    consumosReajustados resb qtdCarregadores

    soma resb 1
    cont resb 1
    contText resb 1
    cen resb 1
    dez resb 1
    uni resb 1

    dif resb 1

section .text
    global _start

_start:
    mov al, 0
    mov byte [cont], qtdCarregadores
    mov esi, consumos
    mov edi, consumosReajustados

loop_soma:
    add al, [esi]
    inc esi
    dec byte [cont]
    cmp byte [cont], 0
    jg loop_soma


    mov [soma], al ; Atribui o resultado das somas na variável soma

    ; COMPARAÇÃO SOMA COM POTÊNCIA MÁXIMA
    
    cmp al, [potMax] ; aqui 'al' tem o valor da soma
    jg limite_excedido

    jmp imprimir_resultado


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

       ; mov [consumosReajustados], edi ; Atribui os valores guardados no registrador 'edi' à variável de consumos reajustados
    jmp imprimir_resultado ; Redireciona para imprimir_resultado (se não foi redirecionado acima / saiu do loop)

    
; Separação dos dígitos
imprimir_resultado:

    mov byte [cont], qtdCarregadores ; Reseta o contador
    mov esi, consumos ; Reseta a posição que aponta do vetor original 
    mov edi, consumosReajustados ; Reseta a posição que aponta do vetor de reajustados 

loop_imprimir:

    ; Print do contador / carregador referente
    mov al, [cont]
    mov byte [contText], al
    add byte [contText], 48

    mov eax, 4
    mov ebx, 1
    mov ecx, msgContador
    mov edx, tam_contador
    int 0x80

    mov eax, 4
    mov ecx, contText
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, quebraLinha
    mov edx, 1
    int 0x80


    
    ; PROCESSAMENTO VALOR ORIGINAL

    mov al, [esi]
    
    mov ah, 0 ; Reseta 'ah'
    mov bl, 10 ; Atribui à 'bl' o valor 10 que será o divisor

    ; Separando a unidade

    div bl ; divide ax por bl
    mov [uni], ah ; salva a unidade que foi extraida (como resto da divisão) na variável

    ; Separando a dezena e a centena

    mov ah, 0 ; Reseta 'ah'
    div bl ; divide ax por bl
    mov [dez], ah ; salva a dezena que foi extraida (como resto da divisão) na variável
    mov [cen], al ; salva a centena que foi extraida (como resultado da divisão) na variável

    ; Conversão para ASCII
    ; Agora temos a necessidade de transformar os valores das variáveis que são dados binários em caracteres ASCII. Para fazer isso, somamos 48, com isso o novo valor após a soma corresponde ao código ASCII do número/valor original que estava guardado na variável.

    add byte [cen], 48
    add byte [dez], 48 
    add byte [uni], 48 ; Detalhe: Aqui precisamos definir 'byte' na soma pois estamos somando a uma variável, que é apenas um endereço de memória (diferente dos registradores que o tamanho já é definido)

    ; Printando 

    ; Print da mensagem de potência original
    mov eax, 4
    mov ebx, 1
    mov ecx, msgOriginais
    mov edx, tam_originais
    int 0x80

    ; Print da centena
    mov eax, 4
    mov ecx, cen
    mov edx, 1
    int 0x80

    ; Print da dezena
    mov eax, 4
    mov ecx, dez
    mov edx, 1
    int 0x80

    ; Print da unidade
    mov eax, 4
    mov ecx, uni
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, quebraLinha
    mov edx, 1
    int 0x80



    ; PROCESSAMENTO VALOR REAJUSTADO

    mov al, [edi]
    
    mov ah, 0 ; Reseta 'ah'
    mov bl, 10 ; Atribui à 'bl' o valor 10 que será o divisor

    ; Separando a unidade

    div bl ; divide ax por bl
    mov [uni], ah ; salva a unidade que foi extraida (como resto da divisão) na variável

    ; Separando a dezena e a centena

    mov ah, 0 ; Reseta 'ah'
    div bl ; divide ax por bl
    mov [dez], ah ; salva a dezena que foi extraida (como resto da divisão) na variável
    mov [cen], al ; salva a centena que foi extraida (como resultado da divisão) na variável

    ; Conversão para ASCII
    ; Agora temos a necessidade de transformar os valores das variáveis que são dados binários em caracteres ASCII. Para fazer isso, somamos 48, com isso o novo valor após a soma corresponde ao código ASCII do número/valor original que estava guardado na variável.

    add byte [cen], 48
    add byte [dez], 48 
    add byte [uni], 48 ; Detalhe: Aqui precisamos definir 'byte' na soma pois estamos somando a uma variável, que é apenas um endereço de memória (diferente dos registradores que o tamanho já é definido)

    ; Printando 

    ; Print da mensagem de potência reajustada
    mov eax, 4
    mov ebx, 1
    mov ecx, msgReajustadas
    mov edx, tam_reajustadas
    int 0x80

    ; Print da centena
    mov eax, 4
    mov ecx, cen
    mov edx, 1
    int 0x80

    ; Print da dezena
    mov eax, 4
    mov ecx, dez
    mov edx, 1
    int 0x80

    ; Print da unidade
    mov eax, 4
    mov ecx, uni
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, quebraLinha
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, separador
    mov edx, tam_separador
    int 0x80

    ; Atualizando posições e contador
    inc esi
    inc edi
    dec byte [cont]

    cmp byte [cont], 0
    jg loop_imprimir

mov eax, 1
mov ebx, 0
int 0x80
