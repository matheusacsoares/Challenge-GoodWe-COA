section .data
    ; Definindo variáveis que armazenam os valores de potência a serem utilizados pelos carregadores
    charger1 db 10
    charger2 db 10
    charger3 db 10
    charger4 db 50
    charger5 db 15

    ; Definindo variável do texto a ser printado no resultado
    msg db "Resultado: "
    tam equ $-msg

section .bss
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



    ; Separação dos dígitos (por meio de uma divisão)
    mov bl, 10 ; Atribui o valor 10 ao registrador 'bl' | será o divisor
    div bl ; Aqui acontece direto a divisão do registrador 'ax' pelo 'bl'

    ; A opreação da divisão retorna o quociente (resultado) e o resto (se houver)
        ; A dezena (quociente da operação) ficou armazenada no registrador 'al'
        ; A unidade (resto da operação) ficou armazenada no registrador 'ah'

    ; Atribuindo resultados às variáveis definidas anteriormente
    
    mov [dez], al 
    mov [uni], ah


    ; Conversão para ASCII
    ; Agora temos a necessidade de transformar os valores das variáveis que são dados binários em caracteres ASCII. Para fazer isso, somamos 48, com isso o novo valor após a soma corresponde ao código ASCII do número/valor original que estava guardado na variável.

    add byte [dez], 48 
    add byte [uni], 48 ; Detalhe: Aqui precisamos definir 'byte' na soma pois estamos somando a uma variável, que é apenas um endereço de memória (diferente dos registradores que o tamanho já é definido)

    

    ; Printando

    ; Print da mensagem de resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, tam
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









