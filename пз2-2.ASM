                                      format PE GUI 4.0
include 'd:\FASM\INCLUDE\win32ax.inc'

.data
    Caption db 'Результат', 0
    Text db 'Количество четных чисел: %d', 0
    buf db 100 dup(?)
    num1 dd 4          ; Первое число
    num2 dd 7          ; Второе число
    num3 dd 10         ; Третье число
    count dd 0         ; Счётчик чётных чисел

.code
start:
    ; Проверяем num1 на чётность
    mov eax, [num1]
    test eax, 1        ; Проверка младшего бита (чётность)
    jnz check_num2     ; Если нечётное, пропускаем увеличение
    inc dword [count]  ; Увеличиваем счётчик

check_num2:
    mov eax, [num2]
    test eax, 1
    jnz check_num3
    inc dword [count]

check_num3:
    mov eax, [num3]
    test eax, 1
    jnz show_result
    inc dword [count]

show_result:
    ; Выводим количество чётных чисел
    invoke wsprintf, addr buf, addr Text, [count]
    invoke MessageBox, 0, addr buf, addr Caption, MB_OK

    invoke ExitProcess, 0

.end start