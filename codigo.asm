section .data
    ; Definindo variáveis que armazenam os valores de potência a serem utilizados pelos carregadores
    charger1 db 25
    charger2 db 20
    charger3 db 30
    charger4 db 50
    charger5 db 28

    ; Definindo variável do texto a ser printado no resultado
    msg db "Resultado: "
    tam equ $-msg

section .bss
    cen resb 1
    dez resb 1
    uni resb 1

section .text
    global _start

_start:

    ; Somando todos os valores
    mov al, [charger1]
    add al, [charger2]
    add al, [charger3]
    add al, [charger4]
    add al, [charger5]


    ; Separação dos dígitos

    ; A separação de cada ordem numérica (centena, dezena, unidade) vai ocorrer por meio de divisões sucessivas (uma para cada ordem) e o armazenamento de seus resultados.

    ; Separação da centena
    mov bl, 100 ; Atribui o valor 100 ao registrador 'bl' | será o divisor
    div bl ; Aqui acontece direto a divisão do registrador 'ax' pelo 'bl'

    ; A opreação da divisão retorna o quociente (resultado) e o resto. No caso acima:
        ; A centena (quociente da operação) ficou armazenada no registrador 'al'
        ; A dezena + unidade (resto da operação) ficou armazenada no registrador 'ah'

    mov [cen], al ; Aqui armazenamos as centenas | Atribui o valor do registrador 'al' à variável 'cen'
    
    ; Separação da dezena e unidade

    mov al, ah ; Primeiro temos que colocar o valor do resto no registrador 'al', que antes, com a operação anterior havia ficado no registrador 'ah'.
    mov ah, 0 ; 'Resetamos' o registrador 'ah' para o valor 0

    mov bl, 10 ; Atribui o valor 10 ao registrador 'bl' | será o divisor
    div bl ; Aqui acontece direto a divisão do registrador 'ax' (que engloba 'al' e 'ah') pelo 'bl'

    ; Atribuindo resultados às variáveis definidas anteriormente
    
    mov [dez], al ; A dezena (quociente da operação)
    mov [uni], ah  ; A unidade (resto da operação)

    ; Conversão para ASCII
    ; Agora temos a necessidade de transformar os valores das variáveis que são dados binários em caracteres ASCII. Para fazer isso, somamos 48, com isso o novo valor após a soma corresponde ao código ASCII do número/valor original que estava guardado na variável.

    add byte [cen], 48
    add byte [dez], 48 
    add byte [uni], 48 ; Detalhe: Aqui precisamos definir 'byte' na soma pois estamos somando a uma variável, que é apenas um endereço de memória (diferente dos registradores que o tamanho já é definido)
    

    ; Printando

    ; Print da mensagem de resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, tam
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









