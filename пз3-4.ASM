format PE GUI 4.0
include 'd:\FASM\INCLUDE\win32ax.inc'

.data
    Caption db 'Результат',0
    Text db '%s',0
    buf db 100 dup(?)        ; Буфер для вывода

    num1 dd 77            ; Первое число
    num2 dd 13             ; Второе число
    num3 dd 27               ; Третье число

    msg_none db 'Нет чисел, оканчивающихся на 7',0
    msg_1 db 'Первое число (num1)',0
    msg_2 db 'Второе число (num2)',0
    msg_3 db 'Третье число (num3)',0
    msg_1_2 db 'Первое и второе',0
    msg_1_3 db 'Первое и третье',0
    msg_2_3 db 'Второе и третье',0
    msg_all db 'Все три числа',0

.code
start:
    ; Загружаем числа
    mov eax, [num1]
    mov edx, 0
    mov ecx, 10
    div ecx
    cmp edx, 7
    sete al  ; al = 1, если num1 оканчивается на 7

    mov eax, [num2]
    mov edx, 0
    div ecx
    cmp edx, 7
    sete bl  ; bl = 1, если num2 оканчивается на 7

    mov eax, [num3]
    mov edx, 0
    div ecx
    cmp edx, 7
    sete cl  ; cl = 1, если num3 оканчивается на 7

    ; Определяем, какие числа оканчиваются на 7
    test al, al
    jz check_2
    test bl, bl
    jz check_3
    test cl, cl
    jz first_two
    mov eax, msg_all
    jmp show_msg

first_two:
    mov eax, msg_1_2
    jmp show_msg

check_2:
    test bl, bl
    jz check_3
    test cl, cl
    jz second_only
    mov eax, msg_2_3
    jmp show_msg

second_only:
    mov eax, msg_2
    jmp show_msg

check_3:
    test cl, cl
    jz none_found
    test al, al
    jz third_only
    mov eax, msg_1_3
    jmp show_msg

third_only:
    mov eax, msg_3
    jmp show_msg

none_found:
    mov eax, msg_none

show_msg:
    invoke wsprintf, addr buf, addr Text, eax
    invoke MessageBox, 0, addr buf, addr Caption, MB_OK
    invoke ExitProcess, 0

.end start
