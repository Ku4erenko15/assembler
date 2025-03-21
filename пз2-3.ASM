format PE GUI 4.0
include 'd:\FASM\INCLUDE\win32ax.inc'

.data
    Caption db 'Результат игры',0
    Text db '%s',0
    buf db 100 dup(?)        ; Буфер для вывода

    score db 3               ; Задаём очки (0, 1 или 3)

    win_msg db 'Выигрыш',3
    draw_msg db 'Ничья',1
    lose_msg db 'Проигрыш',0

.code
start:
    ; Проверяем количество очков
    mov al, [score]
    cmp al, 0
    je set_lose
    cmp al, 1
    je set_draw
    cmp al, 3
    je set_win
    jmp exit                 ; На случай ошибки (но её не будет)

set_win:
    mov eax, win_msg
    jmp show_msg

set_draw:
    mov eax, draw_msg
    jmp show_msg

set_lose:
    mov eax, lose_msg
    jmp show_msg

show_msg:
    invoke wsprintf, addr buf, addr Text, eax
    invoke MessageBox, 0, addr buf, addr Caption, MB_OK

exit:
    invoke ExitProcess, 0

.end start
