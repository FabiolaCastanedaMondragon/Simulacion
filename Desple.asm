.model small                     ; Define el modelo de memoria como peque?o
.stack                           ; Reservar espacio para la pila
.data                            ; Secci?n de datos

u db 0                          ; Variable para la unidad (d?gito de las unidades)
d db 0                          ; Variable para la decena (d?gito de las decenas)
n db 0                          ; Variable para el n?mero final

mensaje db 10,13,7, "Ingrese un numero",'$'  ; Mensaje para solicitar un n?mero
mensaje2 db 10,13,7, "Numero ingresado",'$'  ; Mensaje para mostrar el n?mero ingresado

.code                            ; Secci?n de c?digo
main proc                        ; Inicio del procedimiento principal
mov ax, SEG @data               ; Cargar la direcci?n del segmento de datos en AX
mov ds, ax                      ; Configurar DS para que apunte al segmento de datos

mov ah,09h                      ; Funci?n 09h para mostrar cadena de caracteres
lea dx,mensaje                  ; Cargar la direcci?n del mensaje en DX
int 21h                         ; Llamar a la interrupci?n para mostrar el mensaje

mov ah,01h                      ; Funci?n 01h para leer un car?cter
int 21h                         ; Llamar a la interrupci?n para leer un car?cter
sub al,30h                      ; Convertir el car?cter ASCII a valor num?rico (restar '0')
mov d,al                        ; Almacenar el d?gito de las decenas en 'd'

mov ah,01h                      ; Volver a preparar la lectura de otro car?cter
int 21h                         ; Leer el siguiente car?cter
sub al,30h                      ; Convertir el car?cter ASCII a valor num?rico
mov u,al                        ; Almacenar el d?gito de las unidades en 'u'

mov al,d                        ; Cargar el valor de las decenas en AL
mov bl,10                       ; Cargar 10 en BL para multiplicar por 10
mul bl                         ; Multiplicar AL (decena) por BL (10), resultado en AX
add al,u                        ; Sumar el valor de las unidades a AL (d?gito final)
mov n,al                        ; Almacenar el n?mero final en 'n'

mov ah,09h                      ; Preparar para mostrar el mensaje del n?mero ingresado
lea dx, mensaje2                ; Cargar la direcci?n del segundo mensaje en DX
int 21h                         ; Llamar a la interrupci?n para mostrar el mensaje

mov al,n                        ; Cargar el n?mero final en AL
AAM                             ; Convertir AL a formato BCD (decimales en AX)
mov bx,ax                       ; Mover el resultado (d?gitos BCD) a BX
mov ah,02h                      ; Funci?n 02h para mostrar un car?cter
mov dl,bh                       ; Cargar el d?gito de las decenas (BH) en DL
add dl,30h                      ; Convertir el d?gito a car?cter ASCII
int 21h                         ; Mostrar el car?cter (decenas)
mov ah,02h                      ; Preparar para mostrar el siguiente car?cter
mov dl,bl                       ; Cargar el d?gito de las unidades (BL) en DL
add dl,30h                      ; Convertir el d?gito a car?cter ASCII
int 21h                         ; Mostrar el car?cter (unidades)

main endp                       ; Fin del procedimiento principal

end main                        ; Fin del programa
