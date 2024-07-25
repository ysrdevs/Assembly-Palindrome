Data Segment

str1 db 'abba','$'
strlen1 equ $-str1

strrev db 20 dup(' ')
str_palind db ' The word is a Palindrome.','$'
str_not_palin db ' The word is not a Palindrome.','$'

Data Ends

Code Segment

Assume cs:code, ds:data

Begin:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; Initialize pointers
    lea si, str1
    lea di, strrev

    ; Initialize length
    mov cx, strlen1

    ; Reverse the string
Reverse_Loop:
    mov al, [si + cx - 2]
    mov [di], al
    inc di
    loop Reverse_Loop

    ; Add null terminator to reversed string
    mov byte ptr [di], '$'

    ; Check if the string is a palindrome
    lea si, str1
    lea di, strrev

    mov cx, strlen1
    repe cmpsb

    ; Output result
    jne Not_Palind
    Palind:
        mov ah, 09h
        lea dx, str_palind
        int 21h
        jmp Exit

    Not_Palind:
        mov ah, 09h
        lea dx, str_not_palin
        int 21h

Exit:
    mov ax, 4c00h
    int 21h

Code Ends
End Begin
