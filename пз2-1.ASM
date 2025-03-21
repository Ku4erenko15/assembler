format PE GUI 4.0
include 'd:\FASM\INCLUDE\win32ax.inc'

.data
    Caption db '?acoeuoao', 0
    Text db 'Iiaia cia?aiea x2 = %d', 0
    buf db 100 dup(?)
    x1 dd 100         ; Ia?aia ?enei
    x2 dd 1           ; Aoi?ia ?enei

.code
start:
    ; I?iaa?ea oneiaey x2 * x2 < x1
    mov eax, [x2]      ; Caa?o?aai x2
    imul eax, eax      ; Eaaa?ao x2
    cmp eax, [x1]      ; N?aaieaaai n x1
    jge skip           ; Anee x2^2 >= x1, i?iioneaai eciaiaiea

    ; Oaaee?eaaai x2 a 6 ?ac
    mov eax, [x2]
    imul eax, 6
    mov [x2], eax      ; Nio?aiyai iiaia cia?aiea

    ; Auaia ?acoeuoaoa oieuei anee x2 eciaieeny
    invoke wsprintf, addr buf, addr Text, eax
    invoke MessageBox, 0, addr buf, addr Caption, MB_OK

skip:
    invoke ExitProcess, 0

.end start